Class {
	#name : #XtWhereOr,
	#superclass : #XtWhereClauses,
	#category : #'XTDB-Query'
}

{ #category : #accessing }
XtWhereOr >> operation [
  ^ #or
]

{ #category : #rendering }
XtWhereOr >> render [
	"NOTE: we need to detect if we have the same free variables in all branches to 
	 use regular or... 
	
	otherwise we need or-join and we need to include the entity and all referred in parameters"
			
	| joinVars |
	joinVars := OrderedCollection with: #e. "FIXME: could be named something else"
	self prewalk: [ :node | node inParameters collect: #key into: joinVars ].
	^ (LinkedList with: #'or-join' with: joinVars)
		addAll: (clauses collect: #render);
		yourself
	
]
