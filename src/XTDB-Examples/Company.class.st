Class {
	#name : #Company,
	#superclass : #Object,
	#instVars : [
		'_xtId',
		'name'
	],
	#category : #'XTDB-Examples'
}

{ #category : #accessing }
Company class >> xtMapping [ 
 ^ XtEntityMapping withAll: { 
    #':xt/id' -> #_xtId .
    #':company/name' -> #name
  }
]

{ #category : #accessing }
Company >> _xtId [

	^ _xtId
]

{ #category : #accessing }
Company >> _xtId: anObject [

	_xtId := anObject
]

{ #category : #accessing }
Company >> name [

	^ name
]

{ #category : #accessing }
Company >> name: anObject [

	name := anObject
]
