"
I am the Ammolite Magenta application.
I allow for creating and shuffling groups of students.
"
Class {
	#name : 'AMGroupBuilderPresenter',
	#superclass : 'StPresenter',
	#instVars : [
		'data',
		'classes',
		'students',
		'controls',
		'output',
		'nbGroupSelection',
		'fontSizeSelection'
	],
	#classInstVars : [
		'outputFontSize'
	],
	#category : 'AmmoliteMagenta-presenters',
	#package : 'AmmoliteMagenta',
	#tag : 'presenters'
}

{ #category : 'examples' }
AMGroupBuilderPresenter class >> application [

	^ SpApplication new
		  styleSheet: self styleSheet;
		  yourself
]

{ #category : 'specs' }
AMGroupBuilderPresenter class >> configurationLayout [

	^ SpBoxLayout newLeftToRight
		  add: #classes;
		  add: #students;
		  yourself
]

{ #category : 'specs' }
AMGroupBuilderPresenter class >> defaultSpec [

	^ SpPanedLayout newTopToBottom
		positionOfSlider: 30 percent;
		add: self configurationLayout;
		add: self outputLayout;
		yourself
]

{ #category : 'examples' }
AMGroupBuilderPresenter class >> example [

	<script>
	self openOn: AMPromotion readFromDisk
]

{ #category : 'opening' }
AMGroupBuilderPresenter class >> openOn: data [

	self basicNew
		data: data;
		application: self application;
		initialize;
		openWithSpec
]

{ #category : 'accessing' }
AMGroupBuilderPresenter class >> outputFontSize [
	^outputFontSize ifNil:[outputFontSize := 18]
]

{ #category : 'specs' }
AMGroupBuilderPresenter class >> outputLayout [

	^ SpBoxLayout newTopToBottom
		  add: (SpBoxLayout newLeftToRight
				   add: #controls
				   expand: false
				   fill: false
				   padding: 5;
				   add: (SpBoxLayout newTopToBottom
						    add: 'Groups'
						    withConstraints: [ :constraints | constraints width: 50 ];
						    add: #nbGroupSelection
						    expand: false
						    fill: false
						    padding: 5;
						    yourself)
				   withConstraints: [ :constraints | constraints width: 60 ];
				add: (SpBoxLayout newTopToBottom
						    add: 'Font size'
						    withConstraints: [ :constraints | constraints width: 50 ];
						    add: #fontSizeSelection
						    expand: false
						    fill: false
						    padding: 5;
						    yourself)
				   withConstraints: [ :constraints | constraints width: 60 ];
				   yourself)
		  withConstraints: [ :constraints | 
		  constraints height: self buttonHeight * 2 ];
	
		  yourself
]

{ #category : 'examples' }
AMGroupBuilderPresenter class >> styleSheet [

	^ SpStyleVariableSTONReader fromString: '
.application [
	Font { #name : EnvironmentFont(#default) },
	Geometry { #height: 25 },
	.box [ Geometry { #height: Reset, #vResizing: true, #hResizing: true } ],
	.label [
		Geometry { #hResizing: true, #height: 18 },
		.headerError [ Draw { #color:  #red }  ],
		.headerSuccess [ Draw { #color: #green } ],
		.header [ Draw { #color: Color{ #rgb: 622413393 } } ],
		.shortcut [ Draw { #color: Color{ #rgb: 622413393 } } ],
		.fixed [ Geometry { #hResizing: false, #width: 100 } ],
		.dim [ Draw { #color : Color{ #rgb: 708480675 } } ]
	],
	.link [ Geometry { #hResizing: true } ],
	.button [  
		Geometry { #width: 100, #height: 30 },
		.small [ Geometry { #width: 25, #height: 25 } ]
	],
	.checkBox [  
		Geometry { #hResizing: true },
		.compact [ Geometry { #hResizing: false, #width: 20 } ]
	],
	.radioButton [ Geometry { #hResizing: true } ],
	.dropList [ Geometry { #width: 150, #hResizing: true } ],
	.list [ Geometry { #width: 150, #minHeight: 125, #hResizing: true, #vResizing: true } ],
	.slider [ Geometry { #width: 150, #hResizing: true } ],
	.actionBar [  
		Container { #borderWidth: 0, #padding: 5 },
		Geometry { #width: 150, #height: 29, #hResizing: true, #vResizing: false }
	],
	.menuBar [ Geometry { #width: 150, #hResizing: true } ],
	.actionButton [  
		Geometry { #width: 70, #hResizing: false },
		.showIcon [ Geometry { #width: 25 } ]
	],
	.toolbar [ 
		Geometry { #height: Reset, #hResizing: true },
		.icons [ Geometry { #height: 30 } ],
		.iconsAndLabel [ Geometry { #height: 45 } ]
	],
	.text [ Geometry { #height: Reset }, Font { #size: 18 } ],
	.code [ Font { #name: EnvironmentFont(#code) } ],
	.codePopover [ 
		Draw { #color : #transparent },
		.button [ Geometry { #width : 25 } ]
	],
	.codePopoverError [ 
		Draw { #backgroundColor: #C20000 },
		Font { #color: #white } 
	],
	.scrollbarPopoverLarge [ Geometry { #height: 350 } ],
	.large [ Font { #size: 20 } ],
	.popover [
		.print [ Draw { #color: EnvironmentColor(#balloonBackground) } ],
		.error [ Draw { #color: #C20000 } ],
		.large [ Font { #size: 20 } ],
		.popoverButton [ Draw { #color: EnvironmentColor(#popoverButton) } ] ],
	.paginator [ Geometry { #height: 20 } ],
	.morph [ Geometry { #width: Reset, #height: Reset, #vResizing: true, #hResizing: true } ],
	.image [ Geometry { #width: Reset, #height: Reset, #vResizing: true, #hResizing: true } ] ]
'
]

{ #category : 'accessing' }
AMGroupBuilderPresenter class >> updateOutputFontSize: anInteger [
	outputFontSize := anInteger
]

{ #category : 'displaying' }
AMGroupBuilderPresenter >> addGroupDecorationTo: presenter for: text [

	| size |
	size := (text asString readStream upTo: Character cr) size.
	presenter addTextSegmentDecoration: (SpTextPresenterDecorator new
			 highlightColor: (Color magenta alpha: 0.5);
			 underlineColor: (Color white alpha: 0);
			 interval: (1 to: size + 1);
			 yourself)
]

{ #category : 'updating' }
AMGroupBuilderPresenter >> clearGroups [
	self flag: 'todo'
]

{ #category : 'accessing' }
AMGroupBuilderPresenter >> data [

	^ data ifNil: [ data := OrderedCollection new ]
]

{ #category : 'accessing' }
AMGroupBuilderPresenter >> data: anObject [

	data := anObject
]

{ #category : 'displaying' }
AMGroupBuilderPresenter >> displayGroups: groups [

	| grid str i j lay |
	grid := SpGridLayout new.
	grid borderWidth: 0.
	grid beRowHomogeneous.

	i := 1.
	j := 1.

	groups do: [ :g | 
		| text |
		text := SpTextPresenter new.
		text beNotEditable.
		str := WriteStream on: Text new.
		g textPrintOn: str.
		text text: str contents.
		grid add: text at: i @ j.

		i := i + 1.
		i > 4 ifTrue: [ 
			j := j + 1.
			i := 1 ] ].

	1 to: j do: [ :n | grid row: n withConstraints: [ :c | c beExpand ] ].
	lay := self class defaultSpec.
	lay children second
		add: grid
		expand: true
		fill: true
		padding: 0.
	self layout: lay.

	grid children keysDo: [ :textPresenter | 
		self addGroupDecorationTo: textPresenter for: textPresenter text ]
]

{ #category : 'actions' }
AMGroupBuilderPresenter >> exit [
	self withWindowDo: [ :w| w close ]
]

{ #category : 'export' }
AMGroupBuilderPresenter >> exportGroups: groups [

	AMLocalRepository new
		saveGroups: groups
		fromClass: classes selectedItem name
]

{ #category : 'actions' }
AMGroupBuilderPresenter >> generate [

	| nbGroups studentsSelection groups |
	self isPromotionSelected ifFalse: [ ^ self ].
	nbGroups := nbGroupSelection selectedItem.

	studentsSelection := classes selectedItem students select: [ :s | 
		                     s isPresent ].
	groups := AMGroupBuilder new
		          buildGroups: nbGroups
		          forStudents: studentsSelection.
	self displayGroups: groups
]

{ #category : 'initialization' }
AMGroupBuilderPresenter >> initializePresenters [

	super initializePresenters.
	classes := self newTable.
	classes addColumn:
		(SpStringTableColumn title: 'Class' evaluated: #name).
	classes addColumn:
		((SpStringTableColumn title: 'Number of students' evaluated: #size)
			 width: 150;
			 yourself).
	classes transmitDo: [ :class | 
		class ifNotNil: [ 
			self updateStudents: class.
			self clearGroups ] ].

	students := self newTable.
	students addColumn: ((SpCheckBoxTableColumn
			  title: ' '
			  evaluated: [ :student | student isPresent ])
			 onActivation: [ :student | student isPresent: true ];
			 onDeactivation: [ :student | student isPresent: false ];
			 width: 20;
			 yourself).
	students addColumn:
		(SpStringTableColumn title: 'Student' evaluated: #name).
	students addColumn:
		(SpStringTableColumn title: 'Level' evaluated: [:s| s marker asString ]).
	students contextMenu: self studentMenu.
	
	controls := self newToolbar.
	self initializeToolbar.
	nbGroupSelection := self newDropList.
	nbGroupSelection items: (2 to: 20) asArray.
	nbGroupSelection selectItem: 10.
	nbGroupSelection enabled: false.
	
	fontSizeSelection := self newDropList.
	fontSizeSelection items: #(10 12 14 16 18 20 22 24 26 28 ).
	fontSizeSelection selectIndex:
		(fontSizeSelection items indexOf: self class outputFontSize).
	fontSizeSelection whenSelectedItemChangedDo: [ :val | 
		self class updateOutputFontSize: val.
		self updateOutputFontSize ].
		self updateOutputFontSize.
	fontSizeSelection selectItem: 10.
	fontSizeSelection enabled: false.
		
	
	output := self newText.
	output beNotEditable.

	classes items: self data
]

{ #category : 'initialization' }
AMGroupBuilderPresenter >> initializeToolbar [

	controls addItem: (SpToolbarButtonPresenter new
			 label: 'Exit';
			 icon: (self iconNamed: #smallQuit);
			 help: 'Exits program';
			 action: [ self exit ];
			 yourself).
	controls addItem: (SpToolbarButtonPresenter new
			 label: 'Load';
			 icon: (self iconNamed: #glamorousOpen);
			 help: 'Load a saved group';
			 action: [ self load ];
			 yourself).
	controls addItem: (SpToolbarButtonPresenter new
			 label: 'Refresh';
			 icon: (self iconNamed: #refresh);
			 help: 'Reload data from disk';
			 action: [ self reload ];
			 yourself).
	
	controls addItem: (SpToolbarButtonPresenter new
			 label: 'Pick';
			 icon: (self iconNamed: #smallNew);
			 help: 'Picks a random student in the selected promotion';
			 action: [ self pickRandomStudent ];
			 yourself).
	controls addItem: (SpToolbarButtonPresenter new
			 label: 'Generate';
			 icon: (self iconNamed: #group);
			 help: 'Generate student groups';
			 action: [ self generate ];
			 yourself)
]

{ #category : 'initialization' }
AMGroupBuilderPresenter >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.

	aWindowPresenter maximize.
	aWindowPresenter title: 'Ammolite Magenta'.
	"aWindowPresenter withoutDecorations"
]

{ #category : 'testing' }
AMGroupBuilderPresenter >> isPromotionSelected [

	| promotion |
	promotion := classes selectedItem.
	promotion ifNil: [ 
		self warning: 'No promotion selected' relativeTo: classes.
		^ false ].
	^ true
]

{ #category : 'actions' }
AMGroupBuilderPresenter >> load [

	| repository savedGroups index |
	repository := AMLocalRepository new.
	savedGroups := repository savedGroups reject:[:f| f name first = $.].

	index := UIManager default
		         chooseFrom: (savedGroups collect: [ :f | f name ])
		         title: 'Load a saved group'.
	index = 0 ifTrue: [ ^ self ].
	self displayGroups:
		(repository reloadGroupsFrom: (savedGroups at: index) asFileReference)
]

{ #category : 'actions' }
AMGroupBuilderPresenter >> pickRandomStudent [

	self isPromotionSelected ifFalse: [ ^ self ].
	self popStudent: classes selectedItem pickRandomStudent printString relativeTo: controls 

]

{ #category : 'ui' }
AMGroupBuilderPresenter >> popStudent: aString relativeTo: aPresenter [

	self newPopover
		application: self class application;
		relativeTo: aPresenter;
		position: SpPopoverPosition right;
		presenter: (SpPresenter new
				 application: self class application;
				 layout: (SpBoxLayout newTopToBottom
						  borderWidth: 2;
						  spacing: 0;
						  add: (self newLabel label: aString);
						  yourself);
				 yourself);
		popup
]

{ #category : 'actions' }
AMGroupBuilderPresenter >> reload [
	classes items: AMPromotion readFromDisk.
	classes unselectAll.
	students unselectAll 
	
]

{ #category : 'initialization' }
AMGroupBuilderPresenter >> studentMenu [

	^ self newMenu addGroup: [ :aGroup | 
		  aGroup addItem: [ :anItem | 
			  anItem
				  name: 'inspect';
				  action: [ students selectedItem inspect ] ] ]
]

{ #category : 'initialization' }
AMGroupBuilderPresenter >> updateOutputFontSize [

	(((self application propertyAt: 'styleSheet') styles
		  detect: [ :s | (s respondsTo: #name) and: [ s name = 'text' ] ]
		  ifNone: [ ^ self ]) styles
		 detect: [ :s | s isKindOf: SpFontStyle ]
		 ifNone: [ ^ self ]) size: self class outputFontSize.
	self update
]

{ #category : 'updating' }
AMGroupBuilderPresenter >> updateStudents: class [

	students items: class students
]

{ #category : 'ui' }
AMGroupBuilderPresenter >> warning: aString relativeTo: aPresenter [ 
	self newPopover
		addStyle: 'error';
		relativeTo: aPresenter;
		position: SpPopoverPosition top;
		presenter: (SpPresenter new
				 layout: (SpBoxLayout newTopToBottom
						  borderWidth: 2;
						  spacing: 0;
						  add: (self newLabel label: aString);
						  yourself);
				 yourself);
		popup
]
