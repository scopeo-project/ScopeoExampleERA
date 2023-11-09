Class {
	#name : 'ScpSanerBenchmark',
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
ScpSanerBenchmark >> executeCode [

	traces scan: [ 1000 timesRepeat: [ testSuites do: [ :s | s run ] ] ]
]

{ #category : 'as yet unclassified' }
ScpSanerBenchmark >> setUp [

	testSuites := 'AmmoliteMagenta-Tests' asPackage classes collect:[:c| c buildSuite].
]

{ #category : 'execution' }
ScpSanerBenchmark >> tearDown [

	traces clean
]
