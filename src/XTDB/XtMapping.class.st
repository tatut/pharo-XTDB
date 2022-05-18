"
I am the base class for mappings. Don't instantiate me directly.

Mappings provide a way to map values to/from XTDB.

"
Class {
	#name : #XtMapping,
	#superclass : #Object,
	#category : #XTDB
}

{ #category : #'as yet unclassified' }
XtMapping >> asXtPullPattern [
	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
XtMapping >> xtPopulate: anObject from: aDictionary [
	self subclassResponsibility 
]
