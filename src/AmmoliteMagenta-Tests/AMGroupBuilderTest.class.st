Class {
	#name : 'AMGroupBuilderTest',
	#superclass : 'TestCase',
	#instVars : [
		'builder'
	],
	#category : 'AmmoliteMagenta-Tests',
	#package : 'AmmoliteMagenta-Tests'
}

{ #category : 'helpers' }
AMGroupBuilderTest >> groupListWithMarkers [

	^{'a+'. 'b-'. 'c'. 'd+'. 'e-'. 'f'} collect: [:name|AMStudent readFromString: name]
]

{ #category : 'running' }
AMGroupBuilderTest >> setUp [
	super setUp.
	
	builder := AMGroupBuilder new 
]

{ #category : 'helpers' }
AMGroupBuilderTest >> studentGroup [

	^ { 
		  (AMStudent readFromString: 'a+').
		  (AMStudent readFromString: 'b-').
		  (AMStudent readFromString: 'c') }
]

{ #category : 'tests' }
AMGroupBuilderTest >> testBuildGroupsAreShuffled [

	| groups g1 g2 g3 |
	"1/0."
	"groups := builder
		          buildGroups: 3
		          forStudents: self groupListWithMarkers.

	self assert: groups size equals: 3.
	
	g1 := groups first students.
	g2 := groups second students.
	g3 := groups third students.

	self assert: (g1 select: [ :s | s markerP ]) size equals: 1.
	self assert: (g2 select: [ :s | s markerP ]) size equals: 1.
	self assert: (g1 select: [ :s | s markerL ]) size equals: 1.
	self assert: (g2 select: [ :s | s markerL ]) size equals: 1.
	
	self assert: (g3 select: [ :s | s markerP or:[s markerL] ]) size equals: 0

"
]

{ #category : 'tests' }
AMGroupBuilderTest >> testBuildGroupsIds [

	| groups |
	groups := builder buildGroups: 5 forStudents: (($a to: $z) collect:[:e|  AMStudent readFromString: e asString]).
	self assert: groups first id equals: 1.
	self assert: groups second id equals: 2.
	self assert: groups third id equals: 3.
	self assert: groups fourth id equals: 4.
	self assert: groups fifth id equals: 5
]

{ #category : 'tests' }
AMGroupBuilderTest >> testBuildGroupsRepartition [

	| groups |
	groups := builder
		          buildGroups: 5
		          forStudents:
		          (($a to: $z) collect: [ :letter |  AMStudent readFromString: letter asString ]).

	self assert: groups first students size equals: 6.
	self assert: groups second students size equals: 5.
	self assert: groups third students size equals: 5.
	self assert: groups fourth students size equals: 5.
	self assert: groups fifth students size equals: 5
]

{ #category : 'tests' }
AMGroupBuilderTest >> testBuildGroupsSize [
	|groups|
	groups := builder buildGroups: 5 forStudents: (($a to: $z) collect:[:e|  AMStudent readFromString: e asString]).
	self assert: groups size equals: 5
]

{ #category : 'tests' }
AMGroupBuilderTest >> testBuildGroupsWithMarkersRepartition [

	| groups g1 g2 g3 |
	groups := builder
		          buildGroups: 3
		          forStudents: self groupListWithMarkers.

	self assert: groups size equals: 3.
	
	g1 := groups first students.
	g2 := groups second students.
	g3 := groups third students.

	self assert: (g1 select: [ :s | s markerP ]) size equals: 1.
	self assert: (g2 select: [ :s | s markerP ]) size equals: 1.
	self assert: (g1 select: [ :s | s markerL ]) size equals: 0.
	self assert: (g2 select: [ :s | s markerL ]) size equals: 1.
	self assert: (g3 select: [ :s | s markerL ]) size equals: 1.
	self assert: (g3 select: [ :s | s markerP or:[s markerL] ]) size equals: 1


]

{ #category : 'tests' }
AMGroupBuilderTest >> testLStackFrom [

	| students s |
	students := self studentGroup.
	s := builder lStackFrom: students.	
	self assert: s top equals: students second.
	self assert: s size equals: 1
]

{ #category : 'tests' }
AMGroupBuilderTest >> testNStackFrom [

	| students s |
	students := self studentGroup.
	s := builder nStackFrom: students.
	self assert: s top equals: students last.
	self assert: s size equals: 1
]

{ #category : 'tests' }
AMGroupBuilderTest >> testNewGroups [

	| groups |
	groups := builder newGroups: 3.
	self assert: groups first nextLink equals: groups second.
	self assert: groups second nextLink equals: groups third.
	self assert: groups third nextLink equals: groups first
]

{ #category : 'tests' }
AMGroupBuilderTest >> testPStackFrom [

	| students s |
	students := self studentGroup.
	s := builder pStackFrom: students.
	self assert: s top equals: students first.
	self assert: s size equals: 1
]

{ #category : 'tests' }
AMGroupBuilderTest >> testStackFillGroups [
"	1/0"
]

{ #category : 'tests' }
AMGroupBuilderTest >> testStackFrom [

	|s|
	s := builder stackFrom: #(1 2 3).
	self assert: s class equals: Stack.
	self assert: s pop equals: 3.
	self assert: s pop equals: 2.
	self assert: s pop equals: 1.
	self assert: s isEmpty 
]
