Class {
	#name : #XtDocumentBuilder,
	#superclass : #Object,
	#instVars : [
		'documents'
	],
	#category : #XTDB
}

{ #category : #'instance creation' }
XtDocumentBuilder >> addDocument: doc [
  documents add: doc
]

{ #category : #'instance creation' }
XtDocumentBuilder >> build: anEntity [
  "Build documents from the entity. 
	If the entity has no value for :xt/id attribute, a new UUID id is generated.
	Answers with the id of the document."
  | doc id |
  doc := Dictionary new.
  anEntity class xtMapping fieldMappings do: [:fm |  fm xtBuild: self document: doc from: anEntity ].
  id := doc at: #':xt/id' ifAbsent: nil.
  id ifNil: [ id := self generateId: doc ].
  self addDocument: doc.
  ^id
]

{ #category : #accessing }
XtDocumentBuilder >> documents [

	^ documents
]

{ #category : #'instance creation' }
XtDocumentBuilder >> generateId: doc [
  ^doc at: #':xt/id' put: UUIDGenerator next
]

{ #category : #initialization }
XtDocumentBuilder >> initialize [
	documents := OrderedCollection new.
]
