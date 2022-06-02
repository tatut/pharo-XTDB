"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestXTDB,
	#superclass : #PackageManifest,
	#category : #'XTDB-Manifest'
}

{ #category : #'code-critics' }
ManifestXTDB class >> ruleCollectionMessagesToExternalObjectRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#XtEntityMapping #, #false)) #'2022-06-02T18:24:03.635962+03:00') )
]
