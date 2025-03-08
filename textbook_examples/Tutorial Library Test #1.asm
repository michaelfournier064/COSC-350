;*****************************************************************
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
;*****************************************************************
; Part 1--Changing the text and background color, 
;*****************************************************************
    mov eax, BlueTextOnGray     ; Moves the information from memory to register
    call SetTextColor           ; Changes the stored color values

    call Clrscr                 ; Clears the screen of all data

    mov esi, OFFSET arrayD      ; Copies the address of arrayD to esi

    mov ebx, TYPE arrayD        ; A double word is 4 bytes, so 4 is moved to ebx

    mov ecx, LENGTHOF arrayD    ; Number of SDWORD's in arrayD
    call DumpMem                ; Displays the memory informaion

;*****************************************************************
; Part 2
;*****************************************************************
    call Crlf                   ; Outputs a empty line by terminating the previous one
    mov ecx, COUNT              ; Copies COUNT into the ecx register

    L1:
        mov edx, OFFSET prompt
        call WriteString
        call ReadInt            ; Input 32-bit signed integer into eax from the keyboard
        call Crlf               ; Displays a new line by terminating the previous one
        
        call WriteInt           ; Outputs eax in signed decimal format
        call Crlf               ; Displays a new line by terminating the previous one

        call WriteHex           ; Outputs eax in hexidecimal
        call Crlf               ; Displays a new line by terminating the previous one
        call WriteBin           ; Outputs eax in binary
        call Crlf               ; Displays a new line by terminating the previous one
        call Crlf               ; Displays a new line by terminating the previous one

        Loop L1                 ; Number of loops is set by ecx, which is set to COUNT outside of the loop

    call WaitMsg            ; Outputs a message promtting the user to input a key for the program to contine

    mov eax, DefaultColor
    call SetTextColor
    call Clrscr


    invoke ExitProcess, 0
main endp
end main
