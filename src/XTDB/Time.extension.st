Extension { #name : #Time }

{ #category : #'*XTDB' }
Time >> writeEDNTo: out [
	out << '#xtdb/local-time "'; << self print24; << '"' 
]
