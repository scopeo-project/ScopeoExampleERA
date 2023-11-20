Class {
	#name : 'AMParsingBugExample',
	#superclass : 'TestCase',
	#instVars : [
		'instrumenter',
		'group',
		'promotion',
		'students'
	],
	#category : 'AmmoliteMagenta-Tests',
	#package : 'AmmoliteMagenta-Tests'
}

{ #category : 'running' }
AMParsingBugExample >> createGroup [
	group := AMGroup new
]

{ #category : 'running' }
AMParsingBugExample >> createPromotion [
	
	promotion := AMPromotion new.
	promotion name: 'OCRE xp'.

	students := (self studentsList splitOn: Character cr) collect: [
		            :studentDataString |
		            | student |
		            student := AMStudent new.
		           	student data: studentDataString.
		            student ].
	promotion students: students.

	^ promotion
]

{ #category : 'accessing' }
AMParsingBugExample >> group [

	^ group
]

{ #category : 'accessing' }
AMParsingBugExample >> group: anObject [

	group := anObject
]

{ #category : 'initialization' }
AMParsingBugExample >> initialize [
	super initialize.
	instrumenter := [ :students :group| ]
]

{ #category : 'accessing' }
AMParsingBugExample >> instrumenter [

	^ instrumenter
]

{ #category : 'accessing' }
AMParsingBugExample >> instrumenter: anObject [

	instrumenter := anObject
]

{ #category : 'initialization' }
AMParsingBugExample >> promotion [

	^ promotion
]

{ #category : 'accessing' }
AMParsingBugExample >> promotion: anObject [

	promotion := anObject
]

{ #category : 'running' }
AMParsingBugExample >> readPromotion: promotion [

	promotion students do: [ :student |
		| readStream |
		readStream := student data readStream.
		student name: (readStream upTo: Character space).
		student marker: readStream upToEnd ]
]

{ #category : 'initialization' }
AMParsingBugExample >> students [
	^students
]

{ #category : 'accessing' }
AMParsingBugExample >> students: anObject [

	students := anObject
]

{ #category : 'initialization' }
AMParsingBugExample >> studentsList [
	^'Nath -
Adèle +
William -
Marguerite +
Valérie -
Danielle -
Margot +
Diane +
Thibault -
Thomas +
Margaud -
Julie -
Charles-Thibault +
Alix +
Philippine -
Victoire -
Frédérique +
Adèle +
Constance +
Alex -
Isaac-Guillaume +
Élisabeth +
Guy -
Charles -
Raymond-Tristan +
Inès-Hélène +
Jean +
Alex +
Henri +
Jules -
Dorothée +
Alexandria +
Jacques -
Adèle +
Catherine -'
]

{ #category : 'running' }
AMParsingBugExample >> testStudentPrinting [

	self readPromotion: promotion.
	students do: [ :s |
		| str |
		str := WriteStream on: String new.
		group textPrintStudent: s on: str.
		self assert: (#( $- $+ ) includes: str contents last) ]
]

{ #category : 'running' }
AMParsingBugExample >> testStudentSign [

	self assert: (self promotion students allSatisfy: [:s | s markerL or:[s markerP]]) 
]
