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

{ #category : #'as yet unclassified' }
IntegrationTest >> q: block [ 
 ^ (xt q: Person matching: block)
]

{ #category : #running }
IntegrationTest >> setUp [
	super setUp.
	xt := XtClient new url: 'http://localhost:6666/_xtdb/'

]

{ #category : #'as yet unclassified' }
IntegrationTest >> storeTestPersons [
  | tx |
  #( ('Jack' 'Javaman' 'Java developer' 'Spring road 1' '12345') 
     ('Carla' 'Clojurian' 'Clojure developer' 'Ring avenue 2' '23456')
     ('Sally' 'Smalltalker' 'Smalltalk developer' 'Seaside street 3' '34567')
     ('Harry' 'Haskeller' 'Haskell developer' 'Applicative way 4' '45678')
     ('Diana' 'Devopser' 'DevOps specialist' 'Automation drive 5' '56789')
     ('Andy' 'Advocate' 'Developer advocate' 'Meetup blvd 6' '67890')) 
   do: [ :row |
		tx := xt store: (Person new
		 _xtId: (row at: 1);
	   firstName: (row at: 1); 
	   lastName: (row at: 2); 
	   jobTitle: (row at: 3);
	   address: (Address new 
	      streetAddress: (row at: 4);
	      postalCode: (row at: 5);
	      yourself);
      yourself)
  ].
  xt awaitTx: tx txId.
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
	
	results := (xt q: Person matching: [ :p | p firstName = 'Max' ]).
	
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
	
	results := (xt q: Person matching: [ :p | p firstName = 'Del' ]).	
	self assert: results size equals: 1.
	
	xt deleteAndWait: results first.
	results := (xt q: Person matching: [ :p | p firstName = 'Del' ]).
	self assert: results size equals: 0.
	
]

{ #category : #tests }
IntegrationTest >> testHistory [
  | tx1 tx2 person results |
	tx1 := xt storeAndWait: (Person new
	  _xtId: 'changeme';
	  firstName: 'Cha'; 
	  lastName: 'Ngeme'; 
	  address: (Address new 
			  	      streetAddress: 'Change avenue 1';
					  postalCode: '12345';
					  city: 'Kello';
					  country: #':FI';
					  yourself);
	yourself).
	
	results := (xt q: Person matching: [ :p | p firstName = 'Cha' ]).	
	self assert: results size equals: 1.
	
	person := results first.
	person firstName: 'Other'.
	person address streetAddress: 'Other road 2'.
	tx2 := xt storeAndWait: person.
	
	"After saving, it isn't found with old name, but is found with new name"
	self assert: (xt q: Person matching: [ :p | p firstName = 'Cha' ]) size equals: 0.
	self assert: (xt q: Person matching: [ :p | p firstName = 'Other' ]) size equals: 1.

   "Going back to history, the old name is still found and new name is not"
   self assert: ((xt atTxId: tx1 txId) q: Person matching: [ :p | p firstName = 'Cha' ]) size equals: 1.
   self assert: ((xt atTxId: tx1 txId) q: Person matching: [ :p | p firstName = 'Other' ]) size equals: 0.

]

{ #category : #tests }
IntegrationTest >> testQueryByChild [ 
  | results |
  self storeTestPersons .
  results := self q: [ :p | p address postalCode > '40000' ].
  self assert: results size equals: 3. "harry, diana, andy"

  results := self q: [ :p | (p address streetAddress textSearch: 'avenue') | (p firstName = 'Jack') ].
  self assert: results size equals: 2. "jack and carla"
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
  self storeTestPersons.

	results := self q: [ :p | p jobTitle textSearch: 'dev*' ].
	self assert: results size equals: 6.
	
	results := self q: [ :p | p jobTitle textSearch: 'developer' ].
	self assert: results size equals: 5.
	
	results := self q: [ :p | p jobTitle textSearch: 'small*' ].
	self assert: results size equals: 1.
	
  	
	
	
]
