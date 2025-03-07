;Class Examples
;COSC 350
;Michael Fournier

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

INCLUDE Irvine32.inc

.data
	; declare variables here
	strl BYTE "Sample String, in color"
	arrayD DWORD 100hS


.code
main proc
	; Code Processes here
	mov ax, red + (cyan *16)
	call	SetTextColor

	mov edx, 



	invoke ExitProcess, 0
main endp
end main
