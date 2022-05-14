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
  resultClass  := OrderedCollection  
]

{ #category : #'as yet unclassified' }
XtQueryResult >> inspectionResults: aBuilder [
	<inspectorPresentationOrder: 0 title: 'Query results'> 
	
	^ aBuilder newTable		
		addColumn: (SpIndexTableColumn new 
			title: 'Index';
			sortFunction: #yourself ascending;
			beNotExpandable;
			yourself);
		addColumn: (SpStringTableColumn new  
			title: 'Value'; 
			evaluated: [ :each | StObjectPrinter asTruncatedTextFrom: each ];
			sortFunction: #printString ascending;
			yourself);
		items: results asOrderedCollection;
		yourself
]

{ #category : #'instance creation' }
XtQueryResult >> new [ 
	"Return self"
  ^ self
]

{ #category : #'as yet unclassified' }
XtQueryResult >> populate: aQueryResult from: aResultList [ 
  | resultMapping |
  resultMapping := resultClass xtMapping.
	aQueryResult results: (aResultList collect: [ :result |
		| obj |
		obj := resultClass new.
		resultMapping populate: obj from: result.
	   obj ])
]

{ #category : #accessing }
XtQueryResult >> resultClass: aClass [ 
  resultClass  := aClass
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
