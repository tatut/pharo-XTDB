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
