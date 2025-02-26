;Class Examples
;COSC 350
;Michael Fournier

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword
.data
	;declare variables here
	myarr	BYTE	11h, 22h, 33h, 44h
	mydwarr	DWORD	1a1b1c1dh, 2a2b2c2dh, 3a3b3c3dh, 4a4b4c4dh
	mystr	BYTE	"Hello, World!", 0dh, 0ah, 0

.code
main proc
	; Basic information about array sizes
	mov eax,	LENGTHOF	myarr   ; Number of elements in myarr
	mov ebx,	TYPE		mydwarr ; Type size (DWORD = 4 bytes)
	mov ecx,	LENGTHOF	mydwarr ; Number of DWORDs
	mov edx,	SIZEOF		mydwarr ; Total byte size

	; Print characters from mystr one by one
	mov ecx, LENGTHOF mystr
	mov esi, OFFSET mystr

top:
	mov al, [esi]   ; Load a single character into AL
	inc esi         ; Move to next character

	loop top        ; Loop until ECX reaches 0

	; Loop through DWORD array
	mov ecx, LENGTHOF mydwarr
	mov esi, OFFSET mydwarr

topDw:
	mov eax, [esi]  ; Load a DWORD into EAX
	add esi, 4      ; Move to next DWORD

	loop topDw      ; Loop until ECX reaches 0

	invoke ExitProcess, 0
main endp
end main
