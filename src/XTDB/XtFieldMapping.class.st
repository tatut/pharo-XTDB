"
I am the simplest mapping type: direct mapping of XTDB attribute to Smalltalk instance variable.

Configure me with the XTDB attribute name, and the accessor selectors.

"
Class {
	#name : #XtFieldMapping,
	#superclass : #XtMapping,
	#instVars : [
		'attribute',
		'setter',
		'getter'
	],
	#category : #XTDB
}

{ #category : #'instance creation' }
XtFieldMapping class >> of: anAttributeToGetterAssociation [
	"Create field mapping by an association from attribute name symbol to getter selector.
	The setter selector is automatically created by appending colon to getter."
	^ self new 
		configureMapping: anAttributeToGetterAssociation;
		yourself

]

{ #category : #converting }
XtFieldMapping >> asXtEntityAttrRef [
  "Return an entity attribute reference for this field mapping. 
  This is called by selector access in query predicates."
  ^ XtEntityPredicateAttrRef new
	     entity: #e; 
	     attribute: attribute; yourself
	
]

{ #category : #converting }
XtFieldMapping >> asXtFieldMapping [
	^ self
]

{ #category : #converting }
XtFieldMapping >> asXtPullPattern [ 
  ^ attribute
]

{ #category : #accessing }
XtFieldMapping >> attribute [

	^ attribute
]

{ #category : #accessing }
XtFieldMapping >> attribute: anObject [

	attribute := anObject
]

{ #category : #initialization }
XtFieldMapping >> configureMapping: anAssociation [
  "Set attribute, getter and derived setter from an association.
  Association must have the XTDB attribute as the key and the getter symbol as the value."
  attribute := anAssociation key.
  getter := anAssociation value.
  setter := anAssociation value , ':'
]

{ #category : #accessing }
XtFieldMapping >> getter [

	^ getter
]

{ #category : #accessing }
XtFieldMapping >> getter: anObject [

	getter := anObject
]

{ #category : #accessing }
XtFieldMapping >> setter [

	^ setter
]

{ #category : #accessing }
XtFieldMapping >> setter: anObject [

	setter := anObject
]

{ #category : #'as yet unclassified' }
XtFieldMapping >> toValue: xtValue [
	"Convert XTDB value to Smalltalk value. Default returns value as is."
	^ xtValue
]

{ #category : #'as yet unclassified' }
XtFieldMapping >> xtBuild: aDocumentBuilder document: doc from: instance [
	doc at: attribute put: (instance perform: getter)
]

{ #category : #'as yet unclassified' }
XtFieldMapping >> xtPopulate: instance from: dictionary [
	dictionary at: attribute 
	  ifPresent: [ :value | instance perform: setter with: (self toValue: value) ].

]
