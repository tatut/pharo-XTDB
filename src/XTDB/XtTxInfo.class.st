Class {
	#name : #XtTxInfo,
	#superclass : #Object,
	#instVars : [
		'txId',
		'txTime'
	],
	#category : #XTDB
}

{ #category : #accessing }
XtTxInfo class >> xtMapping [ 
  ^ XtEntityMapping withAll: { 
  #':xtdb.api/tx-id' -> #txId . 
  #':xtdb.api/tx-time' -> #txTime 
}
]

{ #category : #accessing }
XtTxInfo >> txId [

	^ txId
]

{ #category : #accessing }
XtTxInfo >> txId: anObject [

	txId := anObject
]

{ #category : #accessing }
XtTxInfo >> txTime [

	^ txTime
]

{ #category : #accessing }
XtTxInfo >> txTime: anObject [

	txTime := anObject
]
