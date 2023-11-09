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
		
		spec baseline: 'AmmoliteMagenta' with: [
			spec repository:
				'github://StevenCostiou/AmmoliteMagenta:failing-test-example' ].
		
		spec package: #'Scopeo-Predicates'.
		spec package: #'Scopeo-Instrumenter'.
		
		spec package: #'Scopeo-Traces'.
		spec package: #'Scopeo-Traces-Tests'.
		spec package: #'Scopeo-Traces-Tests-Objects'.
		
		spec package: #'Scopeo-Benchmark' ]
]
