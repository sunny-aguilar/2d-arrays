TITLE Program Template(template.asm)

; Author:							Sandro Aguilar
; Last Modified : July 25, 2019
; OSU email address : aguilasa@oregonstate.edu
; Course number / section:			CS 271 / 400
; Assignment Number : Project 3
; Due Date : July 28, 2019
; Description:						Program that calculates composite numbers from 1 to 300.
;									User input is validated to verify that the number entered
;									is between 1 and 300. Program prompts user until valid
;									valid data is entered.Finally, the program displays the
;									composite up toand including the nth composite.Results
;									are displayed 10 composites per line with at least 3
;									spaces between the numbers.
;
; Implementation notes :
;	This program is implemented using procedures.
;	All variables are global ... no parameter passing

INCLUDE Irvine32.inc

LO = 100
HI = 999

.data
myArr		DWORD 5 DUP(500)
randomNum	DWORD ?
list		DWORD 1,2,3,4
myPtr		DWORD list

.code
main PROC
	mov		esi, myPtr
	mov		eax, [esi+4]
	call	WriteDec
	call	CrLf


	call	Randomize
	push	OFFSET myArr
	call	copyAnArray
	exit							;exit to operating system
main ENDP


copyAnArray PROC
	LOCAL	localARR[5]:DWORD


	;fill array
	mov		edx, localARR[0]
	mov		ebx, 0
	mov		ecx, 5
fillArray:
	call	generateRandom
	mov		randomNum, eax
	mov		localARR[0+ebx], eax
	add		ebx, 4
	loop	fillArray

	;display array
	mov		esi, localARR[0]
	mov		edx, 0
	mov		ecx, 5
displayArray:
	mov		eax, localARR[0 + edx]
	call	WriteDec
	call	CrLf
	add		edx, 4
	loop	displayArray

	ret
copyAnArray ENDP
	





generateRandom PROC
	push	ebp
	mov		ebp, esp
	mov		DWORD PTR[ebp - 4], HI
	mov		DWORD PTR[ebp - 8], LO
	mov		eax, DWORD PTR [ebp - 4]
	sub		eax, DWORD PTR [ebp - 8]
	inc		eax
	call	RandomRange
	add		eax, DWORD PTR [ebp - 8]

	mov		esp, ebp
	pop		ebp
	ret
generateRandom ENDP




END main
