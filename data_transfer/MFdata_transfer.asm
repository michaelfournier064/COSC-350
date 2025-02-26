;Data Transfer Lab
;COSC 350
;Michael Fournier

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
	;Exercise One--Creating definition's and initialize values 
	;for the following data types BYTE, SBYTE, WORD, SWORD, DWORD, SDWORD, REAL4
	myBYTE		BYTE		22h
	mySBYTE		SBYTE		-22h
	myWORD		WORD		4444h
	mySWORD		SWORD		-4444h
	myDWORD		DWORD		88888888h
	mySDWORD	SDWORD		-88888888h
	myREAL4		REAL4		3.1415927

.code
main proc
	;Exercise One--Moving variables into a register that properly contains their value
	;for the following data types BYTE, SBYTE, WORD, SWORD, DWORD, SDWORD, REAL4
	mov ah,	myBYTE
	mov	al,	mySBYTE
	mov bx, myWORD
	shl ebx, 16    ; Shift BX value into the upper half of EBX
	mov bx, mySWORD
	mov eax, myDWORD
	mov edx, mySDWORD
	fld myREAL4    ; Load floating-point value into FPU

	invoke ExitProcess,0
main endp
end main
