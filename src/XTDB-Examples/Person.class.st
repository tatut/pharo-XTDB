Class {
	#name : #Person,
	#superclass : #Object,
	#instVars : [
		'lastName',
		'firstName',
		'address',
		'jobTitle',
		'gender',
		'email',
		'_xtId'
	],
	#category : #'XTDB-Examples'
}

{ #category : #accessing }
Person class >> xtMapping [
	^ XtMapping new 
	map: #':last-name' -> #lastName:;
	map: #':first-name' -> #firstName:;
	map: #':address' -> #address:;
	map: #':job-title' -> #jobTitle:;
	map: #':gender' -> #gender:;
	map: #':email' -> #email:;
	map: #':xt/id' -> #_xtId:;
	yourself
]

{ #category : #accessing }
Person >> _xtId [

	^ _xtId
]

{ #category : #accessing }
Person >> _xtId: anObject [

	_xtId := anObject
]

{ #category : #accessing }
Person >> address [

	^ address
]

{ #category : #accessing }
Person >> address: anObject [

	address := anObject
]

{ #category : #accessing }
Person >> email [

	^ email
]

{ #category : #accessing }
Person >> email: anObject [

	email := anObject
]

{ #category : #accessing }
Person >> firstName [

	^ firstName
]

{ #category : #accessing }
Person >> firstName: anObject [

	firstName := anObject
]

{ #category : #accessing }
Person >> gender [

	^ gender
]

{ #category : #accessing }
Person >> gender: anObject [

	gender := anObject
]

{ #category : #accessing }
Person >> jobTitle [

	^ jobTitle
]

{ #category : #accessing }
Person >> jobTitle: anObject [

	jobTitle := anObject
]

{ #category : #accessing }
Person >> lastName [

	^ lastName
]

{ #category : #accessing }
Person >> lastName: anObject [

	lastName := anObject
]
