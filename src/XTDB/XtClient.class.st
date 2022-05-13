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
XtClient >> entity: entityId [
	"Fetch entity by id"
]

{ #category : #accessing }
XtClient >> getRequest: path with: queryParameters as: aResultClass [
	"Issue GET request to XTDB with given parameters"
	| requestUrl |
	requestUrl := String streamContents: [:out |
		out << url; << path.
		queryParameters doWithIndex: [ :i :param |
		    i = 1 ifTrue: [ out << '?' ] ifFalse: [ out << '&' ].
			out << param key; << param value.
	    ]].
	self getZnClient 
	   	  accept: 'application/edn'
	  get: requestUrl
]

{ #category : #accessing }
XtClient >> getZnClient [
	"Get (creating it if necessary) the ZnClient instance."
	znClient ifNil: [ znClient := ZnClient new ].
	^ znClient
]

{ #category : #accessing }
XtClient >> url: baseURL [
	"Set the XTDB server base URL"
	url := baseURL
]
