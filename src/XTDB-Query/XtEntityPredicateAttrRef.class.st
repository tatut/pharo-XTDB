Class {
	#name : #XtEntityPredicateAttrRef,
	#superclass : #Object,
	#instVars : [
		'entity',
		'attribute',
		'predicateBuilder'
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
	^ self nodeWithId: (XtWhereEAV new e: entity a: attribute v: otherObject; yourself)
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
XtEntityPredicateAttrRef >> textSearch: aLuceneSearchString [
  ^ self nodeWithId: (XtWhereTextSearch new e: #e a: attribute v: aLuceneSearchString; yourself)

]

{ #category : #'as yet unclassified' }
XtEntityPredicateAttrRef >> wherePredicateNode: op [
	^ self nodeWithId: (XtWherePredicate new operation: op; e: entity )
]

{ #category : #'as yet unclassified' }
XtEntityPredicateAttrRef >> wherePredicateNode: op value: val [
  | lvar |
  lvar := #v,predicateBuilder nextIndex asString.
	^ XtWhereAnd new 
		add: (XtWhereBindEA new e: entity a: attribute lvar: lvar; yourself);
		add: (self nodeWithId: (XtWherePredicate new predicate: op lvar: lvar val: val));
		yourself
]
