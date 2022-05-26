Class {
	#name : #XtDeletionBuilder,
	#superclass : #XtDocumentBuilder,
	#instVars : [
		'ids'
	],
	#category : #XTDB
}

{ #category : #adding }
XtDeletionBuilder >> addDocument: doc [
	doc at: #':xt/id' ifPresent: [ :id | ids add: id ].
]

{ #category : #'instance creation' }
XtDeletionBuilder >> generateId: doc [ 
 ^ nil 
]

{ #category : #accessing }
XtDeletionBuilder >> ids [ 
 ^ ids
]

{ #category : #initialization }
XtDeletionBuilder >> initialize [ 
  super initialize.
  ids := Set new.
]
