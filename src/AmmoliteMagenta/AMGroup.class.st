"
I represent a group of students sorted by name.
"
Class {
	#name : 'AMGroup',
	#superclass : 'Object',
	#instVars : [
		'id',
		'name',
		'students'
	],
	#category : 'AmmoliteMagenta-model',
	#package : 'AmmoliteMagenta',
	#tag : 'model'
}

{ #category : 'adding' }
AMGroup >> addStudent: anAMStudent [
	self students add: anAMStudent
]

{ #category : 'accessing' }
AMGroup >> id [

	^ id
]

{ #category : 'accessing' }
AMGroup >> id: anInteger [ 
	id := anInteger
]

{ #category : 'adding' }
AMGroup >> students [

	^ students ifNil: [ 
		  students := SortedCollection sortBlock: [ :a :b | a name < b name ] ]
]

{ #category : 'printing' }
AMGroup >> textPrintOn: stream [

	stream << ('[ ' , id printString , ' ]') asText allBold.
	stream cr.
	students do: [ :s | 
		s textPrintForGroup: self on: stream.

		s = students last ifFalse: [ stream cr ] ]
]

{ #category : 'printing' }
AMGroup >> textPrintStudent: student on: stream [
	
	student textPrintOn: stream.
	({ '+'. '-' } includes: student marker) ifFalse: [ ^ self ].

	stream space.
	stream << student marker asString
]
