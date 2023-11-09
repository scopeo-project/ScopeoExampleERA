Class {
	#name : 'ScpSanerBenchmark',
	#superclass : 'ScpBenchmark',
	#instVars : [
		'traces',
		'testSuites'
	],
	#category : 'Scopeo-Benchmark',
	#package : 'Scopeo-Benchmark'
}

{ #category : 'as yet unclassified' }
ScpSanerBenchmark >> executeCode [

	traces scan: [ 1000 timesRepeat: [ 
			[ AMParsingBugExample new testStudentPrinting ] on: TestFailure do: [ "nothing" ]
	] ]
]

{ #category : 'execution' }
ScpSanerBenchmark >> tearDown [

	traces clean
]
