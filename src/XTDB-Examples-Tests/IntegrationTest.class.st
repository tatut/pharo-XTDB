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
 ^ (xt q: Person where: block)
]

{ #category : #running }
IntegrationTest >> setUp [
	super setUp.
	xt := XtClient new url: 'http://localhost:6666/_xtdb/'

]

{ #category : #'as yet unclassified' }
IntegrationTest >> storeTestPersons [
  | tx |
  #( ('Jack' 'Javaman' 'Java developer' 'Spring road 1' '12345' '1981-01-02') 
     ('Carla' 'Clojurian' 'Clojure developer' 'Ring avenue 2' '23456' '1985-03-04')
     ('Sally' 'Smalltalker' 'Smalltalk developer' 'Seaside street 3' '34567' '1990-04-10')
     ('Harry' 'Haskeller' 'Haskell developer' 'Applicative way 4' '45678' '2000-04-20')
     ('Diana' 'Devopser' 'DevOps specialist' 'Automation drive 5' '56789' '1999-10-27')
     ('Andy' 'Advocate' 'Developer advocate' 'Meetup blvd 6' '67890' '1979-07-22')) 
   do: [ :row |
		tx := xt store: (Person new
		 _xtId: (row at: 1);
	   firstName: (row at: 1); 
	   lastName: (row at: 2); 
	   jobTitle: (row at: 3);
	   dateOfBirth: (Date fromString: (row at: 6));
	   address: (Address new 
	      streetAddress: (row at: 4);
	      postalCode: (row at: 5);
	      yourself);
      yourself)
  ].
  xt awaitTx: tx txId.
]

{ #category : #'as yet unclassified' }
IntegrationTest >> storeTestTrainings [ 
  | tx |
  #( ('Learn XTDB' 'Learn the basics of XTDB and Datalog' '2022-06-01' '13:00' '14:30')
     ('Morning coffee' 'How to make coffee' '2022-07-22' '08:00' '08:30')
     ('How to wake up early' 'Win the day with this one weird trick' '2030-04-08' '06:15' '06:45')
     ('Night school' 'Learn the things you didn''t during the day' '2023-01-30' '22:00' '23:45' ))
   doWithIndex: [ :row :i |
	  tx := xt store: (Training new
			_xtId: 'training',i asString; 
			name: (row at: 1);
			description: (row at: 2);
			date: (Date fromString: (row at: 3));
			startTime: (Time fromString: (row at: 4));
			endTime: (Time fromString: (row at: 5));
			yourself).
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
	
	results := (xt q: Person where: [ :p | p firstName = 'Max' ]).
	
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
	
	results := (xt q: Person where: [ :p | p firstName = 'Del' ]).	
	self assert: results size equals: 1.
	
	xt deleteAndWait: results first.
	results := (xt q: Person where: [ :p | p firstName = 'Del' ]).
	self assert: results size equals: 0.
	
]

{ #category : #tests }
IntegrationTest >> testDate [
  | jack |
  self storeTestPersons.

  "Test that queries using local dates work as expected"
  self assert: (self q: [ :p | p dateOfBirth < (Date fromString: '2000-01-01') ]) size equals: 5.
  self assert: (self q: [ :p | p dateOfBirth > (Date fromString: '2000-01-01') ]) size equals: 1.
	jack := (self q: [:p | p dateOfBirth = (Date fromString: '1981-01-2') ]) first.
	self assert: jack firstName equals: 'Jack'
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
	
	results := (xt q: Person where: [ :p | p firstName = 'Cha' ]).	
	self assert: results size equals: 1.
	
	person := results first.
	person firstName: 'Other'.
	person address streetAddress: 'Other road 2'.
	tx2 := xt storeAndWait: person.
	
	"After saving, it isn't found with old name, but is found with new name"
	self assert: (xt q: Person by: #firstName value: 'Cha') size equals: 0.
	self assert: (xt q: Person by: #firstName value: 'Other') size equals: 1.

   "Going back to history, the old name is still found and new name is not"
   self assert: ((xt atTxId: tx1 txId) q: Person by: #firstName value: 'Cha') size equals: 1.
   self assert: ((xt atTxId: tx1 txId) q: Person by: #firstName value: 'Other') size equals: 0.

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

{ #category : #tests }
IntegrationTest >> testTime [
  | results |
  self storeTestTrainings.
		
  results := xt q: Training by: #startTime value: (Time fromString: '13:00').
  self assert: results size equals: 1.
  self assert: results first name equals: 'Learn XTDB'.

  "Morning sessions (before 10) "
  results := xt q: Training where: [ :t | t startTime < '10' asTime ].
  self assert: results size equals: 2.

  "Very early sessions"
  results := xt q: Training where: [ :t | t startTime < '7' asTime ].
  self assert: results size equals: 1.
  self assert: results first name equals: 'How to wake up early'

]
