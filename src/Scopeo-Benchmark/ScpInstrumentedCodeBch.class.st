Class {
	#name : 'ScpInstrumentedCodeBch',
	#superclass : 'ScpSanerBenchmark',
	#category : 'Scopeo-Benchmark',
	#package : 'Scopeo-Benchmark'
}

{ #category : 'as yet unclassified' }
ScpInstrumentedCodeBch >> setUp [

	super setUp.
	traces := ScpTraces new
		tracer: ScpInstrumenterTracerMock new;
		traceStorage: ScpTracesMemoryStorageMock new;
		forPackages: #( 'AmmoliteMagenta' 'AmmoliteMagenta-Tests' );
		yourself.
]
