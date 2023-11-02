# ScopeoExampleERA

Table of contents:
 1. [Example](#example-of-scopeo-usage-on-a-failing-unit-test)
 2. [Benchmark](#how-to-run-a-benchmark)

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

Step 1: Run the code using Scopeo

```st
| scopeo allPrintedStudents failingStudent messagesToFailingStudent markerSetToEmpty |

scopeo := ScpTraces new.
scopeo scan: 'AMParsingBugExample new testStudentPrinting'.
```

Step 2: Run a first query to find all messages sent using selector #textPrintStudent:on:
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

Step 5: Investigation based on the messages received by the failing student
  1. The failing student has received 6 messages
  2. The last of these messages is an access to the marker of the failing student made by AMGroup >> #textPrintStudent:on:
  3. The source code of AMGroup >> #textPrintStudent:on: shows that the student marker is concatenated at the end of the stream. 
     So the test expects the as last character a marker, '-'or '+'.
  4. The marker of the failing student is an empty string, which is why the test fails.
  5. The marker of the failing student has been set to an empty string by the third message.

```st
messagesToFailingStudent last. "Step 5.2"
failingStudent marker. "Step 5.4"
markerSetToEmpty := messagesToFailingStudent third. "Step 5.5"
```

Step 6. Browse the source code of the sender of the message setting the marker to an empty string.
  1. The sender is AMParsingBugExample >> #promotion.
  2. At the line 7 we see a loop over the lines of a text stream.
  3. The stream is created from the accessor AMParsingBugExample >> #students.
     
```st
(markerSetToEmpty sender class >> markerSetToEmpty senderSelector) browse.
```

Step 7. In AMParsingBugExample >> #students we search for Raymond-Tristan, our failing student.
  The student has no marker -> the problem therefore comes from the data
  
```st
(AMParsingBugExample >> #students) browse.
```

## How to run a benchmark?

Scopeo uses an interpreter, DAST, to evaluate the source code and record traces of the execution.  
To evaluate the overhead of the interpreation and traces recording we need a benchmark.  

The benchmark class we created measure the time required by Pharo 12, DAST, and Scopeo to evaluate use the unit test presented in the [Example](#example-of-scopeo-usage-on-a-failing-unit-test).  

There is two parameters:
1. **loops** The number of time the unit test must be executed to represent on measure point.
   It is required because the execution of the test is quick enough to be under the millisecond.
2. **measures** The number of measure point desired.

```st
ScopeoBenchmark new
	loops: 100;
	measures: 100;
	execute;
	inspect
```

Instead of opening an inspector at the end of the benchmark, you can choose to export the data to a CSV file by doing:


```st
ScopeoBenchmark new
	loops: 100;
	measures: 100;
	execute;
	exportToCSV: '/Users/<myuser>/scopeo-benchmark.csv'
```
