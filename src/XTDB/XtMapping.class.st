Class {
	#name : #XtMapping,
	#superclass : #Object,
	#instVars : [
		'keywordSetters'
	],
	#category : #XTDB
}

{ #category : #initialization }
XtMapping >> initialize [
	keywordSetters := Dictionary new.
]

{ #category : #'accessing - structure variables' }
XtMapping >> map: aMapping [
	"Map keyword to setter."
	keywordSetters add: aMapping.
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
