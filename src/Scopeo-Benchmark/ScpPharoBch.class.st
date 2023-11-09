Class {
	#name : 'ScpPharoBch',
	#superclass : 'ScpSanerBenchmark',
	#category : 'Scopeo-Benchmark-',
	#package : 'Scopeo-Benchmark',
	#tag : ''
}

{ #category : 'execution' }
ScpPharoBch >> executeCode [

	1000 timesRepeat: [ testSuites do: [ :s | s run ] ]
]

{ #category : 'execution' }
ScpPharoBch >> tearDown [

]
