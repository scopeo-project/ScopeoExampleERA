"
I am a dumb model of a student, just representing the student by her name.
"
Class {
	#name : 'AMStudent',
	#superclass : 'Object',
	#instVars : [
		'name',
		'marker',
		'isPresent'
	],
	#category : 'AmmoliteMagenta-model',
	#package : 'AmmoliteMagenta',
	#tag : 'model'
}

{ #category : 'api' }
AMStudent class >> markerL [

	^ $-
]

{ #category : 'api' }
AMStudent class >> markerP [

	^ $+
]

{ #category : 'api' }
AMStudent class >> markers [

	^ Array with: self markerP with: self markerL
]

{ #category : 'reading' }
AMStudent class >> readFromString: aString [

	| student workingString endIndex |
	student := self new.
	workingString := aString trimBoth.
	endIndex := workingString size.
	(self markers includes: workingString last) ifTrue: [ 
		student marker: workingString last.
		endIndex := workingString size - 1 ].
	student name: (workingString copyFrom: 1 to: endIndex) trimBoth.
	^ student
]

{ #category : 'comparing' }
AMStudent >> <= anAMStudent [ 
	^name <= anAMStudent name
]

{ #category : 'comparing' }
AMStudent >> = anObject [

	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ name = anObject name and: [ marker = anObject marker ]
]

{ #category : 'comparing' }
AMStudent >> hash [

	"Answer an integer value that is related to the identity of the receiver."

	^ name hash bitXor: marker hash
]

{ #category : 'accessing' }
AMStudent >> isPresent [

	^ isPresent ifNil: [ isPresent := true ]
]

{ #category : 'accessing' }
AMStudent >> isPresent: anObject [

	isPresent := anObject
]

{ #category : 'accessing' }
AMStudent >> marker [

	^ marker
]

{ #category : 'accessing' }
AMStudent >> marker: anObject [

	marker := anObject
]

{ #category : 'api' }
AMStudent >> markerL [

	^ marker = $-
]

{ #category : 'api' }
AMStudent >> markerP [

	^ marker = $+
]

{ #category : 'accessing' }
AMStudent >> name [

	^ name
]

{ #category : 'accessing' }
AMStudent >> name: anObject [

	name := anObject
]

{ #category : 'printing' }
AMStudent >> printOn: aStream [

	aStream << self name
]

{ #category : 'printing' }
AMStudent >> textPrintForGroup: group on: aStream [ 

	group textPrintStudent: self on: aStream
]

{ #category : 'printing' }
AMStudent >> textPrintOn: aStream [

	aStream << self name asText
]
