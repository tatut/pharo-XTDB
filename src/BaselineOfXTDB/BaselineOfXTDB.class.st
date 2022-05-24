Class {
	#name : #BaselineOfXTDB,
	#superclass : #BaselineOf,
	#category : #BaselineOfXTDB
}

{ #category : #baselines }
BaselineOfXTDB >> baseline: spec [
	<baseline>
	spec for: #common do: [ spec
		package: 'EDN' with: [ spec repository: 'github://tatut/pharo-EDN:main' ];
		package: 'XTDB' with: [ spec requires: 'EDN' ];
		package: 'XTDB-Query' with: [ spec requires: 'XTDB' ];
		package: 'XTDB-Examples' with: [ spec requires: 'XTDB-Query' ];
		package: 'XTDB-Examples-Tests' with: [ spec requires: 'XTDB-Examples' ];
		group: 'default' with: #('XTDB' 'XTDB-Query');
		group: 'ci' with: #('XTDB-Examples-Tests') "group to run tests in github actions"
	]
]
