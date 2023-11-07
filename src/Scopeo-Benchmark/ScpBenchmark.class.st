Class {
	#name : 'ScpBenchmark',
	#superclass : 'Object',
	#instVars : [
		'label',
		'block',
		'numberOfBlockIterations',
		'numberOfMeasures',
		'measures',
		'result',
		'inNanoseconds'
	],
	#category : 'Scopeo-Benchmark',
	#package : 'Scopeo-Benchmark'
}

{ #category : 'accessing' }
ScpBenchmark >> block [

	^ block
]

{ #category : 'accessing' }
ScpBenchmark >> block: anObject [

	block := anObject
]

{ #category : 'initialization' }
ScpBenchmark >> inNanoseconds [

	inNanoseconds := true.
]

{ #category : 'initialization' }
ScpBenchmark >> initialize [

	inNanoseconds := false
]

{ #category : 'accessing' }
ScpBenchmark >> label [

	^ label
]

{ #category : 'accessing' }
ScpBenchmark >> label: anObject [

	label := anObject
]

{ #category : 'accessing' }
ScpBenchmark >> numberOfBlockIterations [

	^ numberOfBlockIterations
]

{ #category : 'accessing' }
ScpBenchmark >> numberOfBlockIterations: anObject [

	numberOfBlockIterations := anObject
]

{ #category : 'accessing' }
ScpBenchmark >> numberOfMeasures [

	^ numberOfMeasures
]

{ #category : 'accessing' }
ScpBenchmark >> numberOfMeasures: anObject [

	numberOfMeasures := anObject
]

{ #category : 'execution' }
ScpBenchmark >> perform [

	result := ScpBenchmarkResult new label: label.
	numberOfMeasures timesRepeat: [
		| time |
		time := [ numberOfBlockIterations timesRepeat: block ] timeToRun.
		inNanoseconds
			ifTrue: [ result addMeasure: time asNanoSeconds ]
			ifFalse: [ result addMeasure: time asMilliSeconds ] 
	]
]

{ #category : 'accessing' }
ScpBenchmark >> result [

	^ result
]
