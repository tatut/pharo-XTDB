"
I represent a predicate comparison between a logic variable (lvar) and an in parameter value (v).
"
Class {
	#name : #XtWherePredicate,
	#superclass : #XtWhereNode,
	#instVars : [
		'predicate',
		'lvar',
		'v'
	],
	#category : #'XTDB-Query'
}

{ #category : #'as yet unclassified' }
XtWherePredicate >> inParameters [
	^ { (self inName: 'p') -> v }
]

{ #category : #'as yet unclassified' }
XtWherePredicate >> predicate: aPredicateName lvar: aLogicVar val: aValue [
	predicate  := aPredicateName.
	lvar := aLogicVar.
	v := aValue.
]

{ #category : #rendering }
XtWherePredicate >> render [
	^ OrderedCollection with:
	  (LinkedList withAll: { predicate . lvar . self inName: 'p' })
]
