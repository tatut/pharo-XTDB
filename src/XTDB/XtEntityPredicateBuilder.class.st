Class {
	#name : #XtEntityPredicateBuilder,
	#superclass : #Object,
	#instVars : [
		'queryBuilder',
		'entityClass',
		'mapping',
		'parameterIndex'
	],
	#category : #XTDB
}

{ #category : #adding }
XtEntityPredicateBuilder >> addEquals: entity attr: attr value: value [
	queryBuilder where: entity attr: attr val: value 
]

{ #category : #adding }
XtEntityPredicateBuilder >> addIn: aParameterValue [
	| name |
	name := ('p',parameterIndex asString) asSymbol.
	parameterIndex := parameterIndex + 1.
	queryBuilder in: name value: aParameterValue.
	^ name
]

{ #category : #adding }
XtEntityPredicateBuilder >> addWhere: clause [
	queryBuilder where: clause
]

{ #category : #'reflective operations' }
XtEntityPredicateBuilder >> doesNotUnderstand: aMessage [
	"Proxy getters"
	| attr |
	attr := mapping attributeFor: aMessage selector.
	^ XtEntityPredicateAttrRef new
	     predicateBuilder: self;
	     entity: #e; 
	     attribute: attr; yourself
]

{ #category : #accessing }
XtEntityPredicateBuilder >> entityClass: anObject [
	entityClass := anObject
]

{ #category : #initialization }
XtEntityPredicateBuilder >> initialize [
	parameterIndex := 0
]

{ #category : #accessing }
XtEntityPredicateBuilder >> mapping: anObject [
	mapping := anObject
]

{ #category : #accessing }
XtEntityPredicateBuilder >> queryBuilder [

	^ queryBuilder
]

{ #category : #accessing }
XtEntityPredicateBuilder >> queryBuilder: anObject [

	queryBuilder := anObject
]
