# ScopeoExampleERA
```st
| scopeo allPrintedStudents failingStudent messagesToFailingStudent markerSetToEmpty |
"
Step 1: Browse AMParsingBugExample >> #testStudentPrinting
  - At least one student last character does not matches with the expected ones: '-' or '+'
  - This student is Raymond-Tristan
  - The last character obtained by the test is 'n'
"

"Step 2: Run the code using Scopeo"
scopeo := ScpTraces new.
scopeo scan: 'AMParsingBugExample new testStudentPrinting'.

"Step 3: Run a first query to find all messages sent using selector #textPrintStudent:on:"
allPrintedStudents := scopeo fetch: (ScpIsMessage new and: (ScpMessageSelectorEq value: #textPrintStudent:on:)).

"Step 4: The last student is the one that has triggered the exception."
failingStudent := allPrintedStudents last arguments first.

"Step 5: Run a second query to collect all messages sent to the failing student."
messagesToFailingStudent := scopeo fetch: (ScpIsMessage new and: (ScpMessageReceiverEq value: failingStudent)).

"
Step 6: Investigation
  1. The failing student has received 6 messages
  2. The last of these messages is an access to the marker of the failing student made by AMGroup >> #textPrintStudent:on:
  3. The source code of AMGroup >> #textPrintStudent:on: shows that the student marker is concatenated at the end of the stream. 
     So the test expects the as last character a marker, '-'or '+'.
  4. The marker of the failing student is an empty string, which is why the test fails.
  5. The marker of the failing student has been set to an empty string by the third message.
"
messagesToFailingStudent last. "Step 6.2"
failingStudent marker. "Step 6.4"
markerSetToEmpty := messagesToFailingStudent third. "Step 6.5"

"
Step 7. Browse the source code of the sender of the message setting the marker to an empty string.
  1. The sender is AMParsingBugExample >> #promotion.
  2. At the line 7 we see a loop over the lines of a text stream.
  3. The stream is created from the accessor AMParsingBugExample >> #students.
"
(markerSetToEmpty sender class >> markerSetToEmpty senderSelector) browse.

"
Step 8. In AMParsingBugExample >> #students we search for Raymond-Tristan, our failing student.
  The student has no marker -> the problem therefore comes from the data	
"
(AMParsingBugExample >> #students) browse.
```
