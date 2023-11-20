"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : 'ManifestAmmoliteMagenta',
	#superclass : 'PackageManifest',
	#category : 'AmmoliteMagenta-Manifest',
	#package : 'AmmoliteMagenta',
	#tag : 'Manifest'
}

{ #category : 'code-critics' }
ManifestAmmoliteMagenta class >> ruleModifiesCollectionRuleV1FalsePositive [
	^ #(#(#(#RGPackageDefinition #(#AmmoliteMagenta)) #'2021-09-10T14:15:46.405491+02:00') )
]
