Class {
	#name : 'ScpInstrumentedCodeWithTracesBch',
	#superclass : 'ScpInstrumentationBenchmark',
	#category : 'Scopeo-Benchmark-',
	#package : 'Scopeo-Benchmark',
	#tag : ''
}

{ #category : 'as yet unclassified' }
ScpInstrumentedCodeWithTracesBch >> setUp [

	super setUp.
	traces := ScpTraces new
		tracer: ScpInstrumenterTracer new;
		traceStorage: ScpTracesMemoryStorageMock new;
		forPackages: #( 'AmmoliteMagenta' 'AmmoliteMagenta-Tests' );
		yourself.
]
