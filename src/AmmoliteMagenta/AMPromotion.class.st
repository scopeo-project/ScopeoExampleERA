"
I represent a promotion of students: 
- I have a name
- I have a list of students
"
Class {
	#name : 'AMPromotion',
	#superclass : 'Object',
	#instVars : [
		'name',
		'students'
	],
	#category : 'AmmoliteMagenta-model',
	#package : 'AmmoliteMagenta',
	#tag : 'model'
}

{ #category : 'instance creation' }
AMPromotion class >> readFromAssociation: association [

	| promotion |
	promotion := self new.
	promotion name: association key.
	promotion students: ((association value reject:[:s| s isEmpty]) collect: [ :string | 
			 AMStudent readFromString: string trimBoth ]).
	^ promotion
]

{ #category : 'instance creation' }
AMPromotion class >> readFromDisk [

	^ AMLocalRepository readAllPromotions collect: [ :association | 
		  self readFromAssociation: association ]
]

{ #category : 'accessing' }
AMPromotion >> name [

	^ name
]

{ #category : 'accessing' }
AMPromotion >> name: anObject [

	name := anObject
]

{ #category : 'API' }
AMPromotion >> pickRandomStudent [
	^self students atRandom
]

{ #category : 'accessing' }
AMPromotion >> size [
	^self students size
]

{ #category : 'accessing' }
AMPromotion >> students [

	^ students ifNil: [ students := OrderedCollection new ]
]

{ #category : 'accessing' }
AMPromotion >> students: anObject [

	students := anObject
]
