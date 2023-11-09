Class {
	#name : 'ScpInstrumenterTracer',
	#superclass : 'Object',
	#instVars : [
		'sender',
		'storage',
		'instrumenter'
	],
	#category : 'Scopeo-Instrumenter',
	#package : 'Scopeo-Instrumenter'
}

{ #category : 'services' }
ScpInstrumenterTracer >> clean [

	instrumenter uninstall
]

{ #category : 'parameters' }
ScpInstrumenterTracer >> forPackages: aPackageNameCollection [

	instrumenter packages: (aPackageNameCollection collect: [ :c | c asPackage ]).
	MetaLink uninstallAll.
	instrumenter instrumentPackages
]

{ #category : 'initialization' }
ScpInstrumenterTracer >> initialize [

	sender := #( nil nil nil ).
	instrumenter := ScpInstrumenter new
		                metaobject: self;
		                yourself
]

{ #category : 'tracing' }
ScpInstrumenterTracer >> traceAssignment: anArray [

	storage addStateUpdate: (ScpStateUpdate new
			 object: anArray first;
			 variable: anArray second;
			 newValue: anArray third;
			 yourself)
]

{ #category : 'services' }
ScpInstrumenterTracer >> traceBlock: aBlock [

	^ aBlock value
]

{ #category : 'tracing' }
ScpInstrumenterTracer >> traceMethod: anArray [


	storage addMessage: (ScpMessage new
			 sender: sender first;
			 senderSelector: (sender third ifNotNil: [ :s | s selector ]);
			 selector: anArray first;
			 receiver: anArray second;
			 arguments: anArray third;
			 yourself)
]

{ #category : 'tracing' }
ScpInstrumenterTracer >> traceSend: anArray [

	sender := anArray
]

{ #category : 'parameters' }
ScpInstrumenterTracer >> traceStorage: aStorage [

	storage := aStorage
]
