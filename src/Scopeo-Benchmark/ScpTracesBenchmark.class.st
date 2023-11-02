Class {
	#name : 'ScpTracesBenchmark',
	#superclass : 'ScpTraces',
	#category : 'Scopeo-Benchmark-',
	#package : 'Scopeo-Benchmark',
	#tag : ''
}

{ #category : 'initialization' }
ScpTracesBenchmark >> initialize [

	super initialize.
	
	tracer traceStorage: ScpFakeTracesMemoryStorage new.
]
