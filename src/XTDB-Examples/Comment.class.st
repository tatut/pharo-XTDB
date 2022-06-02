Class {
	#name : #Comment,
	#superclass : #Object,
	#instVars : [
		'timestamp',
		'author',
		'comment',
		'entity'
	],
	#category : #'XTDB-Examples'
}

{ #category : #accessing }
Comment class >> xtMapping [
  ^ XtEntityMapping withAll: { 
    #':comment/entity' -> #entity.
    XtLinkMapping of: #':comment/author' -> #author to: Person.
    #':comment/comment' -> #comment.
    #':comment/timestamp' -> #timestamp
   }
]

{ #category : #accessing }
Comment >> author [

	^ author
]

{ #category : #accessing }
Comment >> author: anObject [

	author := anObject
]

{ #category : #accessing }
Comment >> comment [

	^ comment
]

{ #category : #accessing }
Comment >> comment: anObject [

	comment := anObject
]

{ #category : #accessing }
Comment >> entity [

	^ entity
]

{ #category : #accessing }
Comment >> entity: anObject [

	entity := anObject
]

{ #category : #accessing }
Comment >> timestamp [

	^ timestamp
]

{ #category : #accessing }
Comment >> timestamp: anObject [

	timestamp := anObject
]
