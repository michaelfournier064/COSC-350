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
	myByte		BYTE		22h
	mySbyte		SBYTE		-22h
	myWord		WORD		4444h
	mySword		SWORD		-4444h
	myDword		DWORD		88888888h
	mySdword	SDWORD		-88888888h
	myReal4		REAL4		3.1415927

	;Exercise Two--Declare an array of 60 unsigned double words
	myArr		DWORD		60 dup(?)			;An array of 60 uninitialized DWORD's
	myInitArr	DWORD		60 dup(0ABCDABCDh)	;An array of 60 initialized DWORD's

	;Exercise Three--Create a dword that stores 12345678h
	myHexDword	DWORD		12345678h
	
	;Exercise Four--Make a DWORD called 'three'
	three		DWORD		44448888h

.code
main proc
	;Exercise One--Moving variables into a register that properly contains their value
	;for the following data types BYTE, SBYTE, WORD, SWORD, DWORD, SDWORD, REAL4
	mov ah,	myBYTE
	mov	al,	mySBYTE
	mov bx, myWORD
	shl ebx,16		;Shift BX value into the upper half of EBX
	mov bx, mySWORD
	mov eax,myDWORD
	mov edx,mySDWORD
	fld myREAL4		;Load floating-point value into FPU

	;Exercise Four--Moving the upper have to the lower have of  the DWORD 'three'
	mov eax,three
	ror eax,16		;Flips the first 16 bits and the last 16 bits in eax

	invoke ExitProcess,0
main endp
end main
