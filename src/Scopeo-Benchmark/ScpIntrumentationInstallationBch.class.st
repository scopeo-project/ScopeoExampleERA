Class {
	#name : 'ScpIntrumentationInstallationBch',
	#superclass : 'ScpSanerBenchmark',
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
