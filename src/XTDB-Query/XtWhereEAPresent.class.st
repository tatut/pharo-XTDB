"
A where clause that just checks an attribute is present
in the entity. Doesn't bind the value to anything.
Useful as an entity type discriminator.
"
Class {
	#name : #XtWhereEAPresent,
	#superclass : #XtWhereNode,
	#instVars : [
		'e',
		'a'
	],
	#category : #'XTDB-Query'
}

{ #category : #'as yet unclassified' }
XtWhereEAPresent >> e: entity a: attr [
	e := entity.
	a := attr
]

{ #category : #rendering }
XtWhereEAPresent >> render [
	^ OrderedCollection with: e with: a
]
