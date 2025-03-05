;Data Transfer Lab
;COSC 350
;Michael Fournier

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
	;Exercise One--Creating definitions and initializing values 
	;for the following data types: BYTE, SBYTE, WORD, SWORD, DWORD, SDWORD, REAL4
	myByte		BYTE		22h
	mySbyte		SBYTE		-22h
	myWord		WORD		4444h
	mySword		SWORD		-4444h
	myDword		DWORD		88888888h
	mySdword	SDWORD		-88888888h
	myReal4		REAL4		3.1415927

	;Exercise Two--Declare an array of 60 unsigned double words
	myArr		DWORD		60 dup(?)			;An array of 60 uninitialized DWORDs
	myInitArr	DWORD		60 dup(0ABCDABCDh)	;An array of 60 initialized DWORDs

	;Exercise Three--Create a DWORD that stores 12345678h
	myHexDword	DWORD		12345678h
	
	;Exercise Four--Make a DWORD called 'three'
	three		DWORD		44448888h

	;Exercise Five--Implement the "Summing an Integer Array" and update it 
	;to use a scale factor instead of direct addressing
	intArray	DWORD		10000h, 20000h, 30000h, 40000h

	;Exercise Six--Define "Michael Fournier" as a null-terminated string
	myName		BYTE		"Michael Fournier", 0

	;Exercise Seven-An array that will store Michael Fournier
	myNameArray	BYTE		14 dup(?)


.code
main proc
	;Exercise One--Moving variables into a register that properly contains their value
	;for the following data types: BYTE, SBYTE, WORD, SWORD, DWORD, SDWORD, REAL4
	mov al, myByte
	movsx ax, mySbyte			; Sign-extend SBYTE into AX
	movzx ebx, myWord			; Zero-extend WORD into EBX
	mov bx, mySword			; Sign-extend SWORD into lower BX
	mov eax, myDword
	mov edx, mySdword
	fld myReal4					; Load floating-point value into FPU

	;Exercise Four--Moving the upper half to the lower half of the DWORD 'three'
	mov eax, three
	ror eax, 16					; Swaps the upper and lower 16-bit halves of EAX

	;Exercise Five--Implement the "Summing an Integer Array"
	mov edi, OFFSET intArray	; Moves the address of intArray into EDI
	mov ecx, LENGTHOF intArray	; Number of elements in the array
	mov eax, 0					; Initialize sum to 0

sumLoop:
	add eax, [edi]				; Adds the dereferenced value of EDI to EAX
	add edi, TYPE intArray		; Moves to the next element in intArray
	loop sumLoop				; Repeat until ECX reaches 0

	;Exercise Five (Modified) -- Using a Scale Factor for Indexed Addressing
	mov ecx, LENGTHOF intArray  ; Number of elements
	mov eax, 0                  ; Initialize sum
	mov edx, 0                  ; Index counter

sumLoopScaleFactor:
	add eax, [intArray + edx*4] ; Access elements using index scaled by 4 (DWORD size)
	inc edx                     ; Move to next index
	cmp edx, ecx                ; Compare index with array size
	loop sumLoopScaleFactor     ; Jump back if not at the end

	;Exercise 7--Create a loop that copies Michael Fournier into myNameArray in reverse order
	mov ecx, LENGTHOF myName - 1  ; Length of the string (excluding null terminator)
	mov esi, OFFSET myName        ; Source string start
	mov edi, OFFSET myNameArray   ; Destination array start

myNameLoop:
	mov al, [esi + ecx - 1]  ; Read from the end of myName
	mov [edi], al            ; Write to myNameArray in forward order
	inc edi                  ; Move to next position
	loop myNameLoop           ; Continue until ECX is 0

	invoke ExitProcess, 0
main endp
end main
