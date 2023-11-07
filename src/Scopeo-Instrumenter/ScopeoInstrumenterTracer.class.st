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

{ #category : 'private' }
ScopeoInstrumenterTracer >> addMessage: anInvokeTrace [

	storage addMessage: (ScpMessage new
			 sender: sender first;
			 senderSelector: (sender third ifNotNil: [ :s | s selector ]);
			 selector: anInvokeTrace first;
			 receiver: anInvokeTrace second;
			 arguments: anInvokeTrace third;
			 yourself)
]

{ #category : 'private' }
ScopeoInstrumenterTracer >> addStateUpdate: anInvokeTrace [

	storage addStateUpdate: (ScpStateUpdate new
			 object: anInvokeTrace first;
			 variable: anInvokeTrace second;
			 newValue: anInvokeTrace third;
			 yourself) 
]

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
	traces := OrderedCollection new.
	instrumenter := ScopeoInstrumenter new
]

{ #category : 'private' }
ScopeoInstrumenterTracer >> read: anInterpreterTraces [

	| action |
	anInterpreterTraces do: [ :t |
		t ifNil: [ ^ self ].
		(#( invoke assignment send ) includes: t)
			ifTrue: [ action := t ]
			ifFalse: [
				action = #invoke ifTrue: [ self addMessage: t ].
				action = #assignment ifTrue: [ self addStateUpdate: t ].
				action = #send ifTrue: [ sender := t ] ] ]
]

{ #category : 'services' }
ScopeoInstrumenterTracer >> traceExpressionString: anExpressionString [

	| result |
	result := self class compiler evaluate: anExpressionString.
	self read: instrumenter traces.
	instrumenter resetTraces.
	^ result
]

{ #category : 'parameters' }
ScopeoInstrumenterTracer >> traceStorage: aStorage [

	storage := aStorage
]
