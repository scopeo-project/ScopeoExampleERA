"
I read local resources from a directory ""repository"".
These resources must be text files with an item per line,
each line separated by a carriage return.
"
Class {
	#name : 'AMLocalRepository',
	#superclass : 'Object',
	#category : 'AmmoliteMagenta-model',
	#package : 'AmmoliteMagenta',
	#tag : 'model'
}

{ #category : 'api' }
AMLocalRepository class >> readAllPromotions [

	| repository |
	repository := self new.
	^ (repository allFileReferences reject: [ :f | 
		   f isDirectory or: [ f basename first = $. ] ]) collect: [ :f | 
		  f path basenameWithoutExtension
		  -> (repository readFileReference: f) ]
]

{ #category : 'reading' }
AMLocalRepository >> allFileReferences [

	^ self localDirectory children
]

{ #category : 'origins' }
AMLocalRepository >> groupsDirectory [
	|dir|
	dir := self localDirectory / 'groups'.
	dir ensureCreateDirectory.
	^dir
]

{ #category : 'origins' }
AMLocalRepository >> localDirectory [ 
	|dir|
	dir := FileSystem workingDirectory / 'repository'.
	dir ensureCreateDirectory.
	^dir
]

{ #category : 'origins' }
AMLocalRepository >> newGeneratedGroupFileNameFor: aClass [
	
	| str dateTime |
	str := WriteStream on: String new.
	str << aClass.
	str << '_'.
	dateTime := DateAndTime now.
	dateTime printYMDOn: str.
	str << '_'.
	dateTime printHMSWithDashesOn: str.
	str << '.amo'.
	^ str contents
]

{ #category : 'reading' }
AMLocalRepository >> readFileReference: aFileReference [

	^ aFileReference binaryReadStream contents asString splitOn:
		  OSPlatform current lineEnding
]

{ #category : 'as yet unclassified' }
AMLocalRepository >> reloadGroupsFrom: aFilename [
	^STON fromString: aFilename readStream contents
]

{ #category : 'as yet unclassified' }
AMLocalRepository >> saveGroups: groups fromClass: aClass [

	| filename |
	filename := self groupsDirectory
	            / (self newGeneratedGroupFileNameFor: aClass).
	filename writeStream
		nextPutAll: (STON toString: groups);
		close
]

{ #category : 'origins' }
AMLocalRepository >> savedGroups [

	^ self groupsDirectory entries
]
