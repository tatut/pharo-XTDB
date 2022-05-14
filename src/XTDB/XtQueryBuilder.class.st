"
I build Datalog queries with a DSL.

"
Class {
	#name : #XtQueryBuilder,
	#superclass : #Object,
	#instVars : [
		'find',
		'where',
		'in'
	],
	#category : #XTDB
}

{ #category : #execution }
XtQueryBuilder >> executeOn: anXtClient [
	"Execute the query built on the given client"
	| q queryArgs |
	q := Dictionary new.
	q at: #':find' put: find;
	  at: #':where' put: where.
	in ifNotEmpty: [ q at: #':in' put: in ].
	queryArgs := OrderedCollection with: 'query-edn' -> (EDNWriter toEDNString: q).
	in ifNotEmpty: [ queryArgs add: 'in-args-edn' -> (EDNWriter toEDNString: in) ].
	^ anXtClient getRequest: 'query' with: queryArgs as: XtRawResponse  
	
]

{ #category : #initialization }
XtQueryBuilder >> initialize [
	find := OrderedCollection new.
	where := OrderedCollection new.
	in := Dictionary new. "arguments name -> value"
]

{ #category : #'as yet unclassified' }
XtQueryBuilder >> pull: aName attrs: anAttributeCollection [
	"Specify a find clause that pulls the named attributes from the named logic variable."
	find add: (LinkedList with: #pull with: aName with: anAttributeCollection asOrderedCollection)
]

{ #category : #'as yet unclassified' }
XtQueryBuilder >> where: lvar attr: attrName val: value [
 "Specify EAV pattern where clause"
 where add: { lvar . attrName . value } asOrderedCollection 
]
