"
I am the XTDB client main entrypoint class. 
Initialize me with the base URL that points to the XTDB HTTP server.

I provide methods that to run queries and issue transactions.
"
Class {
	#name : #XtClient,
	#superclass : #Object,
	#instVars : [
		'url',
		'znClient'
	],
	#category : #XTDB
}

{ #category : #accessing }
XtClient >> entity: id [
	"Fetch an entity by id. Answer with an XtEntity instance."
	| eid |
	eid := String streamContents: [ :out | id writeEDNTo: out ].
	^ self getRequest: 'entity' with: { 'eid-edn' -> eid } as: XtEntity  
	

]

{ #category : #accessing }
XtClient >> entity: id as: aClass [
	"Fetch an entity by id as an instance of aClass."
	| eid |
	eid := String streamContents: [ :out | id writeEDNTo: out ].
	^ self getRequest: 'entity' with: { 'eid-edn' -> eid } as: aClass  
	

]

{ #category : #accessing }
XtClient >> getRequest: path with: queryParameters as: aResultClass [
	"Issue GET request to XTDB with given parameters"
	| requestUrl response |
	requestUrl := String streamContents: [:out |
		out << url; << path.
		queryParameters doWithIndex: [ :param :i |
		    i = 1 ifTrue: [ out << '?' ] ifFalse: [ out << '&' ].
			out << param key; << '='; << param value.
	    ]].
	response := self getZnClient 
	  accept: 'application/edn';
	  get: requestUrl.
	^ self parseResponse: response as: aResultClass
]

{ #category : #accessing }
XtClient >> getZnClient [
	"Get the ZnClient instance."
	 ^ ZnClient new 
]

{ #category : #'as yet unclassified' }
XtClient >> instancesOf: anEntityClass [
	"Return a virtual collection of instances that of the given class.
	The collection supports a subset of the Collection protocols."
	^ XtEntityCollection new 
	    client: self;
	    entityClass: anEntityClass; yourself  
]

{ #category : #parsing }
XtClient >> parseResponse: response as: aClass [
	| edn obj |
	edn := EDNReader new in: response asString readStream; read.
	obj := aClass new.
	aClass xtMapping xtPopulate: obj from: edn. 
  ^ obj

	
]

{ #category : #'as yet unclassified' }
XtClient >> populateFields: anObject from: aDictionary mapping: aMappingDictionary [
	"Populate fields of anObject from aDictionary using aMappingDictionary
	to translate keys in aDictionary to setter method names."
	aMappingDictionary keysAndValuesDo: [ :key :value |
		(aDictionary includes: key) ifTrue: [ 
			anObject perform: value with: (aDictionary at: key)
		]
	]
]

{ #category : #'as yet unclassified' }
XtClient >> populateFieldsByName: anObject from: aDictionary [
	Error signal: 'Not implemented yet, use xtMapping for now.'
]

{ #category : #'as yet unclassified' }
XtClient >> q: aBlock [
	"Build and execute query, returns raw response."
	| qb |
	qb := XtQueryBuilder new.
	aBlock value: qb.
	^ qb executeOn: self
]

{ #category : #'as yet unclassified' }
XtClient >> q: anEntityClass matching: aPredicateBlock [
	"Query instances of an entity class that match a predicate."
	| qb eb mapping where |
	qb := XtQueryBuilder new.
	qb result: (XtEntityPullMapping new entityClass: anEntityClass). 
	mapping := anEntityClass xtMapping.
	eb := XtEntityPredicateBuilder new 
	  entity: #e;
	  queryBuilder: qb;
	  entityClass: anEntityClass;
	  mapping: mapping.
	qb pull: #e attrs: mapping asXtPullPattern. 
  where := aPredicateBlock value: eb.
  "Add entity discriminator, if present"
  mapping entityDiscriminator ifNotNil: [ :ed |
	  where := XtWhereAnd new add: ed asXtWhereClause; add: where; yourself ].
  where := where simplify.
	Transcript show: (String streamContents: [:out | where renderToplevel writeEDNTo: out]); cr.
	qb setWhere: where renderToplevel.
	qb setIn: where allInParameters.
	^ qb executeOn: self
]

{ #category : #accessing }
XtClient >> query: aBlock [
	"Build and execute a query.
	aBlock is called with an XtQueryBuilder instance."	
	
]

{ #category : #accessing }
XtClient >> status [ 
	"Fetch the XTDB node status"
	^ self getRequest: 'status' with: {} as: XtStatus  
]

{ #category : #printing }
XtClient >> store: anEntity [
	"Store the given entity instance. Will recursively store any owned child entities.
	Creates new UUID entity ids for new documents."
	| builder payload response |
	builder := XtDocumentBuilder new.
	builder build: anEntity.
	payload := String streamContents: [ :out |
		EDNWriter new out: out; 
		 write: (Dictionary new
		          at: #':tx-ops' put: (builder documents collect: [ :d | 
		OrderedCollection with: #':xtdb.api/put' with: d ] as: OrderedCollection); yourself) ].
	response := self getZnClient
		accept: 'application/edn';
		url: url,'submit-tx';
		entity: (EDNEntity with: payload);
		post.
	^ self parseResponse: response as: XtTxInfo 

]

{ #category : #accessing }
XtClient >> url: baseURL [
	"Set the XTDB server base URL"
	url := baseURL
]
