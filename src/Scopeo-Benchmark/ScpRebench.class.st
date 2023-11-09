Class {
	#name : 'ScpRebench',
	#superclass : 'Object',
	#instVars : [
		'benchmark'
	],
	#classInstVars : [
		'instance'
	],
	#category : 'Scopeo-Benchmark',
	#package : 'Scopeo-Benchmark'
}

{ #category : 'accessing' }
ScpRebench class >> instance [

	^ instance ifNil: [ instance := self new ]
]

{ #category : 'accessing' }
ScpRebench >> benchmark [

	^ benchmark
]

{ #category : 'accessing' }
ScpRebench >> benchmark: aBenchmark [

	benchmark := aBenchmark
]

{ #category : 'execution' }
ScpRebench >> execute [

	^ self benchmark executeCode
]

{ #category : 'registry' }
ScpRebench >> register: aBenchmarkClass [

	self benchmark: aBenchmarkClass new.
	self benchmark setUp.
]

{ #category : 'initialization' }
ScpRebench >> reset [

	benchmark tearDown.
	benchmark := nil
]
