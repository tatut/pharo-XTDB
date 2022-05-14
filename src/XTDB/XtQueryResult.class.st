"
A generic XTDB query result that is not for a specific domain entity.
"
Class {
	#name : #XtQueryResult,
	#superclass : #Object,
	#instVars : [
		'results',
		'resultClass'
	],
	#category : #XTDB
}

{ #category : #initialization }
XtQueryResult >> initialize [ 
  resultClass  := Dictionary 
]

{ #category : #'instance creation' }
XtQueryResult >> new [ 
	"Create a new result type object"
  ^ resultClass new
]

{ #category : #'as yet unclassified' }
XtQueryResult >> populate: aQueryResult from: aResultList [ 
  | resultMapping |
  resultMapping := resultClass xtMapping.
	aQueryResult results: (aResultList collect: [ :result |
		| obj |
		obj := resultClass new.
		resultMapping populate: obj from: result ])
]

{ #category : #accessing }
XtQueryResult >> results [
  ^ results 
]

{ #category : #accessing }
XtQueryResult >> results: aResultList [ 
  results := aResultList 
]

{ #category : #accessing }
XtQueryResult >> xtMapping [ 
  ^ self

]
