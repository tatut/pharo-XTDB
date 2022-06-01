Extension { #name : #Date }

{ #category : #'*XTDB' }
Date >> writeEDNTo: out [
  out << '#xtdb/local-date "'; << self yyyymmdd; << '"'
]
