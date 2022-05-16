"
A generic XTDB query result that is not for a specific domain entity.
"
Class {
	#name : #XtQueryResult,
	#superclass : #Object,
	#instVars : [
		'results',
		'resultClass',
		'queryEdn',
		'queryArgs'
	],
	#category : #XTDB
}

{ #category : #initialization }
XtQueryResult >> initialize [ 
  resultClass  := OrderedCollection  
]

{ #category : #'as yet unclassified' }
XtQueryResult >> inspectionQuery: aBuilder [
	<inspectorPresentationOrder: 1 title: 'Datalog & parameters'> 
  | components |
  components := aBuilder newPresenter.
  components layout: (SpPanedLayout newTopToBottom
    add: (aBuilder newText text: queryEdn; beWrapWord; yourself);
    add: (aBuilder newTable
		addColumn: (SpStringTableColumn new 
			title: 'Name';
			evaluated: [ :each | StObjectPrinter asTruncatedTextFrom: each key ];
			sortFunction: #printString ascending;
			yourself);
		addColumn: (SpStringTableColumn new  
			title: 'Value'; 
			evaluated: [ :each | StObjectPrinter asTruncatedTextFrom: each value ];
			sortFunction: #printString ascending;
			yourself);
		items: (queryArgs associations collect: [:e | StInspectorAssociationNode hostObject: e ]);
		yourself);
    positionOfSlider: 33 percent;
    yourself).
  ^ components
"	components := aBuilder newComponentList.
	
	components addPresenter: (aBuilder newText text: queryEdn; beWrapWord; yourself).
	components addPresenter: 
		addColumn: (SpStringTableColumn new  
			title: 'Value'; 
			evaluated: [ :each | StObjectPrinter asTruncatedTextFrom: each value ];
			sortFunction: #printString ascending;
			yourself);
		items: (queryArgs associations collect: [:e | StInspectorAssociationNode hostObject: e ]);
		yourself).
	^ components    "
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

{ #category : #'as yet unclassified' }
XtQueryResult >> queryEdn: edn args: args [
 "Store the EDN query and arguments, for inspection purposes"
 queryEdn := edn.
 queryArgs := args

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
