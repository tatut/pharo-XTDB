Class {
	#name : #XtEntityMapping,
	#superclass : #XtMapping,
	#instVars : [
		'entityDiscriminator',
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
XtEntityMapping >> entityDiscriminator [

	^ entityDiscriminator
]

{ #category : #accessing }
XtEntityMapping >> entityDiscriminator: anObject [

	entityDiscriminator := anObject
]

{ #category : #accessing }
XtEntityMapping >> fieldMappings [

	^ fieldMappings
]

{ #category : #accessing }
XtEntityMapping >> fieldMappings: aCollection [
	fieldMappings := aCollection 
]

{ #category : #'as yet unclassified' }
XtEntityMapping >> mappingFor: getter [
	^ fieldMappings detect: [ :fm | fm getter = getter ]
		ifNone: [ Error signal: 'No XTDB attributed mapped for accessor: ', getter ]
]

{ #category : #'as yet unclassified' }
XtEntityMapping >> xtPopulate: entity from: dictionary [
	fieldMappings do: [ :mapping |
		mapping xtPopulate: entity from: dictionary  ]
]
