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
	^ XtNoMapping new
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
