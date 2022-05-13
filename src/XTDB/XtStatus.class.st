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
  ^ XtMapping new 
  map: #':xtdb.version/version' -> #version:;
  map: #':xtdb.version/revision' -> #revision:;
  map: #':xtdb.kv/kv-store' -> #kvStore:;
  map: #':xtdb.kv/estimate-num-keys' -> #estimateNumKeys:;
  map: #':xtdb.kv/size' -> #size:;
  map: #':xtdb.index/index-version' -> #indexVersion:;
  map: #':xtdb.tx-log/consumer-state' -> #consumerState:;
	yourself 

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
