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
	xt storeAndWait: (Person new
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
IntegrationTest >> testAddPersonDelete [
  | results |
	xt storeAndWait: (Person new
	  _xtId: 'deleteme';
	  firstName: 'Del'; 
	  lastName: 'Eteme'; 
	  address: (Address new 
			  	      streetAddress: 'Delete 1';
					  postalCode: '12345';
					  city: 'Kello';
					  country: #':FI';
					  yourself);
	yourself).
	
	results := (xt q: Person matching: [ :p | p firstName = 'Del' ]) results.	
	self assert: results size equals: 1.
	
	xt deleteAndWait: results first.
	results := (xt q: Person matching: [ :p | p firstName = 'Del' ]) results.
	self assert: results size equals: 0.
	
]

{ #category : #tests }
IntegrationTest >> testStatus [
  | s |
	s := xt status.
	self assert: s version equals: '1.21.0' 
]

{ #category : #tests }
IntegrationTest >> testTextSearch [
  | results tx |
   #( ('Jack' 'Javaman' 'Java developer') 
      ('Carla' 'Clojurian' 'Clojure developer')
      ('Sally' 'Smalltalker' 'Smalltalk developer')
      ('Harry' 'Haskeller' 'Haskell developer')
      ('Diana' 'Devopser' 'DevOps specialist')
      ('Andy' 'Advocate' 'Developer advocate') ) do: [ :row |
		tx := xt store: (Person new
		 _xtId: (row at: 1);
	   firstName: (row at: 1); 
	   lastName: (row at: 2); 
	   jobTitle: (row at: 3);
      yourself)
  ].
  xt awaitTx: tx txId.
	results := (xt q: Person matching: [ :p | p jobTitle textSearch: 'dev*' ]) results.
	self assert: results size equals: 6.
	
	results := (xt q: Person matching: [ :p | p jobTitle textSearch: 'developer' ]) results.
	self assert: results size equals: 5.
	
	results := (xt q: Person matching: [ :p | p jobTitle textSearch: 'small*' ]) results.
	self assert: results size equals: 1.
	
  	
	
	
]
