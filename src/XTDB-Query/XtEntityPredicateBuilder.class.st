"
I am a proxy object for an entity class passed to filter predicate blocks.
I generate Datalog where clauses (and required :in parameters) based on the
method calls made on the object.
"
Class {
	#name : #XtEntityPredicateBuilder,
	#superclass : #Object,
	#instVars : [
		'queryBuilder',
		'entityClass',
		'mapping',
		'index'
	],
	#category : #'XTDB-Query'
}

{ #category : #adding }
XtEntityPredicateBuilder >> addEquals: entity attr: attr value: value [
	queryBuilder where: entity attr: attr val: value 
]

{ #category : #adding }
XtEntityPredicateBuilder >> addWhere: clause [
	queryBuilder where: clause
]

{ #category : #'reflective operations' }
XtEntityPredicateBuilder >> doesNotUnderstand: aMessage [
	"Proxy getters"
	^ (mapping mappingFor: aMessage selector) asXtEntityAttrRef
		predicateBuilder: self;
		yourself

]

{ #category : #accessing }
XtEntityPredicateBuilder >> entityClass: anObject [
	entityClass := anObject
]

{ #category : #initialization }
XtEntityPredicateBuilder >> initialize [
	index := 0
]

{ #category : #accessing }
XtEntityPredicateBuilder >> mapping: anObject [
	mapping := anObject
]

{ #category : #accessing }
XtEntityPredicateBuilder >> nextIndex [
	| idx |
	idx := index.
	index := idx + 1.
	^ idx
]

{ #category : #accessing }
XtEntityPredicateBuilder >> queryBuilder [

	^ queryBuilder
]

{ #category : #accessing }
XtEntityPredicateBuilder >> queryBuilder: anObject [

	queryBuilder := anObject
]
