Class {
	#name : 'ScpInstrumentedCodeBch',
	#superclass : 'ScpInstrumentationBenchmark',
	#category : 'Scopeo-Benchmark-',
	#package : 'Scopeo-Benchmark',
	#tag : ''
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
