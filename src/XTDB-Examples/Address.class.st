Class {
	#name : #Address,
	#superclass : #Object,
	#instVars : [
		'_xtId',
		'streetAddress',
		'postalCode',
		'city',
		'country'
	],
	#category : #'XTDB-Examples'
}

{ #category : #accessing }
Address class >> xtMapping [
	^ XtEntityMapping withAll: {  
    #':address/street-address' -> #streetAddress .
    #':address/postal-code' -> #postalCode .
    #':address/city' -> #city .
    #':address/country' -> #country .
    #':xt/id' -> #_xtId 
  }
]

{ #category : #accessing }
Address >> _xtId [

	^ _xtId
]

{ #category : #accessing }
Address >> _xtId: anObject [

	_xtId := anObject
]

{ #category : #accessing }
Address >> city [

	^ city
]

{ #category : #accessing }
Address >> city: anObject [

	city := anObject
]

{ #category : #accessing }
Address >> country [

	^ country
]

{ #category : #accessing }
Address >> country: anObject [

	country := anObject
]

{ #category : #accessing }
Address >> postalCode [

	^ postalCode
]

{ #category : #accessing }
Address >> postalCode: anObject [

	postalCode := anObject
]

{ #category : #accessing }
Address >> streetAddress [

	^ streetAddress
]

{ #category : #accessing }
Address >> streetAddress: anObject [

	streetAddress := anObject
]
