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

{ #category : #accessing }
XtEntityPullMapping >> xtMapping [ 
  ^ self

]

{ #category : #'as yet unclassified' }
XtEntityPullMapping >> xtPopulate: xtQueryResult from: resultList [  
  resultList do: [ :result |
	  | obj pull |
	  pull := result first.
	  obj := entityClass new.
	  entityMapping xtPopulate: obj from: pull.
	  xtQueryResult add: obj
	]
]
