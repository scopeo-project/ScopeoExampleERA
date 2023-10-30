Class {
	#name : 'BaselineOfScopeoExampleERA',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfScopeoExampleERA',
	#package : 'BaselineOfScopeoExampleERA'
}

{ #category : 'baselines' }
BaselineOfScopeoExampleERA >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec baseline: 'DebuggableASTInterpreter' with: [
			spec repository:
				'github://adri09070/DebuggableASTInterpreter:optimized-code-switch' ].

		spec baseline: 'AmmoliteMagenta' with: [
			spec repository:
				'github://StevenCostiou/AmmoliteMagenta:failing-test-example' ].

		spec package: #'Scopeo-Traces'.
		spec package: #'Scopeo-Traces-Tests'.
		spec package: #'Scopeo-Predicates' ]
]
