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
