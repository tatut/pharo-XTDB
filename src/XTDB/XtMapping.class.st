Class {
	#name : #XtMapping,
	#superclass : #Object,
	#instVars : [
		'keywordSetters',
		'getterKeywords'
	],
	#category : #XTDB
}

{ #category : #'as yet unclassified' }
XtMapping >> allAttributes [
	^ keywordSetters keys asOrderedCollection 
]

{ #category : #'as yet unclassified' }
XtMapping >> attributeFor: aGetterSelector [
	^ getterKeywords at: aGetterSelector ifAbsent: [ Error signal: 'Unknown XTDB attribute for getter: ', aGetterSelector  ]
]

{ #category : #initialization }
XtMapping >> initialize [
	keywordSetters := Dictionary new. "map XTDB attribute to setter selector"
	getterKeywords := Dictionary new. "map getter selector to XTDB attribute"
]

{ #category : #'accessing - structure variables' }
XtMapping >> map: aMapping [
	"Map keyword to setter."
	keywordSetters add: aMapping.
	getterKeywords add: aMapping value allButLast asSymbol -> aMapping key
]

{ #category : #'as yet unclassified' }
XtMapping >> populate: anObject from: aDictionary [
	"Populate anObject fields from aDictionary using this mapping."
	keywordSetters keysAndValuesDo: [ :key :value |
		Transcript show: 'key: ', key;cr.
		(aDictionary includesKey: key) ifTrue: [ 
			Transcript show: 'onpa avain:', key, ' => ', value asString;cr.
			anObject perform: value with: (aDictionary at: key) ] ]
]
