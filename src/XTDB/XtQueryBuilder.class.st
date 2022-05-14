"
I build Datalog queries with a DSL.

"
Class {
	#name : #XtQueryBuilder,
	#superclass : #Object,
	#instVars : [
		'find',
		'where',
		'in',
		'result'
	],
	#category : #XTDB
}

{ #category : #execution }
XtQueryBuilder >> executeOn: anXtClient [
	"Execute the query built on the given client"
	| q inArgs queryArgs |
	q := Dictionary new.
	q at: #':find' put: find;
	  at: #':where' put: where.
	in ifNotEmpty: [ 
		inArgs := in associations.
		q at: #':in' put: (inArgs collect: #key) asOrderedCollection ].
	queryArgs := OrderedCollection with: 'query-edn' -> (EDNWriter toEDNString: q).
	in ifNotEmpty: [ queryArgs add: 'in-args-edn' -> (EDNWriter toEDNString: (inArgs collect: #value) asOrderedCollection) ].
	Transcript show: queryArgs printString;cr.
	^ anXtClient getRequest: 'query' with: queryArgs as: result
	
]

{ #category : #'as yet unclassified' }
XtQueryBuilder >> in: name value: value [
	in at: name put: value
]

{ #category : #initialization }
XtQueryBuilder >> initialize [
	find := OrderedCollection new.
	where := OrderedCollection new.
	in := Dictionary new. "arguments name -> value"
	result := XtQueryResult new "default to generic query result"
]

{ #category : #'as yet unclassified' }
XtQueryBuilder >> pull: aName attrs: anAttributeCollection [
	"Specify a find clause that pulls the named attributes from the named logic variable."
	find add: (LinkedList with: #pull with: aName with: anAttributeCollection asOrderedCollection)
]

{ #category : #accessing }
XtQueryBuilder >> result: aResultMapping [
	result := aResultMapping 
]

{ #category : #'as yet unclassified' }
XtQueryBuilder >> where: clause [
  where add: clause
]

{ #category : #'as yet unclassified' }
XtQueryBuilder >> where: lvar attr: attrName val: value [
 "Specify EAV pattern where clause"
 where add: { lvar . attrName . value } asOrderedCollection 
]
