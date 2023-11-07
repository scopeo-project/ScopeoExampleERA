Class {
	#name : 'ScpInterpreter',
	#superclass : 'DASTInterpreter',
	#category : 'Scopeo-Interpreter',
	#package : 'Scopeo-Interpreter'
}

{ #category : 'api' }
ScpInterpreter >> currentContext: aContext [

	currentContext := aContext
]

{ #category : 'accessing' }
ScpInterpreter >> programCounter: aCounter [

	programCounter := aCounter
]