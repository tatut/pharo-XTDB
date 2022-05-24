Class {
	#name : #XtDocumentBuilder,
	#superclass : #Object,
	#instVars : [
		'documents',
		'ids'
	],
	#category : #XTDB
}

{ #category : #'instance creation' }
XtDocumentBuilder >> build: anEntity [
	"Build documents from the entity. 
	If the entity has no value for :xt/id attribute, a new UUID id is generated.
	Answers with the id of the document."
	| doc id |
	doc := Dictionary new.
	anEntity class xtMapping fieldMappings do: [ :fm |
		fm xtBuild: self document: doc from: anEntity ].
	id := doc at: #':xt/id' ifAbsent: nil.
	id ifNil: [ 
		id := doc at: #':xt/id' put: UUIDGenerator next.
	].
  documents add: doc.
  ^ id
]

{ #category : #accessing }
XtDocumentBuilder >> documents [

	^ documents
]

{ #category : #initialization }
XtDocumentBuilder >> initialize [
	ids := Dictionary new. "record any ids of owned children"
	documents := OrderedCollection new.
]
