Class {
	#name : 'ScpMessageSenderClassEq',
	#superclass : 'ScpUnaryPredicate',
	#category : 'Scopeo-Predicates-',
	#package : 'Scopeo-Predicates',
	#tag : ''
}

{ #category : 'verifying' }
ScpMessageSenderClassEq >> verify: aScpData [

	^ aScpData sender class == value
]
