/*********************************************************************************
 File:    Flack_Lab-1.s
 Author:  Collin Flack
 Purpose: Utilize auto-indexing and a for-loop construct to iterate through arrays. 
 History: 

 Use these commands to assemble, link, run and debug the program

  as -o Flack_Lab-1.o Flack_Lab-1.s
  gcc -o Flack_Lab-1 Flack_Lab-1.o
 ./Flack_Lab-1
 gdb --args ./Flack_Lab-1
***********************************************************************************/

.global main 

main:       

	LDR	r0, =welcomemsg @ Put address of welcomemsg in r0
	BL	printf		@ Make the call to printf

	LDR	r8, =array1	@ Put the address of array1 into r8
	LDR	r9, =array2	@ Put the address of array2 into r9

	LDR	r0, =msg1	@ Prepare the printf parameter to display array header
	BL	printf		@ Subroutine call
	LDR	r11, =array1	@ PRINT ARRAY 1
	BL 	printArray 	@ Subroutine call

	LDR	r0, =msg2	@ Prepare the printf parameter to display array header
	BL	printf
	LDR	r11, =array2	@ PRINT ARRAY 2
	BL	printArray	@ Subroutine call

	MOV  	r10, #0		@ iterator
	LDR	r11, =arraysum	@ Put the address of arraysum into r11
	ADD	r11, #-4	@ Offset for the post-indexing to iterate and store values into third array

loop:
	ADD	r10, #1		@ Increment the iterator
	LDR 	r6, [r8], #4	@ post-indexing
	LDR	r7, [r9], #4	@ post-indexing
	LDR	r2, [r11], #4	@ post-indexing
	
	ADD	r1, r6, r7	@ Add together coinciding terms of array 1 and 2
	STR	r1, [r11]	@ Store the sum into the current address of the array
	CMP	r10, #10	@ Check to see if all 10 array elements looped
	BNE	loop		@ Branch check

	LDR	r0, =msg3	@ Prepare the printf parameter to display array header
	BL	printf		@ Subroutine call
	LDR	r11, =arraysum	@ PRINT ARRAY 3 (SUM ARRAY)
	BL	printArray	@ Subroutine call

@ NOW GET USER INPUT
	LDR	r0, =instructions	@ Prepare the printf parameter to display instructions for choosing a value type
	BL	printf		@ Subroutine call
	LDR	r0, =inputType	@ Prepare to use scanf to read in a number
	LDR	r1, =input	@ Prepare to use scanf to read in a number
	BL	scanf		@ Subroutine call


	LDR	r1, =input	@ Store the address of the scanned value into r1
	LDR	r1, [r1]	@ Load the value at the address pointed to into r1
	CMP	r1, #0		@ Compare the value with 0
	BGT	positives	@ Branch to positive values routine if greater than 0
	BLT	negatives	@ Branch to the negative values routine if less than 0
	BEQ	zeroes		@ Branch to the zero value routine if equal to 0	
	
positives:
	LDR	r0, =msg4	@ Prepare the printf parameter to display the message for positive values
	BL	printf		@ Subroutine call
	MOV	r10, #0		@ Iterator
	LDR	r8, =arraysum	@ Address of arraysum -> r8

loop1:
	ADD	r10, #1		@ Increment
	LDR 	r6, [r8], #4	@ post-indexing
	CMP	r6, #0		@ Compare array elements to 0
	BGT	printnum1	@ If greater than 0 (positive), then branch to print that number
	CMP	r10, #10	@ Check to see if all of the array has been looped through
	BNE	loop1		@ If still remaining elements of array, then branch back to loop
	
	B	exit		@ Exit program

negatives:
	LDR	r0, =msg5	@ Prepare the printf parameter to display the message for negative values
	BL	printf		@ Subroutine call
	MOV	r10, #0		@ Iterator
	LDR	r8, =arraysum	@ Address of arraysum -> r8

loop2:
	ADD	r10, #1		@ Increment
	LDR 	r6, [r8], #4	@ post-indexing
	CMP	r6, #0		@ Compare array elements to 0
	BLT	printnum2	@ If less than 0 (negative), then branch to print that number
	CMP	r10, #10	@ Check to see if all of the array has been looped through
	BNE	loop2		@ If still remaining elements of array, then branch back to loop

	B	exit		@ Exit program

zeroes:
	LDR	r0, =msg6	@ Prepare the printf parameter to display the message for zero value
	BL	printf		@ Subroutine call
	MOV	r10, #0		@ Iterator
	LDR	r8, =arraysum	@ Address of arraysum -> r8

loop3:
	ADD	r10, #1		@ Increment
	LDR 	r6, [r8], #4	@ post-indexing
	CMP	r6, #0		@ Compare array elements to 0
	BEQ	printnum3	@ If equal to 0, then branch to print that number
	CMP	r10, #10	@ Check to see if all of the array has been looped through
	BNE	loop3		@ If still remaining elements of array, then branch back to loop

	B	exit		@ Exit program

printnum1:
	MOV	r1, r6		@ Prepare parameter for printf to display correct array values
	LDR	r0, =int1	@ Printing numbers for printf
	BL	printf		@ Subroutine call
	CMP	r10, #10	@ Check to see if all of the array has been looped through
	BNE	loop1		@ If still remaining elements of array, then branch back to loop
	B	exit		@ Exit program
	
printnum2:
	MOV	r1, r6		@ Prepare parameter for printf to display correct array values
	LDR	r0, =int1	@ Printing numbers for printf
	BL 	printf		@ Subroutine call
	CMP	r10, #10	@ Check to see if all of the array has been looped through
	BNE	loop2		@ If still remaining elements of array, then branch back to loop
	B	exit		@ Exit program

printnum3:
	MOV	r1, r6		@ Prepare parameter for printf to display correct array values
	LDR	r0, =int1	@ Printing numbers for printf
	BL	printf		@ Subroutine call
	CMP	r10, #10	@ Check to see if all of the array has been looped through
	BNE	loop3		@ If still remaining elements of array, then branch back to loop
	B	exit		@ Exit program


	

exit:
	MOV	r7, #0X01	@ System paremeter for ending program
	SVC	0		@ System call


printArray:			@ SUBROUTINE FOR PRINTING ARRAYS. R11 IS PARAMETER FOR ADDRESS TO ARRAY
	PUSH	{r11, lr}	@ Push address of array and link register (r14) onto the stack
	MOV  	r10, #0		@ Iterator
	
printloop:
	LDR	r1, [r11], #4	@ Post-indexing 
	LDR	r0, =int1	@ Tell printf displaying numbers
	BL	printf		@ Subroutine call
	ADD	r10, #1		@ Increment
	CMP	r10, #10	@ Check to see if whole array printed
	BNE	printloop	@ Loop back and print rest of array if array not all printed

	POP	{r11, lr}	@ Restore the address to array and link register
	MOV	pc, lr		@ Move the address in the link register into the program counter (returning to last instruction)
	


.data       @ Lets the OS know it is OK to write to this area of memory. 

.balign 4   @ Force a word boundary.
welcomemsg: .asciz "Welcome to Lab 1. The following program adds two arrays together into a third\narray. Then, the user may input a value to select for similar values in Array 3.\nThe following are the 3 arrays:\n"  

.balign 4   @ Force a word boundary.
instructions: .asciz "Please input either a positive integer, negative integer, or 0:\n(All of the corresponding element types in Array 3 will be output)\n" 

.balign 4   @ Force a word boundary.
msg1: .asciz "Array 1:\n" 

.balign 4   @ Force a word boundary.
msg2: .asciz "\nArray 2:\n" 

.balign 4   @ Force a word boundary.
msg3: .asciz "\nArray 3:\n" 

.balign 4   @ Force a word boundary.
msg4: .asciz "\nThese are the positive numbers in Array 3:\n" 

.balign 4   @ Force a word boundary.
msg5: .asciz "\nThese are the negative numbers in Array 3:\n" 

.balign 4   @ Force a word boundary.
msg6: .asciz "\nThese are the zeroes in Array 3:\n" 


.balign 4 @ Word bound
int1: .asciz "%d\n"

.balign 4
input: .word 0

.balign 4
inputType: .string "%d"

.balign 4   @ Force a word boundary
array1:	.word 2, 5, 100, 50, -75, -9, 9, -5, 25, 5 @ Defining 3 arrays

.balign 4   @ Force a word boundary
array2:	.word -107, -5, -100, -50, 75, 9, 9, 1, -25, 5

.balign 4   @ Force a word boundary
arraysum: .word   0, 0, 0, 0, 0, 0, 0, 0, 0, 0


.global printf
.global scanf

