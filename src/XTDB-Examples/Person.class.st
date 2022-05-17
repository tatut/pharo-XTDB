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
		'_xtId',
		'company'
	],
	#category : #'XTDB-Examples'
}

{ #category : #accessing }
Person class >> xtMapping [
	^ XtEntityMapping withAll: {  
    #':last-name' -> #lastName .
    #':first-name' -> #firstName .
    #':address' -> #address .
    #':job-title' -> #jobTitle .
    #':gender' -> #gender .
    #':email' -> #email .
    XtLinkMapping of: #':company' -> #company to: Company .
    #':xt/id' -> #_xtId 
  }
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

{ #category : #printing }
Person >> asString [ 
	^ 'a Person (', firstName ,' ', lastName, ')'
]

{ #category : #accessing }
Person >> company [

	^ company
]

{ #category : #accessing }
Person >> company: anObject [

	company := anObject
]

{ #category : #printing }
Person >> displayStringOn: out [ 
	out << 'a Person ('; << firstName; << ' '; << lastName; << ')'
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

{ #category : #printing }
Person >> printString [ 
	^ 'a Person (', firstName ,' ', lastName, ')'
]
