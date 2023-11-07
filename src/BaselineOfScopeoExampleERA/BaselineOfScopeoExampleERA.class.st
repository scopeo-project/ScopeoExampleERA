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

		spec
			baseline: 'NeoCSV'
			with: [ spec repository: 'github://svenvc/NeoCSV/repository' ].


		spec package: #'Scopeo-Predicates'.
		spec package: #'Scopeo-Instrumenter'.
		spec package: #'Scopeo-Interpreter'.

		spec package: #'Scopeo-Traces'.
		spec package: #'Scopeo-Traces-Tests'.
		spec package: #'Scopeo-Traces-Tests-Objects'.
		
		spec package: #'Scopeo-Benchmark' ]
]
