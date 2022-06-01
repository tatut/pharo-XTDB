"
I am an EDN reader that adds support for java.time types in XTDB.
- Date to java.time.LocalDate
- Time to java.time.LocalTime
"
Class {
	#name : #XtEDNReader,
	#superclass : #EDNReader,
	#category : #XTDB
}

{ #category : #initialization }
XtEDNReader >> initialize [ 
  super initialize.
  self handle: 'xtdb/local-date' with: [ :_tag :data | self readLocalDate: data ].
  self handle: 'xtdb/local-time' with: [ :_tag :data | self readLocalTime: data ].

]

{ #category : #'as yet unclassified' }
XtEDNReader >> readLocalDate: data [ 
  ^ Date fromString: data
]

{ #category : #'as yet unclassified' }
XtEDNReader >> readLocalTime: data [ 
  ^ Time fromString: data
]
