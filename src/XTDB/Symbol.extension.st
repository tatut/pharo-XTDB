Extension { #name : #Symbol }

{ #category : #'*XTDB' }
Symbol >> xtPopulate: obj from: value [
	obj perform: self with: value
]
