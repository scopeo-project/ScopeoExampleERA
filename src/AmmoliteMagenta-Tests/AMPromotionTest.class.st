Class {
	#name : 'AMPromotionTest',
	#superclass : 'TestCase',
	#category : 'AmmoliteMagenta-Tests',
	#package : 'AmmoliteMagenta-Tests'
}

{ #category : 'tests' }
AMPromotionTest >> testPickRandomStudent [
	|promotion student|	
	promotion := AMPromotion readFromDisk first.
	student := promotion pickRandomStudent.
	
	self deny: student identicalTo: promotion pickRandomStudent.
	self deny: student equals: AMPromotion readFromDisk first pickRandomStudent
	
]

{ #category : 'tests' }
AMPromotionTest >> testReadFromAssociation [
	|data promotion student|
	data :=  'test' -> { 'Jean-Pierre Screugneugneu -'. 'Bob Madeleine +'. 'Lolo Saint-Martin' }.
	promotion := AMPromotion readFromAssociation: data.
	
	self assert: promotion size equals: 3.
	self assert: promotion name equals: 'test'.
	
	student := promotion students first.
	self assert: student name equals: 'Jean-Pierre Screugneugneu'.
	self assert: student markerL.
	self deny: student markerP.

	student := promotion students second.
	self assert: student name equals: 'Bob Madeleine'.
	self assert: student markerP.
	self deny: student markerL.
	
	student := promotion students third.
	self assert: student name equals: 'Lolo Saint-Martin'.
	self deny: student markerL.
	self deny: student markerP
]
