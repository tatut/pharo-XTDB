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
	"Get (creating it if necessary) the ZnClient instance."
	znClient ifNil: [ znClient := ZnClient new ].
	^ znClient
]

{ #category : #parsing }
XtClient >> parseResponse: response as: aClass [
	| edn obj |
	edn := EDNReader new in: response asString readStream; read.
	obj := aClass new.
	aClass xtMapping populate: obj from: edn. 
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

{ #category : #accessing }
XtClient >> status [ 
	"Fetch the XTDB node status"
	^ self getRequest: 'status' with: {} as: XtStatus  
]

{ #category : #accessing }
XtClient >> url: baseURL [
	"Set the XTDB server base URL"
	url := baseURL
]
