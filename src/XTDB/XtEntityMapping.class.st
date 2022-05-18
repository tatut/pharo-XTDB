Class {
	#name : #XtEntityMapping,
	#superclass : #XtMapping,
	#instVars : [
		'fieldMappings'
	],
	#category : #XTDB
}

{ #category : #'instance creation' }
XtEntityMapping class >> withAll: fieldMappings [
	^ self new fieldMappings: (fieldMappings collect: #asXtFieldMapping); yourself
]

{ #category : #converting }
XtEntityMapping >> asXtPullPattern [ 
	^ fieldMappings collect: #asXtPullPattern as: OrderedCollection 
]

{ #category : #'as yet unclassified' }
XtEntityMapping >> attributeFor: getter [
	^ (fieldMappings detect: [ :fm | fm getter = getter ]
		ifNone: [ Error signal: 'No XTDB attributed mapped for accessor: ', getter ]) attribute
]

{ #category : #accessing }
XtEntityMapping >> fieldMappings: aCollection [
	fieldMappings := aCollection 
]

{ #category : #'as yet unclassified' }
XtEntityMapping >> xtPopulate: entity from: dictionary [
	fieldMappings do: [ :mapping |
		mapping xtPopulate: entity from: dictionary  ]
]
