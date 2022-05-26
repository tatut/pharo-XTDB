Class {
	#name : #PersonTest,
	#superclass : #TestCase,
	#instVars : [
		'xt'
	],
	#category : #'XTDB-Examples-Tests'
}

{ #category : #running }
PersonTest >> setUp [
	super setUp.
	
	xt := XtClient new url: 'http://localhost:6666/_xtdb/'
]

{ #category : #tests }
PersonTest >> testAddPerson [
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
PersonTest >> testBuildPersonDocument [
	"Test that document builder builds documents properly"
	| builder p docs |
	builder := XtDocumentBuilder new.
	p := Person new
		firstName: 'Max'; 
		lastName: 'Feedpressure'; 
		address: (Address new 
						  streetAddress: 'Smalltalk street 1';
						  postalCode: '90123';
						  city: 'Kello';
						  country: #':FI';
					 	 yourself);
		yourself.
	builder build: p.
	docs := builder documents.
	self assert: (docs size = 2) description: 'Two documents built'.
	self assert: ((docs at: 1) at: #':address/street-address') equals: 'Smalltalk street 1'.
	self assert: ((docs at: 1) at: #':xt/id') equals: ((docs at: 2) at: #':address'). "link has id of child doc"
	self assert: ((docs at: 2) at: #':first-name') equals: 'Max'.
	
]

{ #category : #tests }
PersonTest >> testTextSearch [
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
