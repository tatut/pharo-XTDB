"
I wrap a raw XTDB API response without any mapping.
The response instance variable holds the API response object read from EDN.
"
Class {
	#name : #XtRawResponse,
	#superclass : #Object,
	#instVars : [
		'response'
	],
	#category : #XTDB
}

{ #category : #'as yet unclassified' }
XtRawResponse class >> populate: aRawResponse from: anObject [
	aRawResponse response: anObject
]

{ #category : #accessing }
XtRawResponse class >> xtMapping [
	^ self
]

{ #category : #accessing }
XtRawResponse >> response [

	^ response
]

{ #category : #accessing }
XtRawResponse >> response: anObject [

	response := anObject
]
