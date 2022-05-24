Class {
	#name : #XtEntityPredicateAttrRef,
	#superclass : #Object,
	#instVars : [
		'entity',
		'attribute',
		'predicateBuilder',
		'initialNode'
	],
	#category : #'XTDB-Query'
}

{ #category : #comparing }
XtEntityPredicateAttrRef >> < otherObject [ 
	^ self wherePredicateNode: #< value: otherObject 
]

{ #category : #comparing }
XtEntityPredicateAttrRef >> <= otherObject [ 
	^ self wherePredicateNode: #<= value: otherObject 
]

{ #category : #comparing }
XtEntityPredicateAttrRef >> = otherObject [ 
	"Add EAV pattern"
	^ self wrap: (self nodeWithId: (XtWhereEAV new e: entity a: attribute v: otherObject; yourself))
]

{ #category : #comparing }
XtEntityPredicateAttrRef >> > otherObject [ 
	^ self wherePredicateNode: #> value: otherObject 
]

{ #category : #comparing }
XtEntityPredicateAttrRef >> >= otherObject [ 
	^ self wherePredicateNode: #>= value: otherObject 
]

{ #category : #accessing }
XtEntityPredicateAttrRef >> attribute: anObject [

	attribute := anObject
]

{ #category : #accessing }
XtEntityPredicateAttrRef >> entity: anObject [

	entity := anObject
]

{ #category : #accessing }
XtEntityPredicateAttrRef >> initialNode: anObject [

	initialNode := anObject
]

{ #category : #'as yet unclassified' }
XtEntityPredicateAttrRef >> nodeWithId: aNode [
	aNode id: predicateBuilder nextIndex asString.
	^ aNode
]

{ #category : #accessing }
XtEntityPredicateAttrRef >> predicateBuilder: anObject [

	predicateBuilder := anObject
]

{ #category : #'as yet unclassified' }
XtEntityPredicateAttrRef >> startsWith: aPrefixString [
  "Match entities where this attribute starts with the given string. 
  NOTE: this is case sensitive as it directly uses indexes.
  Use textSearch: for a more general purpose search."
	| lvar min max |
	lvar := #v,predicateBuilder nextIndex asString.
	min := aPrefixString.
	max := aPrefixString allButLast, (aPrefixString last asInteger + 1) asCharacter asString. 
  ^ self wrap: (XtWhereAnd new 
		add: (XtWhereBindEA new e: entity a: attribute lvar: lvar; yourself);
		add: (self nodeWithId: (XtWherePredicate new predicate: #>= lvar: lvar val: min));
		add: (self nodeWithId: (XtWherePredicate new predicate: #< lvar: lvar val: max));
		yourself)
]

{ #category : #'as yet unclassified' }
XtEntityPredicateAttrRef >> textSearch: aLuceneSearchString [
  ^ self wrap: (self nodeWithId: (XtWhereTextSearch new e: entity a: attribute v: aLuceneSearchString; yourself))

]

{ #category : #'as yet unclassified' }
XtEntityPredicateAttrRef >> wherePredicateNode: op [
	^ self wrap: (self nodeWithId: (XtWherePredicate new operation: op; e: entity ))
]

{ #category : #'as yet unclassified' }
XtEntityPredicateAttrRef >> wherePredicateNode: op value: val [
  | lvar |
  lvar := #v,predicateBuilder nextIndex asString.
	^ self wrap: (XtWhereAnd new 
		add: (XtWhereBindEA new e: entity a: attribute lvar: lvar; yourself);
		add: (self nodeWithId: (XtWherePredicate new predicate: op lvar: lvar val: val));
		yourself)
]

{ #category : #'as yet unclassified' }
XtEntityPredicateAttrRef >> wrap: aNode [
	"Wrap a node with initial node, if any"
	initialNode ifNil: [ ^ aNode ].
	^ XtWhereAnd new add: initialNode; add: aNode; yourself
]
