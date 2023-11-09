Class {
	#name : 'ScpBenchmark',
	#superclass : 'Object',
	#instVars : [
		'numberOfBlockIterations',
		'numberOfMeasures',
		'measures'
	],
	#classInstVars : [
		'instance'
	],
	#category : 'Scopeo-Benchmark',
	#package : 'Scopeo-Benchmark'
}

{ #category : 'running' }
ScpBenchmark class >> executeCode [

	self instance executeCode
]

{ #category : 'accessing' }
ScpBenchmark class >> instance [

	^ instance ifNil: [ instance := self new ]
]

{ #category : 'running' }
ScpBenchmark class >> setUp [

	self instance setUp
]

{ #category : 'running' }
ScpBenchmark class >> tearDown [

	self instance tearDown
]

{ #category : 'execution' }
ScpBenchmark >> executeCode [

	self subclassResponsibility
]

{ #category : 'initialization' }
ScpBenchmark >> initialize [

	measures := OrderedCollection new.
	numberOfBlockIterations := 1.
	numberOfMeasures := 1.
]

{ #category : 'accessing' }
ScpBenchmark >> measures [

	^ measures
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

	numberOfMeasures timesRepeat: [ measures add: self performOnce ]
]

{ #category : 'execution' }
ScpBenchmark >> performOnce [

	| result |

	self setUp.
	result := [ numberOfBlockIterations timesRepeat: [ self executeCode ] ] timeToRun asMilliSeconds.
	self tearDown.

	^ result.
]

{ #category : 'execution' }
ScpBenchmark >> setUp [
]

{ #category : 'execution' }
ScpBenchmark >> tearDown [
]
