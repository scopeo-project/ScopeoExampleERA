Class {
	#name : 'ScopeoBenchmark',
	#superclass : 'Object',
	#instVars : [
		'pharoBlock',
		'scopeoBlock',
		'numberOfMeasures',
		'pharoTimes',
		'scopeoTimes',
		'dastTimes',
		'dastBlock'
	],
	#category : 'Scopeo-Benchmark',
	#package : 'Scopeo-Benchmark'
}

{ #category : 'accesses' }
ScopeoBenchmark >> dastTimes [

	^ dastTimes
]

{ #category : 'services' }
ScopeoBenchmark >> execute [

	self executeWithPharo.
	self executeWithDAST.
	self executeWithScopeo.
]

{ #category : 'as yet unclassified' }
ScopeoBenchmark >> executeWithDAST [

	dastTimes removeAll.
	numberOfMeasures timesRepeat: [ 
		dastTimes add: (dastBlock timeToRun)
	].
]

{ #category : 'as yet unclassified' }
ScopeoBenchmark >> executeWithPharo [

	pharoTimes removeAll.
	numberOfMeasures timesRepeat: [ 
		pharoTimes add: (pharoBlock timeToRun)
	].
]

{ #category : 'as yet unclassified' }
ScopeoBenchmark >> executeWithScopeo [

	scopeoTimes removeAll.
	numberOfMeasures timesRepeat: [ 
		scopeoTimes add: (scopeoBlock timeToRun)
	]
]

{ #category : 'as yet unclassified' }
ScopeoBenchmark >> exportToCSV: aFilePath [

	aFilePath asFileReference ensureCreateFile writeStreamDo: [
		:writeStream |
		| csv |
		csv := NeoCSVWriter on: writeStream.
		csv writeHeader: #( 'Pharo' 'DAST' 'Scopeo' ).
		1 to: numberOfMeasures do: [ :i |
			csv nextPut: { 
					(pharoTimes at: i) asNanoSeconds .
					(dastTimes at: i) asNanoSeconds.
					(scopeoTimes at: i) asNanoSeconds  
			}
		].
		csv close 
	]
]

{ #category : 'initialization' }
ScopeoBenchmark >> initialize [

	pharoTimes := OrderedCollection new.
	dastTimes := OrderedCollection new.
	scopeoTimes := OrderedCollection new.
]

{ #category : 'parameters' }
ScopeoBenchmark >> loops: aNumber [

	pharoBlock := [ aNumber timesRepeat: [ self toExecuteWithPharo ] ].
	dastBlock := [ aNumber timesRepeat: [ self toExecuteWithDAST ] ].
	scopeoBlock := [ aNumber timesRepeat: [ self toExecuteWithScopeo ] ]
]

{ #category : 'parameters' }
ScopeoBenchmark >> measures: aNumber [

	numberOfMeasures := aNumber
	
]

{ #category : 'accesses' }
ScopeoBenchmark >> pharoTimes [

	^ pharoTimes
]

{ #category : 'accesses' }
ScopeoBenchmark >> scopeoTimes [

	^ scopeoTimes
]

{ #category : 'private' }
ScopeoBenchmark >> toExecuteWithDAST [

	^ DASTInterpreter new evaluateAST: (RBParser parseExpression: 'AMParsingBugExample new testStudentPrinting')
]

{ #category : 'private' }
ScopeoBenchmark >> toExecuteWithPharo [
		
	^ [ AMParsingBugExample new testStudentPrinting ] on: TestFailure do: [ ]
]

{ #category : 'private' }
ScopeoBenchmark >> toExecuteWithScopeo [

	^ ScpTracesBenchmark new scan: 'AMParsingBugExample new testStudentPrinting'
]
