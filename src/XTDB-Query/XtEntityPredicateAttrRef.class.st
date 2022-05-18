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
XtEntityPredicateAttrRef >> = otherObject [ 
	"Add EAV pattern"
	^ self whereNode: (XtWhereEAV new e: entity a: attribute v: otherObject; yourself)
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
XtEntityPredicateAttrRef >> predicateBuilder: anObject [

	predicateBuilder := anObject
]

{ #category : #'as yet unclassified' }
XtEntityPredicateAttrRef >> textSearch: aLuceneSearchString [
  ^ self whereNode: (XtWhereTextSearch new e: #e a: attribute v: aLuceneSearchString; yourself)

]

{ #category : #'as yet unclassified' }
XtEntityPredicateAttrRef >> whereNode: aNode [
	aNode id: predicateBuilder nextId.
	^ aNode
]
