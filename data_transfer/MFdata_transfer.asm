;*****************************************************************
; Title:      Data Transfer Lab
; Course:     COSC 350
; Author:     Michael Fournier
;*****************************************************************

.386
.model flat, stdcall
.stack 4096

; External function for terminating the process
ExitProcess proto, dwExitCode:dword

.data
    ;---------------------------
    ; Exercise 1: Data Type Initialization
    ;---------------------------
    myByte     BYTE   22h            ; Unsigned 8-bit value
    mySbyte    SBYTE  -22h           ; Signed 8-bit value
    myWord     WORD   4444h          ; Unsigned 16-bit value
    mySword    SWORD  -4444h         ; Signed 16-bit value
    myDword    DWORD  88888888h      ; Unsigned 32-bit value
    mySdword   SDWORD -88888888h      ; Signed 32-bit value
    myReal4    REAL4  3.1415927       ; 32-bit floating-point value

    ;---------------------------
    ; Exercise 2: Array Declarations
    ;---------------------------
    myArr      DWORD  60 dup(?)               ; Array of 60 uninitialized DWORDs
    myInitArr  DWORD  60 dup(0ABCDABCDh)        ; Array of 60 DWORDs initialized to 0ABCDABCDh

    ;---------------------------
    ; Exercise 3: Hexadecimal DWORD Declaration
    ;---------------------------
    myHexDword DWORD  12345678h               ; DWORD storing hexadecimal value 12345678h

    ;---------------------------
    ; Exercise 4: 'three' Declaration and Bitwise Manipulation
    ;---------------------------
    three      DWORD  44448888h               ; DWORD 'three'

    ;---------------------------
    ; Exercise 5: Integer Array for Summation
    ;---------------------------
    intArray   DWORD  10000h, 20000h, 30000h, 40000h

    ;---------------------------
    ; Exercise 6: Null-Terminated String Declaration
    ;---------------------------
    myName     BYTE   "Michael Fournier", 0   ; Null-terminated string

    ;---------------------------
    ; Exercise 7: Array for Reversed String Storage
    ;---------------------------
    myNameArray BYTE  14 dup(?)               ; Array to store the reversed string


.code
main proc
    ;-------------------------------------------------
    ; Exercise 1: Transfer Data into Registers
    ;-------------------------------------------------
    mov   al, myByte                ; Load BYTE into AL
    movsx ax, mySbyte               ; Sign-extend SBYTE into AX
    movzx ebx, myWord               ; Zero-extend WORD into EBX
    mov   bx, mySword               ; Load SWORD into BX (preserving sign)
    mov   eax, myDword              ; Load DWORD into EAX
    mov   edx, mySdword             ; Load SDWORD into EDX
    fld   myReal4                   ; Load REAL4 into FPU register

    ;-------------------------------------------------
    ; Exercise 4: Swap Upper and Lower Halves of 'three'
    ;-------------------------------------------------
    mov   eax, three              ; Load 'three' into EAX
    ror   eax, 16                 ; Rotate right by 16 bits to swap the halves

    ;-------------------------------------------------
    ; Exercise 5: Summing an Integer Array (Direct Addressing)
    ;-------------------------------------------------
    mov   edi, OFFSET intArray    ; EDI points to intArray
    mov   ecx, LENGTHOF intArray  ; Set loop counter to the number of elements
    mov   eax, 0                  ; Initialize sum to 0

    sumLoop:
        add   eax, [edi]              ; Add current array element to sum
        add   edi, TYPE intArray      ; Advance pointer by the size of one DWORD
        loop  sumLoop                 ; Decrement ECX and loop if nonzero

    ;-------------------------------------------------
    ; Exercise 5 (Modified): Summing with Scaled Indexing
    ;-------------------------------------------------
    mov   ecx, LENGTHOF intArray  ; Set loop counter to the number of elements
    mov   eax, 0                  ; Reset sum to 0
    xor   edx, edx                ; Initialize index counter (EDX = 0)

    sumLoopScaleFactor:
        add   eax, [intArray + edx*4] ; Add array element using scaled indexing
        inc   edx                   ; Increment index counter
        loop  sumLoopScaleFactor      ; Decrement ECX and loop if nonzero

    ;-------------------------------------------------
    ; Exercise 7: Reverse Copy of String into myNameArray
    ;-------------------------------------------------
    ; Calculate the length of the string (excluding the null terminator)
    mov   ecx, LENGTHOF myName - 1

    ; Set source pointer (ESI) to point to the end of the string
    mov   esi, OFFSET myName
    add   esi, ecx

    ; Set destination pointer (EDI) to the beginning of myNameArray
    mov   edi, OFFSET myNameArray

    ReverseCopyLoop:
        mov   al, [esi - 1]         ; Load character from the end of myName
        mov   [edi], al             ; Store character into myNameArray
        dec   esi                   ; Move source pointer backward
        inc   edi                   ; Move destination pointer forward
        loop  ReverseCopyLoop       ; Decrement ECX and loop if nonzero


    invoke ExitProcess, 0
main endp
end main
