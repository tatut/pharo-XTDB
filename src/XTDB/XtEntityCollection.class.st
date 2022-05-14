"
I am a virtual collection of stored instances of a given class.

I support a subset of the Collection protocol:

- select: build and execute query based block criteria
- detect: return 1 instance matching the given block


"
Class {
	#name : #XtEntityCollection,
	#superclass : #Object,
	#instVars : [
		'entityClass',
		'client',
		'results'
	],
	#category : #XTDB
}

{ #category : #accessing }
XtEntityCollection >> client [

	^ client
]

{ #category : #accessing }
XtEntityCollection >> client: anObject [

	client := anObject
]

{ #category : #accessing }
XtEntityCollection >> entityClass [

	^ entityClass
]

{ #category : #accessing }
XtEntityCollection >> entityClass: anObject [

	entityClass := anObject
]

{ #category : #accessing }
XtEntityCollection >> results [

	^ results
]

{ #category : #accessing }
XtEntityCollection >> results: anObject [

	results := anObject
]

{ #category : #enumerating }
XtEntityCollection >> select: aBlock [
	"Select instances that match predicate block."
	self buildQuery: aBlock.
	
]
