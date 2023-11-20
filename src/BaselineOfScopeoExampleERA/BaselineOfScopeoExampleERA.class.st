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
		
		spec package: #'Scopeo-Predicates'.
		spec package: #'Scopeo-Instrumenter'.
		
		spec package: #'Scopeo-Traces'.
		spec package: #'Scopeo-Traces-Tests-Objects'.

		spec package: #'Scopeo-Traces-Tests'
			with: [ spec requires: #( 'Scopeo-Traces' 'Scopeo-Traces-Tests-Objects') ].
			
		spec package: 'AmmoliteMagenta'.
		spec
			package: 'AmmoliteMagenta-Tests'
			with: [ spec requires: #( 'AmmoliteMagenta' ) ].
	]
]
