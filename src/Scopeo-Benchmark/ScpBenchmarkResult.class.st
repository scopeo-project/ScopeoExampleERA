Class {
	#name : 'ScpBenchmarkResult',
	#superclass : 'Object',
	#instVars : [
		'label',
		'measures'
	],
	#category : 'Scopeo-Benchmark',
	#package : 'Scopeo-Benchmark'
}

{ #category : 'adding' }
ScpBenchmarkResult >> addMeasure: aMeasure [

	measures add: aMeasure
]

{ #category : 'accessing' }
ScpBenchmarkResult >> average [

	^ measures average asFloat
]

{ #category : 'accessing' }
ScpBenchmarkResult >> ci [

	^ (self average) asString
		, ' ± ' 
		, (1.96 * (measures standardDeviation / measures size sqrt)) asString
]

{ #category : 'initialization' }
ScpBenchmarkResult >> initialize [

	measures := OrderedCollection new.
]

{ #category : 'accessing' }
ScpBenchmarkResult >> label [

	^ label
]

{ #category : 'accessing' }
ScpBenchmarkResult >> label: anObject [

	label := anObject
]

{ #category : 'accessing' }
ScpBenchmarkResult >> measures [

	^ measures
]
