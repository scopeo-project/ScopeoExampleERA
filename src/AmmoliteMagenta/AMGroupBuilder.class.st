"
I randomly build groups of students, given a number of groups and a list of students.
"
Class {
	#name : 'AMGroupBuilder',
	#superclass : 'Object',
	#category : 'AmmoliteMagenta-model',
	#package : 'AmmoliteMagenta',
	#tag : 'model'
}

{ #category : 'api - building' }
AMGroupBuilder >> buildGroups: n forStudents: studentList [

	| groups students pStack lStack nStack currentGroup |
	groups := self newGroups: n.

	students := studentList shuffled.

	pStack := (self pStackFrom: students).
	lStack := (self lStackFrom: students).
	nStack := (self nStackFrom: students).
	
	currentGroup := groups first.
	currentGroup := pStack fillGroups: groups startingAt: currentGroup.
	currentGroup := nStack fillGroups: groups startingAt: currentGroup.
	lStack fillGroups: groups startingAt: currentGroup.

	^ groups collect:[:g| g value]
]

{ #category : 'private' }
AMGroupBuilder >> lStackFrom: students [

	^ self stackFrom: (students select: [ :s | s markerL ])
]

{ #category : 'private' }
AMGroupBuilder >> nStackFrom: students [

	^ self stackFrom:
		  (students reject: [ :s | s markerP or: [ s markerL ] ])
]

{ #category : 'private' }
AMGroupBuilder >> newGroups: n [

	| groups |
	groups := OrderedCollection new.
	1 to: n do: [ :i | 
		| grp |
		grp := AMGroup new asLink.
		grp value id: i.
		groups add: grp.
		i > 1 ifTrue: [ (groups at: i - 1) nextLink: grp ] ].
	groups last nextLink: groups first.
	^ groups
]

{ #category : 'private' }
AMGroupBuilder >> pStackFrom: students [

	^ self stackFrom: (students select: [ :s | s markerP ])
]

{ #category : 'private' }
AMGroupBuilder >> stackFrom: students [

	| stack |
	stack := Stack new.
	students do: [ :s | stack push: s ].

	^ stack
]
