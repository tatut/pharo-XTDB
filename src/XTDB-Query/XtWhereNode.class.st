"
I am the abstract node class for where clause nodes.
"
Class {
	#name : #XtWhereNode,
	#superclass : #Object,
	#instVars : [
		'id'
	],
	#category : #'XTDB-Query'
}

{ #category : #'logical operations' }
XtWhereNode >> & anotherNode [
	^ XtWhereAnd new 
		add: self; add: anotherNode;
		yourself
]

{ #category : #accessing }
XtWhereNode >> children [
	"Answer the a collection of child nodes. Default answers with an empty array."
	^ {  }

]

{ #category : #accessing }
XtWhereNode >> id [

	^ id
]

{ #category : #accessing }
XtWhereNode >> id: anObject [

	id := anObject
]

{ #category : #'as yet unclassified' }
XtWhereNode >> inName: prefix [
  "Return in parameter name."
	^ (prefix,id asString) asSymbol
]

{ #category : #'as yet unclassified' }
XtWhereNode >> inParameters [
	"Returns an array of :in parameter associations (from name to value). Defaults to empty array."
	^ { }
]

{ #category : #'as yet unclassified' }
XtWhereNode >> prewalk: aBlock [
	"Call block with self and then with all children of self"
	aBlock value: self.
	self children do: [ :c | c prewalk: aBlock ]
]

{ #category : #rendering }
XtWhereNode >> render [
  "Render to where clause object that is serialized to EDN."
	self subclassResponsibility 
]

{ #category : #rendering }
XtWhereNode >> renderToplevel [ 
	"Render to toplevel where clause object that is serialized as EDN"
	^ OrderedCollection with: self render
]

{ #category : #'as yet unclassified' }
XtWhereNode >> simplify [
	"Return a simplified version of the node. Default just returns self"
	^ self
]

{ #category : #'as yet unclassified' }
XtWhereNode >> unwrap [
	"Return unwrapped and clauses or array of self."
	^ { self }

]

{ #category : #'logical operations' }
XtWhereNode >> | anotherNode [
	^ XtWhereOr new 
		add: self; add: anotherNode;
		yourself
]
