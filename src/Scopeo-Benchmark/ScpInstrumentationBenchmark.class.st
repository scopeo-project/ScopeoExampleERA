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

	traces scan: [ 1000 timesRepeat: [ testSuites do: [ :s | s run ] ] ]
]

{ #category : 'as yet unclassified' }
ScpInstrumentationBenchmark >> setUp [

	testSuites := 'AmmoliteMagenta-Tests' asPackage classes collect:[:c| c buildSuite].
]

{ #category : 'execution' }
ScpInstrumentationBenchmark >> tearDown [

	traces clean
]
