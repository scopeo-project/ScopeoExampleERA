Class {
	#name : 'AMGroupTest',
	#superclass : 'TestCase',
	#instVars : [
		'group',
		'students'
	],
	#category : 'AmmoliteMagenta-Tests',
	#package : 'AmmoliteMagenta-Tests'
}

{ #category : 'running' }
AMGroupTest >> setUp [

	super setUp.

	group := AMGroup new.
	students := OrderedCollection new.
	($a to: $z) do: [ :letter | students add: (AMStudent new name: letter) ]
]

{ #category : 'tests' }
AMGroupTest >> testAddStudent [
	
	group addStudent: students last.
	group addStudent: students first.
	self assert: group students size equals: 2.
	self assert: group students first identicalTo: students first.
	self assert: group students second identicalTo: students last
]

{ #category : 'tests' }
AMGroupTest >> testdefaultStudents [
	
	self assert: group students isEmpty
]
