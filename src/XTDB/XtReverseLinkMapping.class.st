Class {
	#name : #XtReverseLinkMapping,
	#superclass : #XtLinkMapping,
	#category : #XTDB
}

{ #category : #'as yet unclassified' }
XtReverseLinkMapping class >> field: fieldInThisEntity to: entityClass linkField: fieldInOtherEntity [
	^ self new 
	entityClass: entityClass; 
	thisEntityField: fieldInThisEntity;
	otherEntityField: fieldInOtherEntity;
	yourself
]

{ #category : #initialization }
XtReverseLinkMapping >> initialize [
	super initialize.
	self beMany 
]

{ #category : #accessing }
XtReverseLinkMapping >> otherEntityField: otherEntityField [ 
   | parts otherAttr | 
   "turn parent field mapping attribute into reverse pull pattern, prepend an underscore
   to the name part of the keyword."
   otherAttr := entityClass xtMapping attributeFor: otherEntityField.
   parts := '/' split: (otherAttr allButFirst). 
   attribute := (':', ('/' join: (parts allButLast, {('_', parts last)}))) asSymbol.

]

{ #category : #accessing }
XtReverseLinkMapping >> thisEntityField: anObject [
  getter := anObject.
  setter := anObject,':'.

]

{ #category : #'as yet unclassified' }
XtReverseLinkMapping >> xtBuild: aDocumentBuilder document: doc from: instance [
	"Do nothing, we don't store data or links to reverse linked entites."
]
