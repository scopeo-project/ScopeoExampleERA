Class {
	#name : 'ScopeoBenchmarks',
	#superclass : 'Object',
	#instVars : [
		'numberOfBlockIterations',
		'numberOfMeasures',
		'results',
		'pharoBlock'
	],
	#category : 'Scopeo-Benchmark',
	#package : 'Scopeo-Benchmark'
}

{ #category : 'services' }
ScopeoBenchmarks >> exportRawResults: aCSVFilePath [

	 aCSVFilePath asFileReference ensureCreateFile writeStreamDo: [
		:writeStream |
		| csv |
		csv := NeoCSVWriter on: writeStream.
		self writeRawResults: csv.
		csv close 
	]
]

{ #category : 'services' }
ScopeoBenchmarks >> exportResults: aCSVFilePath [

	 aCSVFilePath asFileReference ensureCreateFile writeStreamDo: [
		:writeStream |
		| csv |
		csv := NeoCSVWriter on: writeStream.
		self writeResults: csv.
		csv close 
	]
]

{ #category : 'initialization' }
ScopeoBenchmarks >> initialize [
	
	pharoBlock := [ [ AMParsingBugExample new testStudentPrinting ] on: TestFailure do: [ ] ].
	results := Dictionary new.
]

{ #category : 'private' }
ScopeoBenchmarks >> measuresAsArray [

	| array |
	self results ifEmpty: [ ^ Array new ].
	array := CTArray2D width: self results size height: numberOfMeasures.
	1 to: self results size do: [ :i |
		array atColumn: i put: ((self results values at: i) measures).
	].
	^ array
	
]

{ #category : 'services' }
ScopeoBenchmarks >> numberOfBlockIterations: anObject [

	numberOfBlockIterations := anObject
]

{ #category : 'services' }
ScopeoBenchmarks >> numberOfMeasures: anObject [

	numberOfMeasures := anObject
]

{ #category : 'services' }
ScopeoBenchmarks >> performWithDAST [
	
	| interpreter |

	interpreter	:= DASTInterpreter new.

	results at: 'dast' put: (ScpBenchmark new
		label: 'DAST';
		block: [ interpreter evaluateAST: (RBParser parseExpression: 'AMParsingBugExample new testStudentPrinting') ];
		numberOfBlockIterations: numberOfBlockIterations;
		numberOfMeasures: numberOfMeasures;
		perform;
		result)
		
]

{ #category : 'services' }
ScopeoBenchmarks >> performWithDASTAndTraces [

	| scpTraces |
	scpTraces := ScpTraces new
		                     tracer: ScpTracingInterpreter new;
		                     traceStorage: ScpFakeTracesMemoryStorage new;
		                     forPackages:
			                     #( 'AmmoliteMagenta' 'AmmoliteMagenta-Tests' );
		                     yourself.
	results at: 'dast-traces' put: (ScpBenchmark new
			 label: 'DAST with traces';
			 block: [
				 scpTraces scan:
						 'AMParsingBugExample new testStudentPrinting' ];
			 numberOfBlockIterations: numberOfBlockIterations;
			 numberOfMeasures: numberOfMeasures;
			 perform;
			 result).

	scpTraces clean
]

{ #category : 'services' }
ScopeoBenchmarks >> performWithInstrumenter [

	| instrumenter |
	MetaLink uninstallAll.
	instrumenter := ScopeoInstrumenter forPackages: (
		#( 'AmmoliteMagenta' 'AmmoliteMagenta-Tests' ) collect: #asPackage
	).
	instrumenter instrumentPackages.

	results at: 'instrumenter' put: (ScpBenchmark new
			 label: 'Instrumenter';
			 block: pharoBlock;
			 numberOfBlockIterations: numberOfBlockIterations;
			 numberOfMeasures: numberOfMeasures;
			 perform;
			 result).

	instrumenter uninstall
]

{ #category : 'services' }
ScopeoBenchmarks >> performWithInstrumenterAndTraces [

	| scpTraces |
	scpTraces := ScpTraces new
		             tracer: ScopeoInstrumenterTracer new;
		             traceStorage: ScpFakeTracesMemoryStorage new;
		             forPackages:
			             #( 'AmmoliteMagenta' 'AmmoliteMagenta-Tests' );
		             yourself.

	results at: 'instrumenter-traces' put: (ScpBenchmark new
			 label: 'Instrumenter with traces';
			 block: [
				 [ scpTraces scan: 'AMParsingBugExample new testStudentPrinting'] on: TestFailure do: [ "ignore" ] ];
			 numberOfBlockIterations: numberOfBlockIterations;
			 numberOfMeasures: numberOfMeasures;
			 perform;
			 result).

	scpTraces clean
]

{ #category : 'services' }
ScopeoBenchmarks >> performWithInstrumenterInstallation [

	| instrumenter |
	instrumenter := ScopeoInstrumenter new.
	instrumenter packages:
		(#( 'AmmoliteMagenta' 'AmmoliteMagenta-Tests' ) collect: #asPackage).

	results at: 'instrumenter-installation' put: (ScpBenchmark new
			 label: 'Instrumenter installation time';
			 block: [ instrumenter instrumentPackages. instrumenter uninstall ];
			 numberOfBlockIterations: numberOfBlockIterations;
			 numberOfMeasures: numberOfMeasures;
			 perform;
			 result).

	instrumenter uninstall
]

{ #category : 'services' }
ScopeoBenchmarks >> performWithPharo [

	results at: 'pharo' put: (ScpBenchmark new
		label: 'Pharo';
		block: pharoBlock;
		numberOfBlockIterations: numberOfBlockIterations;
		numberOfMeasures: numberOfMeasures;
		perform;
		result)
		
]

{ #category : 'accessing' }
ScopeoBenchmarks >> results [

	^ results
]

{ #category : 'private' }
ScopeoBenchmarks >> writeRawResults: aCSVWriter [

	| size resultsValues measures |
	size := self results size.
	resultsValues := self results values.
	measures := resultsValues collect: [ :r | r measures].
	
	aCSVWriter writeHeader: (resultsValues collect: [ :r | r label ]).
	
	1 to: numberOfMeasures do: [ :i | 
		aCSVWriter nextPut: ((1 to: size) collect: [ :j | (measures at: j) at: i ])	  
	]. 
]

{ #category : 'private' }
ScopeoBenchmarks >> writeResults: aCSVWriter [

	| headers averages cis |
	
	
	headers := OrderedCollection new.
	headers add: 'Metrics'.
	headers addAll: (self results values collect: [ :r | r label ]).	
	
	averages := OrderedCollection new.
	averages add: 'Average'.
	averages addAll: (self results values collect: [ :r | r average ]).
	
	cis := OrderedCollection new.
	cis add: 'Confidence interval'.
	cis addAll: (self results values collect: [ :r | r ci ]).

	aCSVWriter writeHeader: headers.
	aCSVWriter nextPut: averages.
	aCSVWriter nextPut: cis.	
]
