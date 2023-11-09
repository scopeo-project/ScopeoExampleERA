Class {
	#name : 'ScpIntrumentationInstallationBch',
	#superclass : 'ScpInstrumentationBenchmark',
	#category : 'Scopeo-Benchmark-',
	#package : 'Scopeo-Benchmark',
	#tag : ''
}

{ #category : 'execution' }
ScpIntrumentationInstallationBch >> executeCode [

	traces := ScpTraces new
		tracer: ScpInstrumenterTracerMock new;
		forPackages: #( 'AmmoliteMagenta' 'AmmoliteMagenta-Tests' );
		yourself.
]

{ #category : 'initialization' }
ScpIntrumentationInstallationBch >> initialize [

	numberOfBlockIterations := 1
]
