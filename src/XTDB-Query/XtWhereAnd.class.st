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
	^ self children collect: #render 
]

{ #category : #'as yet unclassified' }
XtWhereAnd >> simplify [
	"Unwrap all nested and clauses."
	clauses := clauses collectAll: [ :c | c simplify unwrap ].
	^ self
	
]

{ #category : #'as yet unclassified' }
XtWhereAnd >> unwrap [
	^ clauses
]
