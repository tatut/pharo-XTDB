"
I am a node that combines multiple child nodes (like and and or).
"
Class {
	#name : #XtWhereClauses,
	#superclass : #XtWhereNode,
	#instVars : [
		'clauses'
	],
	#category : #'XTDB-Query'
}

{ #category : #adding }
XtWhereClauses >> add: aNode [
	clauses add: aNode
]

{ #category : #accessing }
XtWhereClauses >> children [ 
  ^ clauses

]

{ #category : #initialization }
XtWhereClauses >> initialize [ 
	clauses := OrderedCollection new
]

{ #category : #accessing }
XtWhereClauses >> operation [ 
	self subclassResponsibility 
]

{ #category : #rendering }
XtWhereClauses >> render [ 
  | lst |
  lst := LinkedList with: self operation.
	self children collect: #render into: lst.
	^ lst
]
