# ScopeoExampleERA

Table of contents:
 1. [Install](#installation)
 2. [Example](#example-of-scopeo-usage-on-a-failing-unit-test)
 3. [Benchmark](#how-to-run-a-benchmark)

## Installation

To install the project, execute the following baseline in a Pharo 12 image.

```st
Metacello new
  githubUser: 'ValentinBourcier' project: 'ScopeoExampleERA' commitish: 'main' path: 'src';
  baseline: 'ScopeoExampleERA';
  load
```

## Example of Scopeo usage on a failing unit test

Ammolite is an application that divide student promotions into homogeneous sub-groups.  
Sub-groups are calculated depending on the level of each student, which is representer by a marker '-' or '+'.  

The following test verifies that when printing a student text representation, the last character is the marker, '-' or '+'.

```st
AMParsingBugExample >> testStudentPrinting

	| group students |
	group := AMGroup new.
	students := self promotion students.
	students do: [ :s |
		| str |
		str := WriteStream on: String new.
		group textPrintStudent: s on: str.
		self assert: (#( $- $+ ) includes: str contents last) ]
```

But the test fails. When printing the text representation of a student named Raymond-Tristan, the last character is 'n'.  
How to debug it with Scopeo:

Step 1: Run the code using Scopeo.
```st
| scopeo allPrintedStudents failingStudent messagesToFailingStudent markerSetToEmpty |

scopeo := ScpTraces new.
scopeo scan: 'AMParsingBugExample new testStudentPrinting'.
```

Step 2: Run a first query to find all messages sent using selector `#textPrintStudent:on:`.
```st
allPrintedStudents := scopeo fetch: (ScpIsMessage new and: (ScpMessageSelectorEq value: #textPrintStudent:on:)).
```

Step 3: The last student is the one that has triggered the exception (Raymond-Tristan).
```st
failingStudent := allPrintedStudents last arguments first.
```

Step 4: Run a second query to collect all messages sent to the failing student.
```st
messagesToFailingStudent := scopeo fetch: (ScpIsMessage new and: (ScpMessageReceiverEq value: failingStudent)).
```

Step 5: Investigation based on the messages received by the failing student.
  1. The failing student has received 6 messages.
  2. The last of these messages is an access to the marker of the failing student made by `AMGroup >> #textPrintStudent:on:`.
  3. The source code of `AMGroup >> #textPrintStudent:on:` shows that the student marker is concatenated at the end of the stream. 
     So the test expects the as last character a marker, '-'or '+'.
  4. The marker of the failing student is an empty string, which is why the test fails.
  5. The marker of the failing student has been set to an empty string by the third message.

```st
messagesToFailingStudent last. "Step 5.2"
failingStudent marker. "Step 5.4"
markerSetToEmpty := messagesToFailingStudent third. "Step 5.5"
```

Step 6. Browse the source code of the sender of the message setting the marker to an empty string.
  1. The sender is `AMParsingBugExample >> #promotion`.
  2. At the line 7 we see a loop over the lines of a text stream.
  3. The stream is created from the accessor `AMParsingBugExample >> #students`.
     
```st
(markerSetToEmpty sender class >> markerSetToEmpty senderSelector) browse.
```

Step 7. In AMParsingBugExample >> #students we search for Raymond-Tristan, our failing student.
  The student has no marker -> the problem therefore comes from the data
  
```st
(AMParsingBugExample >> #students) browse.
```

## How to run benchmarks?

To perform queries about the execution, the tool needs to record information about the program execution.  
To calculate the overhead we performed benchmarks with:
1. **performWithPharo**: Pharo 12
2. **performWithDAST**: DAST interpreter (an AST interpreter dedicated to debugging).
3. **performWithDASTAndTraces**: A modified DAST intepreter that sends the program information to another object, for later storage.
4. **performWithInstrumenter**: Instrumentation of the code by a library relying on MetaLink from Pharo Reflectivity library.
5. **performWithInstrumenterAndTraces**: Instrumentation of the code by the library modified to transform the raw data and send it to another object, for later storage.
6. **performWithInstrumenterInstallation**: Only installation and uninstallation of the instrumentation.

The code used to realise the benchmarks is the unit test presented in the [Example](#example-of-scopeo-usage-on-a-failing-unit-test) as evaluation program.  

There is two parameters to launch the benchmarks:
1. **loops** The number of time the unit test must be executed to represent a measure point.  
   It is required because the execution of the test may takes less than the millisecond with Pharo 12 which is the reference benchmark. 
2. **measures** The number of measure point desired.  

We executed each benchmark in a fresh new image on a MacBook Pro (14-inch, 2021) using the code as follow.

### Reference benchmark, with Pharo

```st
ScopeoBenchmarks new
	numberOfBlockIterations: 100;
	numberOfMeasures: 100;
	performWithPharo;
	exportRawResults: '/Users/<username>/benchmark-withPharo-100i-100m-raw.csv';
	exportResults: '/Users/<username>/benchmark-withPharo-100i-100m.csv'.
```

### Benchmark of the AST interpreter

```st
ScopeoBenchmarks new
	numberOfBlockIterations: 100;
	numberOfMeasures: 100;
	performWithDAST;
	exportRawResults: '/Users/<username>/benchmark-withDAST-100i-100m-raw.csv';
	exportResults: '/Users/<username>/benchmark-withDAST-100i-100m.csv'.
```

### Benchmark of the AST interpreter collecting traces

```st
ScopeoBenchmarks new
	numberOfBlockIterations: 100;
	numberOfMeasures: 100;
	performWithDASTAndTraces;
	exportRawResults: '/Users/<username>/benchmark-withDASTAndTraces-100i-100m-raw.csv';
	exportResults: '/Users/<username>/benchmark-withDASTAndTraces-100i-100m.csv'.
```

### Benchmark of the instrumented code

```st
ScopeoBenchmarks new
	numberOfBlockIterations: 100;
	numberOfMeasures: 100;
	performWithInstrumenter;
	exportRawResults: '/Users/<username>/benchmark-withInstrumenter-100i-100m-raw.csv';
	exportResults: '/Users/<username>/benchmark-withInstrumenter-100i-100m.csv'.
```

### Benchmark of the instrumented code with raw data to trace transformation

```st
ScopeoBenchmarks new
	numberOfBlockIterations: 100;
	numberOfMeasures: 100;
	performWithInstrumenterAndTraces;
	exportRawResults: '/Users/<username>/benchmark-withInstrumenterAndTraces-100i-100m-raw.csv';
	exportResults: '/Users/<username>/benchmark-withInstrumenterAndTraces-100i-100m.csv'.
```

### Benchmark of the code instrumentation, install + uninstall

```st
ScopeoBenchmarks new
	numberOfBlockIterations: 1;
	numberOfMeasures: 100;
	performWithInstrumenterInstallation;
	exportRawResults: '/Users/<username>/benchmark-withInstrumenterInstallation-100i-100m-raw.csv';
	exportResults: '/Users/<username>/benchmark-withInstrumenterInstallation-100i-100m.csv'.
```
