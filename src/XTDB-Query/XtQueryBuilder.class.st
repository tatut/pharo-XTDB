"
I build Datalog queries with a DSL.

"
Class {
	#name : #XtQueryBuilder,
	#superclass : #Object,
	#instVars : [
		'entityClass',
		'mapping',
		'find',
		'where',
		'result',
		'index',
		'xtClient',
		'limit'
	],
	#category : #'XTDB-Query'
}

{ #category : #'as yet unclassified' }
XtQueryBuilder >> ensureFind [
  find ifNotNil: [ ^ find ].
  ^ OrderedCollection with: (LinkedList 
		with: #pull with: #e with: mapping asXtPullPattern)
]

{ #category : #'as yet unclassified' }
XtQueryBuilder >> ensureWhere [
  where ifNotNil: [ :w | ^ w ].
  "Use entity type discriminator if there is no other where clause set."
	mapping entityDiscriminator
	  ifNil: [ Error signal: 'No entity discriminator or where predicate used.' ] 
		ifNotNil: [ :ed | ^ ed asXtWhereClause ]

]

{ #category : #accessing }
XtQueryBuilder >> entityClass: anEntityClass [
  entityClass := anEntityClass.
  mapping := entityClass xtMapping.
]

{ #category : #execution }
XtQueryBuilder >> execute [
  "Execute this query and return the results."
	| q in findq whereq inArgs queryEdn queryArgs res |
  result := (XtEntityPullMapping new entityClass: entityClass). 
  findq := self ensureFind.
  whereq := self ensureWhere.
	q := Dictionary new.
	q at: #':find' put: findq;
	  at: #':where' put: (whereq renderToplevel).
	limit ifNotNil: [ :lim | q at: #':limit' put: lim ].
	in := whereq allInParameters.
	in ifNotEmpty: [ 
		inArgs := in associations.
		q at: #':in' put: (inArgs collect: #key) asOrderedCollection ].
	queryEdn := (EDNWriter toEDNString: q).
	queryArgs := OrderedCollection with: 'query-edn' -> queryEdn.
	in ifNotEmpty: [ queryArgs add: 'in-args-edn' -> (EDNWriter toEDNString: (inArgs collect: #value) asOrderedCollection) ].
	xtClient txId ifNotNil: [ queryArgs add: 'tx-id' -> xtClient txId asString ].
	"Transcript show: queryArgs printString;cr."
	res := xtClient getRequest: 'query' with: queryArgs as: result.
	res queryEdn: queryEdn args: in.
	^ res
	
]

{ #category : #execution }
XtQueryBuilder >> executeOn: anXtClient [
	"Execute the query built on the given client"
	xtClient := anXtClient.
	^ self execute

]

{ #category : #initialization }
XtQueryBuilder >> initialize [
  index := 0.
	result := XtQueryResult new "default to generic query result"
]

{ #category : #accessing }
XtQueryBuilder >> limit [

	^ limit
]

{ #category : #accessing }
XtQueryBuilder >> limit: anObject [

	limit := anObject
]

{ #category : #accessing }
XtQueryBuilder >> nextIndex [
	| idx |
	idx := index.
	index := idx + 1.
	^ idx
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
XtQueryBuilder >> setWhere: clauses [
  where := clauses
]

{ #category : #accessing }
XtQueryBuilder >> where: aPredicateBlock [
  | eb |
	eb := XtEntityPredicateBuilder new 
	  entity: #e;
	  queryBuilder: self;
	  entityClass: entityClass;
	  mapping: mapping.
  where := aPredicateBlock value: eb.
  "Add entity discriminator, if present"
  mapping entityDiscriminator ifNotNil: [ :ed |
	  where := XtWhereAnd new add: ed asXtWhereClause; add: where; yourself ].
  where := where simplify.
]

{ #category : #accessing }
XtQueryBuilder >> xtClient [

	^ xtClient
]

{ #category : #accessing }
XtQueryBuilder >> xtClient: anObject [

	xtClient := anObject
]
