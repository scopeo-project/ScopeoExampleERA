Extension { #name : 'Stack' }

{ #category : '*AmmoliteMagenta' }
Stack >> fillGroups: groups startingAt: aGroup [

	| currentGroup |
	currentGroup := aGroup.
	[ self isEmpty ] whileFalse: [ 
		currentGroup value addStudent: self pop.
		currentGroup := currentGroup nextLink ].
	^ currentGroup
]
