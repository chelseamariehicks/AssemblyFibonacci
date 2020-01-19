TITLE Programming Assignment #2     (prog02.asm)

; Author: Chelsea Marie Hicks
; OSU email address: hicksche@oregonstate.edu
; Course number/section: CS 271-400
; Project Number: Program #2           Due Date: January 26, 2020 by 11:59 PM
; Description: This program acquires an integer, n, between 1-46 and displays all
;	of the Fibonacci numbers up to and including the nth term. This program also 
;	validates user input to ensure an integer between 1-46 is entered.

INCLUDE Irvine32.inc

UPPER_LIMIT 	EQU		46			;defines the upper limit as a constant = 46 
LOWER_LIMIT	EQU		1			;defines the lower limit as a constant = 1
TERM_LIMIT	EQU		5			;defines limit of terms printed on a line = 5

.data

;messages printed to screen throughout program
progTitle	BYTE	"Fibonacci Numbers Unveiled", 0
authName	BYTE	"Written by Chelsea Marie Hicks", 0
greeting1	BYTE	"Welcome! What is your name? ", 0
greeting2	BYTE	"Nice to meet you, ", 0
instruc1	BYTE	"Enter the number of Fibonacci terms to be displayed.", 0
instruc2	BYTE	"The number must be an integer between 1-46.", 0
numPrompt	BYTE	"Enter a number: ", 0
errMsg		BYTE	"The number you entered must be between 1-46! Try again.", 0
closing		BYTE	"Farewell, ", 0

;useful components
punc		BYTE	".", 0
spacing		BYTE	"     ", 0

;variables for user input and loop operation
userName	BYTE	36 DUP(0)	;store the user's name
userNum		DWORD	?			;store n, the number of terms selected by user
fibNum		DWORD	?			;first term in Fibonacci seq. set to 1
termCount	DWORD	0			;counter for number of terms on each line 


.code
main PROC
;Display introduction
introduction:
	mov		edx, OFFSET progTitle			;print program and author name
	call	WriteString
	call	Crlf
	mov		edx, OFFSET authName
	call	WriteString
	call	Crlf
	call	Crlf

;Acquire user name and greet the user
	mov		edx, OFFSET greeting1			;get user name
	call	WriteString
	mov		edx, OFFSET userName
	mov		ecx, SIZEOF userName
	call	ReadString

	mov		edx, OFFSET greeting2			;greet the user
	call	WriteString
	mov		edx, OFFSET userName
	call	WriteString
	mov		edx, OFFSET punc
	call	WriteString
	call	Crlf
	call	Crlf

;Instructions for the user 
userInstructions:
	mov		edx, OFFSET instruc1			;print instructions for the user
	call	WriteString
	call	Crlf
	mov		edx, OFFSET instruc2
	call	WriteString
	call	Crlf
	call	Crlf

;Validate the user entered a number of terms between 1-46 using a post-test loop
getUserData:
	mov		edx, OFFSET numPrompt			;get number of terms selected from user
	call	WriteString
	call	ReadInt
	cmp		eax, UPPER_LIMIT				;check integer < 46
	jg		err								;jump to error label if greater
	cmp		eax, LOWER_LIMIT				;check integer > 1
	jl		err								;jump to error label if less
	jmp		valid			

err:
	mov		edx, OFFSET errMsg				;print error message to screen
	call	WriteString
	call	Crlf
	call	Crlf
	jmp		getUserData						;return to loop for user to enter a number

valid:
	mov		userNum, eax					;store the user choice in variable
	call	Crlf

;Display Fibonacci numbers up to and including the number of terms selected by user
;using a counted loop - The second-order Fibonacci sequence begins with the first
;two terms equal to one and all other terms are calculated as the sum previous
;two terms in an algorithm where f(n) = f(n-2) + f(n-1), like so: 
;1+1=2, 1+2=3, 2+3=5, etc.

displayFibs:
	mov		fibNum, 1						;set fibNum as first term = 1, (n-2)
	mov		eax, fibNum						;print the first term to screen
	call	WriteDec
	mov		edx, OFFSET spacing				;update termCount and userNum
	call	WriteString
	inc		termCount
	dec		userNum
	mov		ebx, 1							;set ebx as second term = 1, (n-1)
	mov		eax, ebx						;print second term to screen
	call	WriteDec
	mov		edx, OFFSET spacing				;update termCount and userNum
	call	WriteString
	inc		termCount
	dec		userNum
	mov		ecx, userNum					;place userNum in ecx as loop control
	
;calculate and display Fibonacci numbers beyond first two terms
fibLoop:
	mov		eax, ebx						;add terms and print to screen
	add		eax, fibNum						
	call	WriteDec
	mov		fibNum, ebx						;term in ebx becomes fibNum
	mov		ebx, eax						;sum of previous terms becomes ebx
	inc		termCount						;increment term counter after printing
	cmp		termCount, TERM_LIMIT			;check if term limit has been reached
	jge		nextLine
	mov		edx, OFFSET spacing				;place five spaces in between terms
	call	WriteString
	jmp		continue

nextLine:
	call	Crlf
	mov		termCount, 0

continue:
	loop	fibLoop							;subtract one from ecx and continue
											;until userNum of terms is printed

;Bid the user adieu
farewell:
	call	Crlf
	call	Crlf
	mov		edx, OFFSET closing				;print closing message
	call	WriteString
	mov		edx, OFFSET userName
	call	WriteString
	mov		edx, OFFSET punc
	call	WriteString
	call	Crlf

	exit	; exit to operating system
main ENDP

END main
