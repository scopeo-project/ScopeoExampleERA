Class {
	#name : 'ScpInstrumentationBenchmark',
	#superclass : 'ScpBenchmark',
	#instVars : [
		'traces',
		'testSuites'
	],
	#category : 'Scopeo-Benchmark-',
	#package : 'Scopeo-Benchmark',
	#tag : ''
}

{ #category : 'as yet unclassified' }
ScpInstrumentationBenchmark >> executeCode [

	traces scan: [ testSuites do: [ :s | s run ] ]
]

{ #category : 'initialization' }
ScpInstrumentationBenchmark >> initialize [

	numberOfBlockIterations := 100.
	numberOfMeasures := 1
]

{ #category : 'as yet unclassified' }
ScpInstrumentationBenchmark >> setUp [

	testSuites := 'AmmoliteMagenta-Tests' asPackage classes collect:[:c| c buildSuite].
]

{ #category : 'execution' }
ScpInstrumentationBenchmark >> tearDown [

	traces clean
]
