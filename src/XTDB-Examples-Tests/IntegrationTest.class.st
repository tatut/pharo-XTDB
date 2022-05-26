"
Integration tests against an actual in-memory XTDB instance.
The database should be empty when tests start.
"
Class {
	#name : #IntegrationTest,
	#superclass : #TestCase,
	#instVars : [
		'xt'
	],
	#category : #'XTDB-Examples-Tests'
}

{ #category : #running }
IntegrationTest >> setUp [
	super setUp.
	xt := XtClient new url: 'http://localhost:6666/_xtdb/'

]

{ #category : #tests }
IntegrationTest >> testAddPerson [
  | results |
	xt store: (Person new
	  _xtId: 'max';
	  firstName: 'Max'; 
	  lastName: 'Feedpressure'; 
	  address: (Address new 
			  	      streetAddress: 'Pipestreet 1';
					  postalCode: '12345';
					  city: 'Kello';
					  country: #':FI';
					  yourself);
	yourself).
	
	
	results := (xt q: Person matching: [ :p | p firstName = 'Max' ]) results.
	
	self assert: results size equals: 1.
	self assert: results first _xtId equals: 'max'.
	self assert: results first lastName equals: 'Feedpressure'.
	self assert: results first address postalCode equals: '12345'
	
	
	
]

{ #category : #tests }
IntegrationTest >> testStatus [
  | s |
	s := xt status.
	self assert: s version equals: '1.21.0' 
]

{ #category : #tests }
IntegrationTest >> testTextSearch [
  | results |
   #( ('Jack' 'Javaman' 'Java developer') 
      ('Carla' 'Clojurian' 'Clojure developer')
      ('Sally' 'Smalltalker' 'Smalltalk developer')
      ('Harry' 'Haskeller' 'Haskell developer') ) do: [ :row |
		xt store: (Person new
		 _xtId: (row at: 1);
	   firstName: (row at: 1); 
	   lastName: (row at: 2); 
	   jobTitle: (row at: 3);
      yourself)
  ].
	(Delay forSeconds: 1) wait. "FIXME: should wait for specific tx instead of sleeping"
	results := (xt q: Person matching: [ :p | p jobTitle textSearch: 'dev*' ]) results.
	self assert: results size equals: 4.
  	
	
	
]
