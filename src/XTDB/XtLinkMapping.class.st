Class {
	#name : #XtLinkMapping,
	#superclass : #XtFieldMapping,
	#instVars : [
		'entityClass',
		'many'
	],
	#category : #XTDB
}

{ #category : #accessing }
XtLinkMapping class >> of: anAssociation to: entityClass [
	^ self new 
	configureMapping: anAssociation;
	entityClass: entityClass; yourself
]

{ #category : #converting }
XtLinkMapping >> asXtPullPattern [ 
  "FIXME: we need to control depth some way, if there are circular references it will cause
  infinite expansion of pull pattern.

  eg.
  Person #company -> Company 
  Company #director -> Person "
	^ { attribute -> entityClass xtMapping asXtPullPattern } asDictionary 
]

{ #category : #'as yet unclassified' }
XtLinkMapping >> beMany [
	many := true
]

{ #category : #accessing }
XtLinkMapping >> entityClass [

	^ entityClass
]

{ #category : #accessing }
XtLinkMapping >> entityClass: anObject [

	entityClass := anObject
]

{ #category : #initialization }
XtLinkMapping >> initialize [ 
  many := false
]

{ #category : #'as yet unclassified' }
XtLinkMapping >> toValue: value [ 
  many 
	 ifTrue: [ ^ value collect: [ :v | self valueToInstance: v ] as: OrderedCollection ]
	 ifFalse: [ ^ self valueToInstance: value ].
]

{ #category : #'as yet unclassified' }
XtLinkMapping >> valueToInstance: value [ 
  | inst |
  inst := entityClass new.
  entityClass xtMapping xtPopulate: inst from: value.
  ^ inst
]