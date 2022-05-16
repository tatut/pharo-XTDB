Class {
	#name : #XtOrderedMapping,
	#superclass : #XtMapping,
	#category : #XTDB
}

{ #category : #'as yet unclassified' }
XtOrderedMapping class >> xtPopulate: obj from: coll [
	obj addAll: coll
]
