Class {
	#name : #Training,
	#superclass : #Object,
	#instVars : [
		'_xtId',
		'name',
		'description',
		'date',
		'startTime',
		'endTime',
		'comments'
	],
	#category : #'XTDB-Examples'
}

{ #category : #accessing }
Training class >> xtMapping [ 
 ^ XtEntityMapping withAll: { 
	#':xt/id' -> #_xtId.
	#':training/name' -> #name.
	#':training/description' -> #description.
	#':training/date' -> #date.
	#':training/start-time' -> #startTime.
	#':training/end-time' -> #endTime.
	XtReverseLinkMapping field: #comments to: Comment linkField: #entity
 }
	
]

{ #category : #accessing }
Training >> _xtId [

	^ _xtId
]

{ #category : #accessing }
Training >> _xtId: anObject [

	_xtId := anObject
]

{ #category : #accessing }
Training >> comments [

	^ comments
]

{ #category : #accessing }
Training >> comments: anObject [

	comments := anObject
]

{ #category : #accessing }
Training >> date [

	^ date
]

{ #category : #accessing }
Training >> date: anObject [

	date := anObject
]

{ #category : #accessing }
Training >> description [

	^ description
]

{ #category : #accessing }
Training >> description: anObject [

	description := anObject
]

{ #category : #accessing }
Training >> endTime [

	^ endTime
]

{ #category : #accessing }
Training >> endTime: anObject [

	endTime := anObject
]

{ #category : #accessing }
Training >> name [

	^ name
]

{ #category : #accessing }
Training >> name: anObject [

	name := anObject
]

{ #category : #accessing }
Training >> startTime [

	^ startTime
]

{ #category : #accessing }
Training >> startTime: anObject [

	startTime := anObject
]
