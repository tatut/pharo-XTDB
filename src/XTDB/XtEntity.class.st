"
I am a response class for generic entities when you don't want to load a entity into a domain
specific class.

I hold all the attributes in a dictionary.
"
Class {
	#name : #XtEntity,
	#superclass : #Object,
	#instVars : [
		'attributes'
	],
	#category : #XTDB
}

{ #category : #accessing }
XtEntity class >> xtMapping [
	^ XtDictionaryMapping new
]

{ #category : #accessing }
XtEntity >> at: anAttributeName [
  ^ attributes at: anAttributeName 
]

{ #category : #accessing }
XtEntity >> at: anAttributeName put: aValue [
	attributes at: anAttributeName put: aValue
]

{ #category : #initialization }
XtEntity >> initialize [
	attributes := Dictionary new
]

{ #category : #'as yet unclassified' }
XtEntity >> inspectionAttributes: aBuilder [
	<inspectorPresentationOrder: 0 title: 'Attributes'> 
	
	^ aBuilder newTable 
		addColumn: (SpStringTableColumn 
			title: 'Attribute'
			evaluated: [ :each | StObjectPrinter asTruncatedTextFrom: each key ])
			beSortable;
		addColumn: (SpStringTableColumn 
			title: 'Value' 
			evaluated: [ :each | StObjectPrinter asTruncatedTextFrom: each value ])
			beSortable;
		items: (attributes associations collect: [:e | StInspectorAssociationNode hostObject: e ]);
		yourself
]
