TITLE Programming Assignment #2     (prog02.asm)

; Author: Chelsea Marie Hicks
; OSU email address: hicksche@oregonstate.edu
; Course number/section: CS 271-400
; Project Number: Program #2           Due Date: January 26, 2020 by 11:59 PM
; Description: This program acquires an integer, n, between 1-46 and displays all
;	of the Fibonacci numbers up to and including the nth term. This program also 
;	validates user input to ensure an integer between 1-46 is entered.

INCLUDE Irvine32.inc

UPPER_LIMIT EQU		46			;defines the upper limit as a constant = 46 
LOWER_LIMIT	EQU		1			;defines the lower limit as a constant = 1

.data

;messages printed to screen throughout program
progTitle	BYTE	"Fibonacci Numbers Unveiled", 0
authName	BYTE	"Written by Chelsea Marie Hicks", 0
greeting1	BYTE	"Welcome! What is your name? ", 0
greeting2	BYTE	"Nice to meet you, ", 0
punc		BYTE	".", 0
instruc1	BYTE	"Enter the number of Fibonacci terms to be displayed.", 0
instruc2	BYTE	"The number must be an integer between 1-46.", 0
numPrompt	BYTE	"Enter a number: ", 0
errMsg		BYTE	"The number you entered must be between 1-46! Try again.", 0
closing		BYTE	"Farewell, ", 0

userName	BYTE	36 DUP(0)	;store the user's name
userNum		DWORD	?



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
	jmp		getUserData						;return to loop for user to enter a number

valid:
	mov		userNum, eax					;store the user choicein variable
	call	Crlf

;Display Fibonacci numbers up to and including the number of terms selected by user
;using a counted loop
fibLoop:


;Bid the user adieu
farewell:
	mov		edx, OFFSET closing				;print closing message
	call	WriteString
	mov		edx, OFFSET userName
	call	WriteString
	mov		edx, OFFSET punc
	call	WriteString
	call	Crlf

	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

END main
