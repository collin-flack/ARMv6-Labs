/*********************************************************************************
 File:    Flack_Lab-2.s
 Author:  Collin Flack
 Purpose: Lab 2 - Practicing using the stack, passing parameters, checking for overlow, checking for bad values, and using the branch/link operations.
 History: Created 02-13-23

 Use these commands to assemble, link, run and debug the program

  as -o Flack_Lab-2.o Flack_Lab-2.s
  gcc -o Flack_Lab-2 Flack_Lab-2.o
 ./Flack_Lab-2
 gdb --args ./Flack_Lab-2
***********************************************************************************/
.global	main 

main:        @Must use this label where to start executing the code. 

welcome:	@ Print welcome message
	LDR	r0, =string1	@ Put address of string in r0
	BL	printf		@ Make the call to printf 


selectShape:	@ Routine for selecting shape to compute area for

	LDR	r0, =msgSelect	@ Put address of the select instructions message in r0
	BL	printf		@ Make the call to printf

	LDR	r1, =varIterations	@ Prepare the parameter for how many digits to be read from getNum
	MOV	r2, #1			@ Store 1 into r2
	STR	r2, [r1]		@ Store 1 at the address of varIterations
	
	BL	getNum			@ Branch to getNum looking for a 1 digit number
	
	CMP	r8, #1			@ Check to see if triangle
	BEQ	goToTriangle

	CMP	r8, #2			@ Check to see if square
	BEQ	goToSquare

	CMP	r8, #3			@ Check to see if rectangle
	BEQ	goToRectangle

	CMP	r8, #4			@ Check to see if trapezoid
	BEQ	goToTrapezoid

	CMP	r8, #5			@ Check to see if user would like to quit
	BEQ	exit


	B 	selectShape		@ Loop until applicable choice


goToTriangle: @ ROUTINE FOR PREPARING PARAMETERS AND CALLING TRIANGLE SUBROUTINE

	LDR	r0, =msgTriangle1	@ Prompt the user for the shape's side
	BL	printf

	LDR	r1, =varIterations	@ Parameter for getNum read in a 10 digit number
	MOV	r2, #10
	STR	r2, [r1]
	BL	getNum
	LDR	r9, =s1
	STR	r8, [r9]


	LDR	r0, =msgTriangle2	@ Prompt the user for the shape's side
	BL	printf

	LDR	r1, =varIterations	@ Parameter for getNum read in a 10 digit number
	MOV	r2, #10
	STR	r2, [r1]
	BL	getNum
	MOV	r10, r8

	LDR	r9, =s1
	LDR	r9, [r9]


	BL	triangle

	POP	{r1}			@ Restore the results from the top of stack into r1 for printing
	LDR	r0, =msg12
	BL	printf

	B	goAgain			@ Check to see if the user would like to continue

goToSquare: @ ROUTINE FOR PREPARING PARAMETERS AND CALLING SQUARE SUBROUTINE

	LDR	r0, =msgSquare	@ Prompt the user for the shape's side
	BL	printf

	LDR	r1, =varIterations	@ Parameter for getNum read in a 10 digit number
	MOV	r2, #10
	STR	r2, [r1]
	BL	getNum
	MOV	r10, r8

	BL	square
	
	POP	{r1}			@ Restore the results from the top of stack into r1 for printing
	LDR	r0, =msg12
	BL	printf


	B	goAgain			@ Check to see if the user would like to continue

goToRectangle: @ ROUTINE FOR PREPARING PARAMETERS AND CALLING RECTANGLE SUBROUTINE

	LDR	r0, =msgRectangle1	@ Prompt the user for the shape's side

	BL	printf

	LDR	r1, =varIterations	@ Parameter for getNum read in a 10 digit number
	MOV	r2, #10
	STR	r2, [r1]
	BL	getNum
	LDR	r9, =s1
	STR	r8, [r9]		@ Store the number read in, in s1


	LDR	r0, =msgRectangle2	@ Prompt the user for the shape's side
	BL	printf

	LDR	r1, =varIterations	@ Parameter for getNum read in a 10 digit number
	MOV	r2, #10
	STR	r2, [r1]
	BL	getNum
	MOV	r10, r8			@ Store the number read in, in r10

	LDR	r9, =s1
	LDR	r9, [r9]


	BL	rectangle

	POP	{r1}			@ Restore the results from the top of stack into r1 for printing
	LDR	r0, =msg12
	BL	printf


	B	goAgain			@ Check to see if the user would like to continue

goToTrapezoid: @ ROUTINE FOR PREPARING PARAMETERS AND CALLING TRAPEZOID SUBROUTINE

	LDR	r0, =msgTrapezoid1
	BL	printf

	LDR	r1, =varIterations	@ Parameter for getNum read in a 10 digit number
	MOV	r2, #10
	STR	r2, [r1]
	BL	getNum
	LDR	r9, =s1
	STR	r8, [r9]		@ Store the number read in, in s1

	LDR	r0, =msgTrapezoid2
	BL	printf

	LDR	r1, =varIterations	@ Parameter for getNum read in a 10 digit number
	MOV	r2, #10
	STR	r2, [r1]
	BL	getNum
	LDR	r9, =s2
	STR	r8, [r9]		@ Store the number read in, in s2


	LDR	r0, =msgTrapezoid3
	BL	printf

	LDR	r1, =varIterations	@ Parameter for getNum read in a 10 digit number
	MOV	r2, #10
	STR	r2, [r1]
	BL	getNum
	MOV	r10, r8			@ Store the number read in, in r10

	LDR	r9, =s1
	LDR	r9, [r9]
	LDR	r11, =s2
	LDR	r11, [r11]

	BL	trapezoid

	POP	{r1}			@ Restore the results from the top of stack into r1 for printing
	LDR	r0, =msg12
	BL	printf


	B	goAgain			@ Check to see if the user would like to continue

goAgain:	@ Routine to check if user would like to enter another computation

	LDR	r0, =msgAgain		@ Instructions for continuing or quitting the program
	BL	printf


	LDR	r1, =varIterations	@ Prepare parameter for getNum with a 1 digit number to be read
	MOV	r2, #1
	STR	r2, [r1]
	
	BL	getNum		@ Get a number from user 

	CMP	r8, #1		@ Check to see if the user wants to continue
	BEQ	selectShape

	CMP	r8, #2		@ Check to see if the user wants to quit
	BEQ	exit

	B	goAgain		@ Loop until appropriate value response chosen 


triangle: @ Routine for calculating triangle area R9 = BASE R10 = HEIGHT
	PUSH	{r9, r10, lr}	@ Push r9, r10, and the link register onto the stack

	MOV	r11, r9, ASR #1	@ Devide the measure of the base by shifting to the right

	MOV	r9, r11

	UMULL	r3, r4, r9, r10	@ Multiply r9 * r10 and store the result in r3, r4 (64-bit)
	CMP	r4, #0		@ Checking to see if result overflowed into other register
	BNE	overflowFound	@ Branch to overflow handling

	MOV	r11, r3

	
	POP	{r7, r8, lr}	@ Restore the the values on the stack into r7, r8, and the link register

	PUSH	{r11}		@ Push results on the top of the stack

	MOV	pc, lr		@ Move the address in the link register into the program counter (returning to last instruction)

square:	@ Routine for calculating square area R10 = SIDE LENGTH	
	PUSH	{r10, lr}	@ Push r10 and the link register onto the stack	


	MOV	r10, r8

	MOV	r9, r10
	UMULL	r0, r1, r9, r10	@ Multiply r9 * r10 and store the result in r0, r1 (64-bit)
	CMP	r1, #0		@ Checking to see if result overflowed into other register

	BNE	overflowFound	@ Branch to overflow handling

	MOV	r9, r0	
	
	POP	{r7, lr}	@ Restore the previous values pushed onto the stack into r7 and the link register

	PUSH	{r9}		@ Push results on the top of the stack
	
	MOV	pc, lr		@ Move the address in the link register into the program counter (returning to last instruction)

rectangle: @ Routine for calculating rectangle area R9 = LENGTH R10 = WIDTH
	
	PUSH	{r9, r10, lr}	@ Push address of array and link register (r14) onto the stack

	UMULL	r3, r4, r9, r10	@ Multiply r9 * r10 and store the result in r3, r4 (64-bit)
	CMP	r4, #0		@ Checking to see if result overflowed into other register
	BNE	overflowFound	@ Branch to overflow handling


	MOV	r11, r3

	
	POP	{r7, r8, lr}	@ Restore the previous values into r7, r8, and the link register

	PUSH	{r11}		@ Push results on the top of the stack

	MOV	pc, lr		@ Move the address in the link register into the program counter (returning to last instruction)

trapezoid: @ Routine for calculating trapezoid area R11 = BOTTOM R9 = TOP R10 = HEIGHT

	PUSH	{r9, r10, r11, lr}	@ Push r9, r10, r11, and link register onto the stack

	ADD	r9, r9, r11
	MOV	r9, r9, ASR #1

	UMULL	r3, r4, r9, r10		@ Multiply r9 * r10 and store the result in r3, r4 (64-bit)	
	CMP	r4, #0			@ Checking to see if result overflowed into other register
	BNE	overflowFound

	MOV	r7, r3
	
	POP	{r0, r1, r2, lr}	@ Restore the the previous registers into r0, r1, r2, and the link register
	PUSH	{r7}			@ Push results on the top of the stack
	MOV	pc, lr			@ Move the address in the link register into the program counter (returning to last instruction)

overflowFound:	@ Routine for telling the user and overflow was found and branching to see what the user would like to do next
	
	LDR	r0, =msgOverflow
	BL	printf

	B	goAgain

getNum: @STORES NUMBER IN R8

	PUSH	{lr}		@ Push the return address onto the stack

getNumAgain:			@ Entry point for error reads (don't push link register again)

	LDR	r12, =array
	LDR	r10, =address
	STR	r12, [r10]	@ Store the address of the array into the address variable

	LDR	r0, =inputType	@ Prepare to use scanf to read in a number
	LDR	r1, =input	@ Prepare to use scanf to read in a number
	BL	scanf		@ Subroutine call

	MOV	r9, #1		@ Number digits counter

	LDR	r1, =input
	LDR	r1, [r1]	@ Get the number read in, in r1

	CMP	r1, #49		@ Set bounds for a number 0-9 in character code
	BLT	founda
	CMP	r1, #57		@ If not in bounds, branch to the found an error routine
	BGT	founda

	LDR	r0, =msg1	@ Prints first character entered by user

	MOV	r11, r1
	LDR	r12, =address
	LDR	r12, [r12]
	BL	getInt		@ Call to getInt to check which type of number was read in

	LDR	r12, =address
	LDR	r12, [r12]	@ Increment the address and keep stored in address variable
	ADD	r12, #4
	LDR 	r4, =address
	STR	r12, [r4]
	

	@BL	printf


loop1: 	@ Loop through all the characters a user entered
	ADD	r7, #1
	ADD	r9, #1		@ Counter to see if the user entered nothing
	LDR	r1, =input	
	LDR	r0, =inputType	@ Preparing for scanf

	BL 	scanf
	LDR	r1, =input
	LDR	r1, [r1]	@ Store the number read in, into r1

	CMP	r1, #48
				@ Set bounds for a number 0-9 in character code
	BLT	founda
	CMP	r1, #57

	BGT	founda		@ If not in bounds, branch to the found an error routine

	LDR	r7, =varIterations	@ Using varIterations as parameter to check number digits
	LDR	r7, [r7]
	CMP	r9, r7
	BGT	founda


	LDR	r0, =msg1	@ Prints remaining characters entered by user

	MOV	r11, r1


	LDR	r12, =address
	LDR	r12, [r12]

	BL	getInt		@ Call to getInt to check which type of number was read in


	LDR	r12, =address
	LDR	r12, [r12]
	ADD	r12, #4		@ Increment the address and keep stored in address variable
	LDR 	r4, =address
	STR	r12, [r4]
	


	@BL	printf

	B	loop1		@ Loop until error found, space bar found, or number digits exceeded

founda:	@ Routine for handling an error entered

	CMP	r1, #10
	MOV 	r10, r1		@ End of user input found, the number is good
	BEQ	allgood

	BL	clearArray	@ Clear the array to prepare to read in another input

	LDR	r0, =msg2
	LDR 	r1, =varIterations
	LDR	r1, [r1]
	BL	printf
	B	readerror


allgood:	@ Routine for sending the array to be computed
	
	CMP	r9, #1
	BEQ	emptynum	@ Make sure that the user didn't just enter the space-bar
	BEQ	readerror
	LDR	r0, =msg3
	MOV	r11, r1
	B	computeNum	@ Branch to compute the number entered by looping through the array
	BL	printf		@ Number must be good
	

emptynum:	@ Routine for telling the user an empty number was found

	LDR	r0, =msg2	@ Tell the user not to enter just space-bar
	BL	printf
	B	getNum

readerror: @ Routine for clearing out io buffer

	CMP	r10, #10
	BEQ	getNumAgain

	LDR	r0, =inputType	@ Clear out io buffer
	LDR 	r1, =input
	BL	scanf
	
	LDR	r10, =input
	LDR	r10, [r10]
	B	readerror	@ Keep calling scanf until buffer is empty

getInt:	@ R11 = CHARACTER CODE OF NUMBER Compares r11 to character codes for 0-9 and branches to respective routine

	PUSH	{r11, lr}	

	CMP	r11, #48
	BEQ	addZero

	CMP	r11, #49
	BEQ	addOne

	CMP	r11, #50
	BEQ	addTwo

	CMP	r11, #51
	BEQ	addThree

	CMP	r11, #52
	BEQ	addFour

	CMP	r11, #53
	BEQ	addFive

	CMP	r11, #54
	BEQ	addSix

	CMP	r11, #55
	BEQ	addSeven

	CMP	r11, #56
	BEQ	addEight

	CMP	r11, #57
	BEQ	addNine

addZero:	@ Adds a zero to the array
	
	MOV	r8, #0
	STR	r8, [r12]
	POP	{r11, lr}
	MOV	pc, lr

addOne:		@ Adds a one to the array

	MOV	r8, #1
	STR	r8, [r12]
	POP	{r11, lr}
	MOV	pc, lr


addTwo:		@ Adds a two to the array

	MOV	r8, #2
	STR	r8, [r12]
	POP	{r11, lr}
	MOV	pc, lr


addThree:	@ Adds a three to the array

	MOV	r8, #3
	STR	r8, [r12]
	POP	{r11, lr}
	MOV	pc, lr


addFour:	@ Adds a four to the array

	MOV	r8, #4
	STR	r8, [r12]
	POP	{r11, lr}
	MOV	pc, lr


addFive:	@ Adds a five to the array

	MOV	r8, #5
	STR	r8, [r12]
	POP	{r11, lr}
	MOV	pc, lr


addSix:		@ Adds a six to the array

	MOV	r8, #6
	STR	r8, [r12]
	POP	{r11, lr}
	MOV	pc, lr


addSeven:	@ Adds a seven to the array

	MOV	r8, #7
	STR	r8, [r12]
	POP	{r11, lr}
	MOV	pc, lr


addEight:	@ Adds an eight to the array

	MOV	r8, #8
	STR	r8, [r12]
	POP	{r11, lr}
	MOV	pc, lr


addNine:	@ Adds a nine to the array

	MOV	r8, #9
	STR	r8, [r12]
	POP	{r11, lr}
	MOV	pc, lr

computeNum:

	@Loop through array backwards, multiplying number * 10^[r7]

	@ R12: last item of array's address
	@ R7: Exponent of 10
	@ R8: Sum, result to pass

	MOV	r8, #0		@ Set total sum to 0

	MOV	r7, #0		@ Set exponent to 0

	LDR	r11, =array
	LDR	r12, =address @ Set up array and address so that they span the length of the array that has been filled in
	LDR	r12, [r12]

	ADD	r12, #-4 	@ Offset the address to the last filled in number


loopBackwards: @ Looping through array adding to sum

	CMP	r11, r12 	@ Loop through the array until r12 is less than r11 (the address variable is less than the array variable
	BGT	backtoMain	@ meaning the array has been exhausted
	
	LDR	r2, [r12]

	BL	getTen
	MUL	r1, r2, r9	@ Multiply the number by the correct exponent of 10
	MOV	r2, r1
	ADD	r8, r8, r2	@ Add the number to the total

	ADD	r12, #-4 

	B	loopBackwards	@ Loop until array exhausted 
	

backtoMain:	@ Send program back to call of subroutine
	POP	{lr}		@ Restore link register
	MOV	pc, lr		@ Move back to where BL called

getTen:	@ Routine to calculate the exponent of 10. R7 = EXPONENT R9 = 10^R7

	PUSH 	{lr}	

	MOV	r3, r7
	ADD	r7, #1
	MOV 	r9, #1
	MOV	r10, #10

tenloop:	@ Calculate exponent of 10

	CMP 	r3, #1		@ Loop through until exponent of number is less than 1 (single digit place)
	BLT	backtoCompute

	ADD	r3, #-1

	MUL	r1, r9, r10
	MOV	r9, r1

	B	tenloop



backtoCompute:	@ Send program back to number computation

	POP	{lr}	@ Restore link register
	MOV	pc, lr	@ Move back to where BL called

clearArray:	@ Routine for clearing array when any error values read in

	PUSH	{lr}
	
	LDR	r1, =array	@ Prepare r1 and r2 to loop through array and set it entirely to 0's
	LDR	r2, =end_of_array
	ADD	r2, #-4
	
loopclear:	@ Loop through array to set all values to 0

	CMP	r1, r2		@ Check to see if entire array exhausted
	BGT	backFunction

	MOV	r3, #0
	STR	r3, [r1]	@ Set address of the array to 0

	ADD	r1, #4		@ Increment the array address

	B	loopclear	@ Loop until array exhausted

backFunction:	@ Send program back to where clearArray was called

	POP	{lr}		@ Restore link register
	MOV	pc, lr		@ Move back to where BL was called


@ Force the exit of this program and return command to OS.
exit:
	LDR	r0, =msgExit	@ Load r0 with the goodbye message
	BL	printf

	MOV	r7, #0x01	@ Prepare r7 for system call
	SVC	0


@ Declare the strings

.data       @ Lets the OS know it is okay to write to this area of memory. 

.balign 4   @ Force a word boundary.
string1:	.asciz	"Welcome to Lab 2!\n"  

.balign 4
input:	.word 0	@ Input value for scanf

.balign 4
inputType: .asciz "%c"	@ Type of input for scanf

.balign 4   @ Force a word boundary.
msg1: .asciz "Results: %c\n" @ Character results

.balign 4   @ Force a word boundary.
msg12: .asciz "Results: %d square units\n\n"	@ Integer results

.balign 4   @ Force a word boundary.
msgTriangle1: .asciz "Input the measure of the triangle's base:\n"	@ Triangle Base Message

.balign 4   @ Force a word boundary.
msgTriangle2: .asciz "Input the measure of the triangle's height:\n"	@ Triangle Height Message

.balign 4   @ Force a word boundary.
msgRectangle1: .asciz "Input the measure of the rectangles's length:\n"	@ Rect. Msg 1

.balign 4   @ Force a word boundary.
msgRectangle2: .asciz "Input the measure of the rectangles's width:\n"	@ Rect. Msg 2

.balign 4   @ Force a word boundary.
msgTrapezoid1: .asciz "Input the measure of the trapezoid's top length:\n"	@ Trapezoid Top Length

.balign 4   @ Force a word boundary.
msgTrapezoid2: .asciz "Input the measure of the trapezoid's bottom length:\n"	@ Trapezoid Bottom Length

.balign 4   @ Force a word boundary.
msgTrapezoid3: .asciz "Input the measure of the trapezoid's height:\n"	@ Trapezoid Height

.balign 4   @ Force a word boundary.
msgOverflow: .asciz "Overflow detected\n" @ Overflow message when overflow detected

.balign 4   @ Force a word boundary.
msgExit: .asciz "Goodbye. . .\n" 	@ Goodbye, exiting message

.balign 4   @ Force a word boundary.
msgAgain: .asciz "Enter 1 to compute the area of another shape, or enter 2 to quit the program.\n" @ Instructions for running shape area computation again or quitting

.balign 4   @ Force a word boundary.
msgSquare: .asciz "Input the length of the square's sides:\n"	@ Squares Side-Length Msg

.balign 4   @ Force a word boundary.
msg2: .asciz "Error. Please enter <=%d-digit positive integer:\n" @ Error messsage

.balign 4   @ Force a word boundary.
msgSelect: .asciz "Please select the type of shape to perform an area calculation on \n(1 = triangle, 2 = square, 3 = rectangle, 4 = trapezoid, 5 = quit program):\n" 
								@ Instructions message for choosing shape to compute area for

.balign 4   @ Force a word boundary.
msg3: .asciz "END OF NUMBER (ALL GOOD)\n" @ Testing msg

.balign 4   @ Force a word boundary.
msg4: .asciz "EMPTY NUMBER\n" 		@ Testing msg

.balign 4
array:	.word	0, 0, 0, 0, 0, 0, 0, 0, 0, 0	@ Array for storing numbers read in by getInt

.balign 4
end_of_array:	.word	0	@ Address for the end of the array

.balign 4
address:	.word	0	@ Used to point to the current array address

.balign 4
varIterations:	.word	0	@ Parameter for getNum, number of digits to be read in

.balign 4
s1:	.word	0		@ Variable for holding length of a shape side

.balign 4
s2:	.word	0		@ Variable for holding length of a shape side

.global printf
.global scanf

/*********************************************************************************
  To use printf:
     r0 - Contains the starting address of the string to be printed. The string
          must conform to the C coding standards.
     r1 - If the string contains an output parameter i.e., %d, %c, etc. register
          r1 must contain the value to be printed. 
 When the call returns registers: r0, r1, r2, r3 and r12 are changed. 

end of code and end of file. Leave a blank line after this.
***********************************************************************************/
