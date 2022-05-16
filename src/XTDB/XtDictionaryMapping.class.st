"
I am a mapping that just calls a single setter with two values: the attribute name and the value.
I am used by Dictionary as the mapping to just set the values.

By default the setter I call is: #at:put:

"
Class {
	#name : #XtDictionaryMapping,
	#superclass : #XtMapping,
	#instVars : [
		'setter'
	],
	#category : #XTDB
}

{ #category : #initialization }
XtDictionaryMapping >> initialize [ 
	setter := #at:put:
]

{ #category : #'as yet unclassified' }
XtDictionaryMapping >> xtPopulate: anObject from: aDictionary [
	aDictionary keysAndValuesDo: [ :key :value |
		anObject perform: setter with: key with: value ]
]
