Class {
	#name : #XtReverseLinkMapping,
	#superclass : #XtLinkMapping,
	#instVars : [
		'parentField'
	],
	#category : #XTDB
}

{ #category : #converting }
XtReverseLinkMapping >> asXtPullPattern [
  | parts attr | 
   "turn parent field mapping attribute into reverse pull pattern, prepend an underscore
   to the name part of the keyword."
   parts := '/' split: (parentField attribute allButFirst). 
   attr := (':', ('/' join: (parts allButLast, {('_', parts last)}))) asSymbol.
	^ { attr -> entityClass xtMapping asXtPullPattern } asDictionary 
]

{ #category : #accessing }
XtReverseLinkMapping >> parentField: aFieldAccessor [
   "Set the name of the field that refers to the parent "
	parentField := aFieldAccessor 
]
