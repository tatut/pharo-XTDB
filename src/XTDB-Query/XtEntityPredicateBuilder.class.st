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
		'index',
		'entity',
		'initialNode'
	],
	#category : #'XTDB-Query'
}

{ #category : #'reflective operations' }
XtEntityPredicateBuilder >> doesNotUnderstand: aMessage [
	"Proxy getters"
	^ (mapping mappingFor: aMessage selector) asXtEntityAttrRef: self
]

{ #category : #accessing }
XtEntityPredicateBuilder >> entity [

	^ entity
]

{ #category : #accessing }
XtEntityPredicateBuilder >> entity: anObject [

	entity := anObject
]

{ #category : #accessing }
XtEntityPredicateBuilder >> entityClass: anObject [
	entityClass := anObject
]

{ #category : #accessing }
XtEntityPredicateBuilder >> initialNode [

	^ initialNode
]

{ #category : #accessing }
XtEntityPredicateBuilder >> initialNode: anObject [

	initialNode := anObject
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
	^ queryBuilder nextIndex
]

{ #category : #accessing }
XtEntityPredicateBuilder >> parent: anObject [

	parent := anObject
]

{ #category : #accessing }
XtEntityPredicateBuilder >> queryBuilder [

	^ queryBuilder
]

{ #category : #accessing }
XtEntityPredicateBuilder >> queryBuilder: anObject [

	queryBuilder := anObject
]
