Class {
	#name : #XtStatus,
	#superclass : #Object,
	#instVars : [
		'version',
		'revision',
		'kvStore',
		'estimateNumKeys',
		'size',
		'indexVersion',
		'consumerState'
	],
	#category : #XTDB
}

{ #category : #accessing }
XtStatus class >> xtMapping [ 
  ^ XtEntityMapping withAll: { 
  #':xtdb.version/version' -> #version .
  #':xtdb.version/revision' -> #revision .
  #':xtdb.kv/kv-store' -> #kvStore .
  #':xtdb.kv/estimate-num-keys' -> #estimateNumKeys .
  #':xtdb.kv/size' -> #size .
  #':xtdb.index/index-version' -> #indexVersion .
  #':xtdb.tx-log/consumer-state' -> #consumerState 
}


]

{ #category : #accessing }
XtStatus >> consumerState [

	^ consumerState
]

{ #category : #accessing }
XtStatus >> consumerState: anObject [

	consumerState := anObject
]

{ #category : #accessing }
XtStatus >> estimateNumKeys [

	^ estimateNumKeys
]

{ #category : #accessing }
XtStatus >> estimateNumKeys: anObject [

	estimateNumKeys := anObject
]

{ #category : #accessing }
XtStatus >> indexVersion [

	^ indexVersion
]

{ #category : #accessing }
XtStatus >> indexVersion: anObject [

	indexVersion := anObject
]

{ #category : #accessing }
XtStatus >> kvStore [

	^ kvStore
]

{ #category : #accessing }
XtStatus >> kvStore: anObject [

	kvStore := anObject
]

{ #category : #accessing }
XtStatus >> revision [

	^ revision
]

{ #category : #accessing }
XtStatus >> revision: anObject [

	revision := anObject
]

{ #category : #accessing }
XtStatus >> size1 [

	^ size
]

{ #category : #accessing }
XtStatus >> size: anObject [

	size := anObject
]

{ #category : #accessing }
XtStatus >> version [

	^ version
]

{ #category : #accessing }
XtStatus >> version: anObject [

	version := anObject
]
