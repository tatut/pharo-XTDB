Class {
	#name : #XtWhereEAV,
	#superclass : #XtWhereNode,
	#instVars : [
		'e',
		'a',
		'v'
	],
	#category : #'XTDB-Query'
}

{ #category : #'as yet unclassified' }
XtWhereEAV >> e: entity a: attr v: val [
	"Set the EAV triple values"
	e := entity.
	a := attr.
	v := val
]

{ #category : #'as yet unclassified' }
XtWhereEAV >> inParameters [ 
  ^ { (self inName: 'p') -> v }
]

{ #category : #rendering }
XtWhereEAV >> render [	
  ^ { e . a . self inName: 'p' } asOrderedCollection 
]
