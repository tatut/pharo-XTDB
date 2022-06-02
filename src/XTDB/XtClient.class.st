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
		'txId'
	],
	#category : #XTDB
}

{ #category : #accessing }
XtClient >> atTxId: aTxId [ 
	"Return new version of client with txId set."
	| newClient |
	newClient := self copy.
	newClient txId: aTxId.
	^ newClient
]

{ #category : #'as yet unclassified' }
XtClient >> awaitTx: aTxId [
	^ self getRequest: 'await-tx' with: { 'tx-id' -> aTxId asString } as: XtTxInfo. 
]

{ #category : #printing }
XtClient >> delete: anEntity [
	"Delete the entity (and all owned child items recursively)."
	| builder |
	builder := XtDeletionBuilder new.
	builder build: anEntity.
	^ self submitTx: 
		(builder ids collect: [ :d | 
			OrderedCollection with: #':xtdb.api/delete' with: d ] as: OrderedCollection).
		
]

{ #category : #printing }
XtClient >> deleteAndWait: anEntity [
	"Delete the entity (and all owned child items recursively)."
	^ self awaitTx: (self delete: anEntity) txId 
]

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
	requestUrl := url asZnUrl.
	requestUrl addPathSegment: path.
	queryParameters do: [ :param |
		requestUrl queryAt: (param key) add: (param value)
	].
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
	edn := XtEDNReader new in: response asString readStream; read.
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
XtClient >> q: anEntityClass [
	"Create a new query builder for the given entity class."
	^ XtQueryBuilder new
		xtClient: self;
		entityClass: anEntityClass;
		yourself

]

{ #category : #'as yet unclassified' }
XtClient >> q: anEntityClass by: fieldAccessor value: value [
	"Query instances of an entity class that match a predicate."
	^ self q: anEntityClass where: [ :e | (e perform: fieldAccessor) = value ]
]

{ #category : #'as yet unclassified' }
XtClient >> q: anEntityClass where: aPredicateBlock [
	"Query instances of an entity class that match a predicate."
	^ XtQueryBuilder new 
		entityClass: anEntityClass;
		xtClient: self;
		where: aPredicateBlock;
		execute
		
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
	| builder |
	builder := XtDocumentBuilder new.
	builder build: anEntity.
	^ self submitTx: 
		(builder documents collect: [ :d | 
		  OrderedCollection with: #':xtdb.api/put' with: d ] as: OrderedCollection)

]

{ #category : #printing }
XtClient >> storeAndWait: anEntity [
	"Store and wait for the tx to be indexed."
	^ self awaitTx: (self store: anEntity) txId
]

{ #category : #printing }
XtClient >> submitTx: txOps [
	"Delete the entity (and all owned child items recursively)."
	| payload response |
	payload := String streamContents: [ :out |
		EDNWriter new out: out; 
		 write: (Dictionary new at: #':tx-ops' put: txOps; yourself) ].
	"Transcript show: 'TX: ', payload; cr."
	response := self getZnClient
		accept: 'application/edn';
		url: url,'submit-tx';
		entity: (EDNEntity with: payload);
		post.
	^ self parseResponse: response as: XtTxInfo 

]

{ #category : #accessing }
XtClient >> txId [ 
 ^ txId
]

{ #category : #accessing }
XtClient >> txId: aTxId [
	txId := aTxId.
]

{ #category : #accessing }
XtClient >> url: baseURL [
	"Set the XTDB server base URL"
	url := baseURL
]
