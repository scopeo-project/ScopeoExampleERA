Class {
	#name : 'ScpPharoBch',
	#superclass : 'ScpSanerBenchmark',
	#category : 'Scopeo-Benchmark',
	#package : 'Scopeo-Benchmark'
}

{ #category : 'execution' }
ScpPharoBch >> executeCode [

	1000 timesRepeat: [ [ AMParsingBugExample new testStudentPrinting ] on: TestFailure do: [ "nothing" ] ]
]

{ #category : 'execution' }
ScpPharoBch >> tearDown [

]
