/*********************************************************************************
 File:    Flack_Lab-3.s
 Author:  Collin Flack
 Purpose: Simulate a vending machine
 History: Created 02-23-23

 Use these commands to assemble, link, run and debug the program

  as -o Flack_Lab-3.o Flack_Lab-3.s
  gcc -o Flack_Lab-3 Flack_Lab-3.o
 ./Flack_Lab-3
 gdb --args ./Flack_Lab-3
***********************************************************************************/

.global main 

main:        @Must use this label where to start executing the code. 

welcome:	@ Output welcome to vending machine message and give user instructions

	LDR	r0, =string1
	BL	printf

instructions:

	LDR	r0, =instruction
	BL	printf	

loadMachine: @ Set up variables to represent the stock amount of each snack

	LDR	r0, =gum
	MOV	r1, #2
	STR	r1, [r0]

	LDR	r0, =crackers
	MOV	r1, #2
	STR	r1, [r0]

	LDR	r0, =peanuts
	MOV	r1, #2
	STR	r1, [r0]

	LDR	r0, =ms
	MOV	r1, #2
	STR	r1, [r0]



select: @ Routine for selecting a snack or exiting

	LDR	r0, =instruction2	@ Prepare the printf parameter to display instructions for choosing a value type
	BL	printf			@ Subroutine call
	LDR	r0, =inputType		@ Prepare to use scanf to read in a number
	LDR	r1, =input		@ Prepare to use scanf to read in a number
	BL	scanf			@ Subroutine call

	LDR	r1, =input
	LDR	r1, [r1]

	CMP	r1, #77
	BEQ	loadMs

	CMP	r1, #67
	BEQ	loadCrackers
	
	CMP	r1, #80
	BEQ	loadPeanuts

	CMP	r1, #71
	BEQ	loadGum
	
	CMP	r1, #83
	BEQ	inventory

	CMP	r1, #69
	BEQ	exit

	CMP	r1, #10
	BEQ	select

	B	error

inventory:	@ Inventory/Secret Code selection. SECRET CODE IS S
	
	LDR	r0, =inv1
	LDR	r1, =crackers
	LDR	r1, [r1]
	BL	printf

	LDR	r0, =inv2
	LDR	r1, =ms
	LDR	r1, [r1]
	BL	printf

	LDR	r0, =inv3
	LDR	r1, =peanuts
	LDR	r1, [r1]
	BL	printf

	LDR	r0, =inv4
	LDR	r1, =gum
	LDR	r1, [r1]
	BL	printf

loopclearinv:	@ Clear input buffer

	LDR	r0, =inputType		
	LDR	r1, =input		
	BL	scanf

	LDR	r1, =input
	LDR	r1, [r1]
	CMP	r1, #10
	BNE	loopclearinv

	B	select

loadCrackers:  @ Prepare to buy crackers if in stock

	MOV	r0, #0
	MOV	r9, #0
	PUSH 	{r9}
	LDR	r1, =type
	STR	r0, [r1]

	LDR	r0, =confirm1
	BL	printf	

	MOV	r10, #65
	PUSH 	{r10}

loopclearc:@ Clear input buffer

	LDR	r0, =inputType		
	LDR	r1, =input		
	BL	scanf

	LDR	r1, =input
	LDR	r1, [r1]
	CMP	r1, #10
	BNE	loopclearinv

	LDR	r0, =crackers
	LDR	r0, [r0]
	CMP	r0, #0
	BLE	stock

	B	confirmation

loadMs:  @ Prepare to buy M&Ms if in stock

	MOV	r0, #1
	LDR	r1, =type
	STR	r0, [r1]
	MOV	r9, #1
	PUSH 	{r9}

	LDR	r0, =confirm2
	BL	printf	

	MOV	r10, #100
	PUSH 	{r10}

loopclearm:@ Clear input buffer

	LDR	r0, =inputType		
	LDR	r1, =input		
	BL	scanf

	LDR	r1, =input
	LDR	r1, [r1]
	CMP	r1, #10
	BNE	loopclearinv

	LDR	r0, =ms
	LDR	r0, [r0]
	CMP	r0, #0
	BLE	stock

	B	confirmation

loadPeanuts:  @ Prepare to buy peanuts if in stock
	
	MOV	r0, #2
	LDR	r1, =type
	STR	r0, [r1]
	MOV	r9, #2
	PUSH 	{r9}


	LDR	r0, =confirm3
	BL	printf	

	MOV	r10, #55
	PUSH 	{r10}

loopclearp:@ Clear input buffer

	LDR	r0, =inputType		
	LDR	r1, =input		
	BL	scanf

	LDR	r1, =input
	LDR	r1, [r1]
	CMP	r1, #10
	BNE	loopclearinv

	LDR	r0, =peanuts
	LDR	r0, [r0]
	CMP	r0, #0
	BLE	stock

	B	confirmation

loadGum: @ Prepare to buy gum if in stock

	MOV	r0, #3
	LDR	r1, =type
	STR	r0, [r1]
	MOV	r9, #3
	PUSH 	{r9}


	LDR	r0, =confirm4
	BL	printf

	MOV	r10, #50
	PUSH 	{r10}

loopclearg:@ Clear input buffer

	LDR	r0, =inputType		
	LDR	r1, =input		
	BL	scanf

	LDR	r1, =input
	LDR	r1, [r1]
	CMP	r1, #10
	BNE	loopclearinv

	LDR	r0, =gum
	LDR	r0, [r0]
	CMP	r0, #0
	BLE	stock

	B	confirmation

confirmation: @ Make sure the user meant to select this snack

	LDR	r0, =inputType		
	LDR	r1, =input		
	BL	scanf

	LDR	r1, =input
	LDR	r1, [r1]

	CMP	r1, #89
	BEQ	loopscanpay

	CMP	r1, #10
	BEQ	confirmation
	
	CMP	r1, #78
	BEQ	loopscan

	B	error2

	

loopscanpay:@ Clear input buffer

	LDR	r0, =inputType		
	LDR	r1, =input		
	BL	scanf

	LDR	r1, =input
	LDR	r1, [r1]
	CMP	r1, #10
	BNE	loopscanpay

	POP {r10, r11}

payment: @ R10 = CENTS R9 = TYPE (charge due)
	
	LDR	r0, =due
	MOV	r1, r10
	BL	printf

	LDR	r0, =payMsg
	BL	printf

	LDR	r0, =inputType		
	LDR	r1, =input		
	BL	scanf

	LDR	r1, =input
	LDR	r1, [r1]

	CMP	r1, #10
	BEQ	payment

	CMP	r1, #68
	BEQ	dime

	CMP	r1, #81
	BEQ	quarter

	CMP	r1, #66
	BEQ	bill

	B	errorpay

quarter:

loopscanq:@ Clear input buffer

	LDR	r0, =inputType		
	LDR	r1, =input		
	BL	scanf

	LDR	r1, =input
	LDR	r1, [r1]
	CMP	r1, #10
	BNE	loopscanq

	ADD	r10, r10, #-25
	CMP	r10, #0
	BLE	change
	B	payment

dime:

loopscand:@ Clear input buffer

	LDR	r0, =inputType		
	LDR	r1, =input		
	BL	scanf

	LDR	r1, =input
	LDR	r1, [r1]
	CMP	r1, #10
	BNE	loopscand

	ADD	r10, r10, #-10
	CMP	r10, #0
	BLE	change
	B	payment


bill:

loopscanb:@ Clear input buffer

	LDR	r0, =inputType		
	LDR	r1, =input		
	BL	scanf

	LDR	r1, =input
	LDR	r1, [r1]
	CMP	r1, #10
	BNE	loopscanb

	ADD	r10, r10, #-100
	CMP	r10, #0
	BLE	change
	B	payment	


change: @ Calculate the absolute value of the remainder and show the user's change. Then, send to respective routine for decrementing stock
	
	MOV	r2, #-1
	MUL	r1, r10, r2
	LDR	r0, =changeMsg
	BL	printf

	LDR	r0, =type
	LDR	r0, [r0]
	
	CMP	r9, #0
	BEQ	boughtc

	CMP	r9, #1
	BEQ	boughtm

	CMP	r9, #2
	BEQ	boughtp

	CMP	r9, #3
	BEQ	boughtg

boughtc: @ Cheese crackers stocking

	LDR	r0, =dispense1
	BL	printf

	LDR	r0, =crackers
	LDR	r0, [r0]
	ADD	r0, #-1
	LDR	r1, =crackers
	STR	r0, [r1]


	B	checkempty

boughtm: @ Stocking

	LDR	r0, =dispense2
	BL	printf

	LDR	r0, =ms
	LDR	r0, [r0]
	ADD	r0, #-1
	LDR	r1, =ms
	STR	r0, [r1]

	B	checkempty

boughtp: @ Stocking

	LDR	r0, =dispense3
	BL	printf

	LDR	r0, =peanuts
	LDR	r0, [r0]
	ADD	r0, #-1
	LDR	r1, =peanuts
	STR	r0, [r1]

	B	checkempty

boughtg: @ Stocking

	LDR	r0, =dispense4
	BL	printf

	LDR	r0, =gum
	LDR	r0, [r0]
	ADD	r0, #-1
	LDR	r1, =gum
	STR	r0, [r1]

	B	checkempty

checkempty: @ Checks to see if all snacks are out of stock each time a snack is decremented

	LDR	r0, =crackers
	LDR	r0, [r0]
	CMP	r0, #0
	BLE	empty1
	
	B	select

empty1:  @ Checks to see if all snacks are out of stock each time a snack is decremented

	LDR	r0, =ms
	LDR	r0, [r0]
	CMP	r0, #0
	BLE	empty2

	B	select

empty2:  @ Checks to see if all snacks are out of stock each time a snack is decremented

	LDR	r0, =peanuts
	LDR	r0, [r0]
	CMP	r0, #0
	BLE	empty3

	B 	select

empty3:  @ Checks to see if all snacks are out of stock each time a snack is decremented

	LDR	r0, =gum
	LDR	r0, [r0]
	CMP	r0, #0
	BLE	outofstock

	B	select

outofstock:	@ Inform the user the vending machine is empty

	LDR	r0, =exitMsgS
	BL	printf

@ Force the exit of this program and return command to OS.
exit:

	LDR	r0, =exitMsg
	BL	printf

	MOV  r7, #0x01
	SVC  0

errorpay:	@ Error input for payment choice

	LDR	r0, =errorMsg
	BL	printf

loopscanerrorpay:@ Clear input buffer

	LDR	r0, =inputType		
	LDR	r1, =input		
	BL	scanf

	LDR	r1, =input
	LDR	r1, [r1]
	CMP	r1, #10
	BNE	loopscanerrorpay

	B	payment


error:	@ Error for snack selection choice

	LDR	r0, =errorMsg
	BL	printf

loopscan: @ Clear input buffer

	LDR	r0, =inputType		
	LDR	r1, =input		
	BL	scanf

	LDR	r1, =input
	LDR	r1, [r1]
	CMP	r1, #10
	BNE	loopscan

	B	select

error2:	@ Error for yer or no

	LDR	r0, =errorMsg2
	BL	printf

loopscan2: @ Clear input buffer

	LDR	r0, =inputType		
	LDR	r1, =input		
	BL	scanf

	LDR	r1, =input
	LDR	r1, [r1]
	CMP	r1, #10
	BNE	loopscan2

	B	confirmation

stock: @ Inform user this particular snack is out of stock

	LDR	r0, =stockMsg
	BL	printf
	B	select

	

@ Declare the stings

.data       @ Lets the OS know it is OK to write to this area of memory. 

.balign 4   @ Force a word boundary.
string1:	.asciz	"Vending machine loading. . .\n" 

.balign 4   @ Force a word boundary.
errorMsg:	.asciz	"Unrecognized code\n\n" 

.balign 4   @ Force a word boundary.
changeMsg:	.asciz	"Change: %d cents\n" 

.balign 4   @ Force a word boundary.
dispense1:	.asciz	"Cheese Crackers dispensed\n\n" 

.balign 4   @ Force a word boundary.
dispense2:	.asciz	"M&Ms dispensed\n\n"

.balign 4   @ Force a word boundary.
dispense3:	.asciz	"Peanuts dispensed\n\n"

.balign 4   @ Force a word boundary.
dispense4:	.asciz	"Gum dispensed\n\n"

.balign 4   @ Force a word boundary.
exitMsg:	.asciz	"Goodbye. . .\n" 

.balign 4   @ Force a word boundary.
exitMsgS:	.asciz	"<Out of all items>\n" 

.balign 4   @ Force a word boundary.
stockMsg:	.asciz	"Out of stock. Please choose another snack\n\n" 

.balign 4   @ Force a word boundary.
errorMsg2:	.asciz	"Input Y/N:\n"

.balign 4   @ Force a word boundary.
confirm1:	.asciz	"Cheese Crackers selected. Is this correct? Enter Y/N:\n" 

.balign 4   @ Force a word boundary.
confirm2:	.asciz	"M&Ms selected. Is this correct? Enter Y/N:\n" 

.balign 4   @ Force a word boundary.
confirm3:	.asciz	"Peanuts selected. Is this correct? Enter Y/N:\n" 

.balign 4   @ Force a word boundary.
confirm4:	.asciz	"Gum selected. Is this correct? Enter Y/N:\n" 

.balign 4   @ Force a word boundary.
instruction:	.asciz	"Welcome to Mr. Zippy's vending machine!\n\nCosts:\nGum($0.50) Cheese Crackers($0.65) Peanuts($0.55) M&Ms($1.00)\n" 

.balign 4   @ Force a word boundary.
instruction2:	.asciz	"Snack Codes: Gum(G) Cheese Crackers(C) Peanuts(P) M&Ms(M) Exit(E)\nInput a value:\n"

.balign 4   @ Force a word boundary.
payMsg:	.asciz	"Dimes(D) Quarters(Q) Dollar Bills(B)\nEnter payment:\n"

.balign 4   @ Force a word boundary.
gum:	.word	0

.balign 4   @ Force a word boundary.
peanuts:	.word	0

.balign 4   @ Force a word boundary.
crackers:	.word	0

.balign 4   @ Force a word boundary.
ms:	.word	0

.balign 4   @ Force a word boundary.
type:	.word	0

.balign 4
input: .asciz	" "

.balign 4
sender: .asciz	"%c\n"

.balign 4
inputType: .string "%c"

.balign 4   @ Force a word boundary.
inv1:	.asciz	"\nCheese Crackers: %d\n" 

.balign 4   @ Force a word boundary.
inv2:	.asciz	"M&Ms: %d\n" 

.balign 4   @ Force a word boundary.
inv3:	.asciz	"Peanuts: %d\n" 

.balign 4   @ Force a word boundary.
inv4:	.asciz	"Gum: %d\n\n" 

.balign 4   @ Force a word boundary.
due:	.asciz	"Amount due: %d cents\n" 


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
