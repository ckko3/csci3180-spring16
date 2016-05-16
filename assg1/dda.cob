      * CSCI3180 Principles of Programming Languages
      * --- Declaration ---
      * I declare that the assignment here submitted is original except for source material explicitly acknowledged.
      * I also acknowledge that I am aware of University policy and regulations on honesty in academic work,
      * and of the disciplinary guidelines and procedures applicable to breaches of such policy and regulations,
      * as contained in the http://www.cuhk.edu.hk/policy/academichonesty/
      * Assignment 1
      * Name: KO Chi Keung
      * Student ID: 1155033234
      * Email Addr: ckko3@se.cuhk.edu.hk

       IDENTIFICATION DIVISION.
       PROGRAM-ID. DDA.

       ENVIRONMENT DIVISION
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT INPUT-FILE ASSIGN TO DISK
               ORGANIZATION IS LINE SEQUENTIAL
		       FILE STATUS IS INPUT-FILE-STATUS.
           SELECT OUTPUT-FILE ASSIGN TO DISK
		       ORGANIZATION IS LINE SEQUENTIAL
		       FILE STATUS IS OUTPUT-FILE-STATUS.

       DATA DIVISION
       FILE SECTION.
       FD INPUT-FILE
           LABEL RECORDS ARE STANDARD
           DATA RECORD IS INPUT-RECORD
		   VALUE OF FILE-ID IS "input.txt".
       01 INPUT-RECORD.
	       03 INPUT-1 PIC 99.
	       03 FILLER PIC X.
	       03 INPUT-2 PIC 99.
		   
       FD OUTPUT-FILE
		   LABEL RECORDS ARE STANDARD
		   DATA RECORD IS OUTPUT-RECORD
		   VALUE OF FILE-ID IS "output.txt".
       01 OUTPUT-RECORD.
	       03 OUTPUT-1 PIC X(79).

       WORKING-STORAGE SECTION.
	   01 INPUT-FILE-STATUS PIC XX.
	   01 OUTPUT-FILE-STATUS PIC XX.
		   
       01 DATA-POINT-TABLE.
           03 DATA-POINT-ARRAY OCCURS 100 TIMES.
		       05 DATA-POINT PIC 99 OCCURS 2 TIMES.
	   
	   01 TMP.
	       03 DIGIT PIC 9 OCCURS 2 TIMES.
		   
	   01 I PIC 99.
	   01 J PIC 99.
	   01 N PIC 99.
	   01 M PIC S99V9999.
	   01 ABS-M PIC 99V9999.
	   01 A PIC 99.
	   01 B PIC 99.
	   01 C PIC 99.
	   01 D PIC 99.
	   01 X PIC 99.
	   01 TMP-X PIC S99.
	   01 Y PIC 99.
	   01 TMP-Y PIC S99.
	   01 XI PIC 99.
	   01 YI PIC 99.
	   01 XJ PIC 99.
	   01 YJ PIC 99.
	   
	   01 OUT-TABLE.
	       03 OUT-ARRAY OCCURS 23 TIMES.
		       05 OUT PIC X OCCURS 79 TIMES.

       PROCEDURE DIVISION.
       MAIN-PARAGRAPH.
	       PERFORM OPEN-INPUT-FILE.
		   PERFORM READ-N.
		   MOVE 1 TO I.
		   PERFORM READ-DATA-POINT.
		   PERFORM CLOSE-INPUT-FILE.
		   PERFORM INIT-TABLE.
		   PERFORM ORIGIN.
		   MOVE 2 TO I.
		   PERFORM Y-AXIS.
		   MOVE 2 TO I.
		   PERFORM X-AXIS.
		   MOVE 1 TO I.
		   PERFORM ANALYZER.
		   PERFORM OPEN-OUTPUT-FILE.
		   MOVE 23 TO I.
		   PERFORM WRITE-FILE.
		   PERFORM CLOSE-OUTPUT-FILE.
		   PERFORM PROGRAM-END.
	   
      * Read from input file
       OPEN-INPUT-FILE.
           OPEN INPUT INPUT-FILE.
		   
		   IF INPUT-FILE-STATUS NOT EQUAL '00'
		       DISPLAY 'CANNOT OPEN INPUT FILE'
			   PERFORM PROGRAM-END.
       
       READ-N.	   
		   READ INPUT-FILE.
		   MOVE INPUT-1 TO TMP.
		   MOVE DIGIT(2) TO N.
		   IF DIGIT(1) NOT EQUAL SPACE
		       MOVE TMP TO N.

       READ-DATA-POINT.
           IF I < N OR = N
			   READ INPUT-FILE
			   PERFORM READ-DATA-POINT-1
			   PERFORM READ-DATA-POINT-2
			   COMPUTE I = I + 1
      	       GO TO READ-DATA-POINT.
			   
       READ-DATA-POINT-1.
      	   MOVE INPUT-1 TO TMP.
      	   MOVE DIGIT(2) TO DATA-POINT(I, 1).
           IF DIGIT(1) NOT EQUAL SPACE
               MOVE TMP TO DATA-POINT(I, 1).
	  
       READ-DATA-POINT-2.
      	   MOVE INPUT-2 TO TMP.
      	   MOVE DIGIT(2) TO DATA-POINT(I, 2).
           IF DIGIT(1) NOT EQUAL SPACE
               MOVE TMP TO DATA-POINT(I, 2).
				   
       CLOSE-INPUT-FILE.    
           CLOSE INPUT-FILE.
		   
      * Initialize array
       INIT-TABLE.
	       MOVE SPACES TO OUT-TABLE.
	   
       ORIGIN.
	       MOVE '+' TO OUT(1, 1).
       
       Y-AXIS.
		   IF I < 23 OR = 23
			   MOVE '|' TO OUT(I, 1)
               COMPUTE I = I + 1
               GO TO Y-AXIS.
			   
       X-AXIS.
		   IF I < 79 OR = 79
			   MOVE '-' TO OUT(1, I)
               COMPUTE I = I + 1
               GO TO X-AXIS.
			   
      * Get all points from data points
       ANALYZER.
	       IF I < N
	           MOVE DATA-POINT(I, 1) TO A
		       MOVE DATA-POINT(I, 2) TO B
		       MOVE DATA-POINT(I + 1, 1) TO C
		       MOVE DATA-POINT(I + 1, 2) TO D
			   PERFORM ANALYZER-PROCESS
               COMPUTE I = I + 1
		       GO TO ANALYZER.

       ANALYZER-PROCESS.
      * Special case - vertical line (M = infinity)
	       IF A = C
		       PERFORM CASE-VERTICAL.
      * Normal case includes horizontal line (M = 0)
		   IF A NOT = C
		       PERFORM CASE-NORMAL.

      * Compute M and absolute value of M			   
       CASE-NORMAL.
		   COMPUTE M = (D - B) / (C - A).
           IF M < 0
               COMPUTE ABS-M = M * -1.
		   IF M > 0 OR = 0
		       MOVE M TO ABS-M.
	       
      * Case 1
	       IF ABS-M < 1 OR = 1
		       PERFORM CASE-1.
			   
      * Case 2
	       IF ABS-M > 1
		       PERFORM CASE-2.
			   
       CASE-1.
		   IF A > C
		       MOVE C TO XI
	           MOVE D TO YI
			   MOVE A TO XJ
			   MOVE B TO YJ.
		   IF A < C OR = C
			   MOVE A TO XI
			   MOVE B TO YI
			   MOVE C TO XJ
			   MOVE D TO YJ.
		   MOVE '*' TO OUT(YI + 1, XI + 1).
		   MOVE '*' TO OUT(YJ + 1, XJ + 1).
		   MOVE 1 TO J.
		   PERFORM CASE-1-PROCESS.
		   
       CASE-1-PROCESS.
	       IF J < (XJ - XI)
		       COMPUTE X = XI + J
               COMPUTE TMP-Y ROUNDED = J * M
			   COMPUTE Y = YI + TMP-Y
               MOVE '*' TO OUT(Y + 1, X + 1)
			   COMPUTE J = J + 1
			   GO TO CASE-1-PROCESS.
			   
       CASE-2.
		   IF B > D
		       MOVE C TO XI
	           MOVE D TO YI
			   MOVE A TO XJ
			   MOVE B TO YJ.
		   IF B < D OR = D
			   MOVE A TO XI
			   MOVE B TO YI
			   MOVE C TO XJ
			   MOVE D TO YJ.
		   MOVE '*' TO OUT(YI + 1, XI + 1).
		   MOVE '*' TO OUT(YJ + 1, XJ + 1).
		   MOVE 1 TO J.
		   PERFORM CASE-2-PROCESS.
		   
       CASE-2-PROCESS.
	       IF J < (YJ - YI)
               COMPUTE TMP-X ROUNDED = J / M
			   COMPUTE X = XI + TMP-X
			   COMPUTE Y = YI + J
               MOVE '*' TO OUT(Y + 1, X + 1)
			   COMPUTE J = J + 1
			   GO TO CASE-2-PROCESS.
			   
       CASE-VERTICAL.
	       IF B > D
		       MOVE C TO XI
	           MOVE D TO YI
			   MOVE A TO XJ
			   MOVE B TO YJ.
		   IF B < D OR = D
			   MOVE A TO XI
			   MOVE B TO YI
			   MOVE C TO XJ
			   MOVE D TO YJ.
		   MOVE '*' TO OUT(YI + 1, XI + 1).
		   MOVE '*' TO OUT(YJ + 1, XJ + 1).
		   MOVE 1 TO J.
		   PERFORM CASE-VERTICAL-PROCESS.
		   
       CASE-VERTICAL-PROCESS.
	       IF J < (YJ - YI)
			   COMPUTE X = XI
			   COMPUTE Y = YI + J
               MOVE '*' TO OUT(Y + 1, X + 1)
			   COMPUTE J = J + 1
			   GO TO CASE-VERTICAL-PROCESS.
	
      * Write to output file
       OPEN-OUTPUT-FILE.
	       OPEN OUTPUT OUTPUT-FILE.
		   
		   IF OUTPUT-FILE-STATUS NOT EQUAL '00'
		       DISPLAY 'CANNOT OPEN OUTPUT FILE'
			   PERFORM PROGRAM-END.
			   
       WRITE-FILE.
		   IF I > 0
		       MOVE OUT-ARRAY(I) TO OUTPUT-1
		       WRITE OUTPUT-RECORD
			   COMPUTE I = I - 1
			   GO TO WRITE-FILE.
	   
       CLOSE-OUTPUT-FILE.
	       CLOSE OUTPUT-FILE.
		 
       PROGRAM-END.
           STOP RUN.
