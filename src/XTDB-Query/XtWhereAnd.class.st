Class {
	#name : #XtWhereAnd,
	#superclass : #XtWhereClauses,
	#category : #'XTDB-Query'
}

{ #category : #accessing }
XtWhereAnd >> operation [
  ^ #and
]

{ #category : #rendering }
XtWhereAnd >> renderToplevel [ 
	"Render and at toplevel without the operation, just an ordered collection of clauses."
	^ self children asOrderedCollection 
]
