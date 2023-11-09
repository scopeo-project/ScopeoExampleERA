Class {
	#name : 'ScopeoInstrumenterTracer',
	#superclass : 'Object',
	#instVars : [
		'traces',
		'stack',
		'sender',
		'storage',
		'instrumenter',
		'installed'
	],
	#category : 'Scopeo-Instrumenter-',
	#package : 'Scopeo-Instrumenter',
	#tag : ''
}

{ #category : 'services' }
ScopeoInstrumenterTracer >> clean [

	instrumenter uninstall
]

{ #category : 'parameters' }
ScopeoInstrumenterTracer >> forPackages: aPackageNameCollection [

	instrumenter packages: (aPackageNameCollection collect: [ :c | c asPackage ]).
	MetaLink uninstallAll.
	instrumenter instrumentPackages
]

{ #category : 'initialization' }
ScopeoInstrumenterTracer >> initialize [

	sender := #( nil nil nil ).
	instrumenter := ScopeoInstrumenter new
		                metaobject: self;
		                yourself
]

{ #category : 'tracing' }
ScopeoInstrumenterTracer >> traceAssignment: anArray [

	storage addStateUpdate: (ScpStateUpdate new
			 object: anArray first;
			 variable: anArray second;
			 newValue: anArray third;
			 yourself)
]

{ #category : 'services' }
ScopeoInstrumenterTracer >> traceExpressionString: anExpressionString [

	^ self class compiler evaluate: anExpressionString
]

{ #category : 'tracing' }
ScopeoInstrumenterTracer >> traceMethod: anArray [


	storage addMessage: (ScpMessage new
			 sender: sender first;
			 senderSelector: (sender third ifNotNil: [ :s | s selector ]);
			 selector: anArray first;
			 receiver: anArray second;
			 arguments: anArray third;
			 yourself)
]

{ #category : 'tracing' }
ScopeoInstrumenterTracer >> traceSend: anArray [

	sender := anArray
]

{ #category : 'parameters' }
ScopeoInstrumenterTracer >> traceStorage: aStorage [

	storage := aStorage
]
