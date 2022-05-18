Class {
	#name : #XtWhereTextSearch,
	#superclass : #XtWhereEAV,
	#category : #'XTDB-Query'
}

{ #category : #'as yet unclassified' }
XtWhereTextSearch >> inParameters [ 
	^ { (self inName: 'ts') -> v }
]

{ #category : #rendering }
XtWhereTextSearch >> render [
	^ { LinkedList withAll: { #'text-search' . a  . self inName: 'ts' } .
		  OrderedCollection with: (OrderedCollection with: e) } asOrderedCollection 
]
