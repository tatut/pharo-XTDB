Class {
	#name : #XtEntityPullMapping,
	#superclass : #XtMapping,
	#instVars : [
		'entityClass',
		'entityMapping'
	],
	#category : #XTDB
}

{ #category : #accessing }
XtEntityPullMapping >> entityClass: anObject [
	entityClass := anObject.
	entityMapping := entityClass xtMapping 
]

{ #category : #'instance creation' }
XtEntityPullMapping >> new [
  ^ XtQueryResult new
]

{ #category : #'as yet unclassified' }
XtEntityPullMapping >> populate: xtQueryResult from: resultList [  
  | results |
  results := OrderedCollection new.
  resultList do: [ :result |
	  | obj pull |
	  pull := result first.
	  obj := entityClass new.
	  entityMapping populate: obj from: pull.
	  results add: obj
	].
  xtQueryResult results: results
]

{ #category : #accessing }
XtEntityPullMapping >> xtMapping [ 
  ^ self

]
