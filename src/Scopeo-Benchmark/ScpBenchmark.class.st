Class {
	#name : 'ScpBenchmark',
	#superclass : 'Object',
	#instVars : [
		'numberOfMeasures',
		'measures'
	],
	#category : 'Scopeo-Benchmark',
	#package : 'Scopeo-Benchmark'
}

{ #category : 'execution' }
ScpBenchmark >> executeCode [

	self subclassResponsibility
]

{ #category : 'initialization' }
ScpBenchmark >> initialize [

	measures := OrderedCollection new.
	numberOfMeasures := 1.
]

{ #category : 'accessing' }
ScpBenchmark >> measures [

	^ measures
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
	result := [ self executeCode ] timeToRun asMilliSeconds.
	self tearDown.

	^ result.
]

{ #category : 'execution' }
ScpBenchmark >> setUp [
]

{ #category : 'execution' }
ScpBenchmark >> tearDown [
]
