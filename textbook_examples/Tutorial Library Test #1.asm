;*****************************************************************
TITLE Library Test #1: Integer I/O (InputLoop.asm)
; Tests the Clrscr, Crlf, DumpMem, ReadInt, SetTextColor, 
; WaitMsg, WriteBin, WriteHex, and WriteString procedures.
; Course:     COSC 350
; Author:     Michael Fournier
;*****************************************************************

.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword

INCLUDE     Irvine32.inc
.data
    count = 4
    BlueTextOnGray = blue + (lightGray * 16)
    DefaultColor = lightGray + (black * 16)

    arrayD SDWORD 12345678h, 1A4B200h, 3434h, 7AB9h
    prompt BYTE "Enter a 32-bit signed integer: ", 0


.code
main PROC
    mov eax, BlueTextOnGray     ; Moves the information from memory to register
    call SetTextColor           ; Changes the stored color values

    call Clrscr                 ; Clears the screen of all data

    mov esi, OFFSET arrayD      ; Copies the address of arrayD to esi

    mov ebx, TYPE arrayD        ; A double word is 4 bytes, so 4 is moved to ebx

    mov ecx, LENGTHOF arrayD    ; Number of SDWORD's in arrayD
    call DumpMem                ; Displays the memory informaion




    invoke ExitProcess, 0
main endp
end main
