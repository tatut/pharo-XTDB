Class {
	#name : #XtEntityPredicateAttrRef,
	#superclass : #Object,
	#instVars : [
		'entity',
		'attribute',
		'predicateBuilder'
	],
	#category : #XTDB
}

{ #category : #comparing }
XtEntityPredicateAttrRef >> = otherObject [ 
	"Add EAV pattern"
	predicateBuilder addEquals: entity attr: attribute value: otherObject
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
  | param |
  param := predicateBuilder addIn: aLuceneSearchString.
	predicateBuilder addWhere: 
		{ LinkedList withAll: { #'text-search' . attribute . param } .
		  OrderedCollection with: (OrderedCollection with: #e) } asOrderedCollection 
]
