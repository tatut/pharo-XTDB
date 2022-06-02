"
I represent a configuration in the document mapping that specifies how 
to discriminate entities of the type being configured from other entities.

As documents are untyped and any document can have any attributes, 
there needs to be a way to select only the documents that have the
correct ""type"".

This can be configured in two ways: with a constant valued attribute
or the presence of an attribute that is always present (but not present
in any other type of document).

Example of constant valued attribute: 
 >>> XtEntityDiscriminator attribute: #':type' withValue: #':person'

Example of a attribute presence:
 >>> XtEntityDiscriminator attributePresent: #':person/name'

The discriminator is automatically added to queries when querying
by an entity type.
"
Class {
	#name : #XtEntityDiscriminator,
	#superclass : #Object,
	#instVars : [
		'attribute',
		'constantValue'
	],
	#category : #XTDB
}

{ #category : #'as yet unclassified' }
XtEntityDiscriminator class >> attribute: attributeName withValue: constantValue [ 
	^ self new attribute: attributeName; constantValue: constantValue; yourself
]

{ #category : #'as yet unclassified' }
XtEntityDiscriminator class >> attributePresent: attributeName [ 
  ^ self new attribute: attributeName; yourself
]

{ #category : #converting }
XtEntityDiscriminator >> asXtWhereClause [ 
	constantValue 
	  ifNil: [ ^ XtWhereEAPresent new e: #e a: attribute ]
	  ifNotNil: [ :c | ^ XtWhereEAV new e: #e a: attribute v: c ]
]

{ #category : #accessing }
XtEntityDiscriminator >> attribute [

	^ attribute
]

{ #category : #accessing }
XtEntityDiscriminator >> attribute: anObject [

	attribute := anObject
]

{ #category : #accessing }
XtEntityDiscriminator >> constantValue [

	^ constantValue
]

{ #category : #accessing }
XtEntityDiscriminator >> constantValue: anObject [

	constantValue := anObject
]
