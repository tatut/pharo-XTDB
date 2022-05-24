"
I represent a mapping where an entity has a child entity contained.
The child entity is owned by the parent and will be deleted if the
parent is deleted.

If many is true (defaults to false) the value is a collection of 
children instead of a single child.
"
Class {
	#name : #XtChildMapping,
	#superclass : #XtLinkMapping,
	#category : #XTDB
}

{ #category : #'as yet unclassified' }
XtChildMapping >> xtBuild: aDocumentBuilder document: doc from: anEntity [
	"Build documents for an owned child and link the ids in parent."
	| ref value |	
	value := anEntity perform: getter.
	value ifNil: [ ^ nil ].
	ref := many 
	  ifTrue: [ value collect: [ :child | aDocumentBuilder build: child] as: OrderedCollection ] 
	  ifFalse: [ aDocumentBuilder build: value ].
	doc at: attribute put: ref.
	
]
