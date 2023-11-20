Class {
	#name : 'AMStudentTest',
	#superclass : 'TestCase',
	#instVars : [
		'student'
	],
	#category : 'AmmoliteMagenta-Tests',
	#package : 'AmmoliteMagenta-Tests'
}

{ #category : 'running' }
AMStudentTest >> setUp [
	super setUp.
	
	student := AMStudent new.
	student name: 'toto'
]

{ #category : 'tests' }
AMStudentTest >> testInitialMarker [

	self deny: student markerP.
	self deny: student markerL
]

{ #category : 'tests' }
AMStudentTest >> testIsPresent [
	self assert: student isPresent
]

{ #category : 'tests' }
AMStudentTest >> testMarkerL [

	student marker: $-.
	self assert: student markerL.
	self deny: student markerP
]

{ #category : 'tests' }
AMStudentTest >> testMarkerP [

	student marker: $+.
	self assert: student markerP.
	self deny: student markerL
]

{ #category : 'tests' }
AMStudentTest >> testMarkers [

	self
		assertCollection: AMStudent markers
		equals: (Array with: AMStudent markerP with: AMStudent markerL)
]

{ #category : 'tests' }
AMStudentTest >> testPrintOn [
	|str|
	str := WriteStream  on: String new.
	student printOn: str.
	self assert: str contents equals: student name
]

{ #category : 'tests' }
AMStudentTest >> testReadFromStringLMarker [

	student := AMStudent readFromString: ' Karl-Marx - '.
	self assert: student name equals: 'Karl-Marx'.
	self assert: student markerL
]

{ #category : 'tests' }
AMStudentTest >> testReadFromStringNoMarker [
	self assert: (AMStudent readFromString: ' Karl Marx ') name equals: 'Karl Marx'
	
]

{ #category : 'tests' }
AMStudentTest >> testReadFromStringPMarker [

	student := AMStudent readFromString: ' Karl Marx + '.
	self assert: student name equals: 'Karl Marx'.
	self assert: student markerP
]
