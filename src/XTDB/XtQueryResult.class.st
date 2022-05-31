"
A generic XTDB query result that is not for a specific domain entity.
"
Class {
	#name : #XtQueryResult,
	#superclass : #OrderedCollection,
	#instVars : [
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

{ #category : #inspecting }
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
]

{ #category : #'instance creation' }
XtQueryResult >> new [ 
	"Return self"
  ^ self
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
XtQueryResult >> xtMapping [ 
  ^ self

]

{ #category : #'as yet unclassified' }
XtQueryResult >> xtPopulate: aQueryResult from: aResultList [ 
  | resultMapping |
  resultMapping := resultClass xtMapping.
	aQueryResult results: (aResultList collect: [ :result |
		| obj |
		obj := resultClass new.
		resultMapping xtPopulate: obj from: result.
	   obj ])
]
