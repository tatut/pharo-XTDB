"
I represent a where clause that binds an entity attribute value to a logic variable.
"
Class {
	#name : #XtWhereBindEA,
	#superclass : #XtWhereNode,
	#instVars : [
		'e',
		'a',
		'lvar'
	],
	#category : #'XTDB-Query'
}

{ #category : #'as yet unclassified' }
XtWhereBindEA >> e: entity a: attr lvar: lv [
	e := entity.
	a := attr.
	lvar := lv.
]

{ #category : #rendering }
XtWhereBindEA >> render [
	^ { e . a . lvar } asOrderedCollection 
]
