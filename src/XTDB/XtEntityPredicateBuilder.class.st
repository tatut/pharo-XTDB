Class {
	#name : #XtEntityPredicateBuilder,
	#superclass : #Object,
	#instVars : [
		'queryBuilder',
		'entityClass',
		'mapping'
	],
	#category : #XTDB
}

{ #category : #'reflective operations' }
XtEntityPredicateBuilder >> doesNotUnderstand: aMessage [
	"Proxy getters"
	| attr |
	attr := mapping attributeFor: aMessage selector.
	^ XtEntityPredicateAttrRef new entity: #e; attribute: attr; yourself
]

{ #category : #accessing }
XtEntityPredicateBuilder >> entityClass: anObject [
	entityClass := anObject.
	mapping := entityClass xtMapping
]

{ #category : #accessing }
XtEntityPredicateBuilder >> queryBuilder [

	^ queryBuilder
]

{ #category : #accessing }
XtEntityPredicateBuilder >> queryBuilder: anObject [

	queryBuilder := anObject
]
