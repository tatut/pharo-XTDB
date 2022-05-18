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

{ #category : #rendering }
XtWhereNode >> render [
  "Render to where clause object that is serialized to EDN."
	self subclassResponsibility 
]

{ #category : #rendering }
XtWhereNode >> renderToplevel [ 
	"Render to toplevel where clause object that is serialized as EDN"
	^ self render
]

{ #category : #'logical operations' }
XtWhereNode >> | anotherNode [
	^ XtWhereOr new 
		add: self; add: anotherNode;
		yourself
]