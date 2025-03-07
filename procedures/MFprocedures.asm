;*****************************************************************
; Title:      Procedures Lab
; Course:     COSC 350
; Author:     Michael Fournier
;*****************************************************************

.386
.model flat, stdcall
.stack 4096

; External function for terminating the process
ExitProcess proto, dwExitCode:dword

.data



.code
main proc
    


    invoke ExitProcess, 0
main endp
end main
