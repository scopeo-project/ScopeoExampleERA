Class {
	#name : 'ScpInstrumentedCodeWithTracesBch',
	#superclass : 'ScpSanerBenchmark',
	#category : 'Scopeo-Benchmark',
	#package : 'Scopeo-Benchmark'
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
