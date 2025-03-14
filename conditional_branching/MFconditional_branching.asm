;*****************************************************************
; Title:      Conditional Branching Lab
; Course:     COSC 350
; Author:     Michael Fournier
;*****************************************************************

.386
.model flat, stdcall
.stack 4096

; External function for terminating the process
ExitProcess proto, dwExitCode:dword

INCLUDE Irvine32.inc

.data


.code
main proc


main endp
end main
