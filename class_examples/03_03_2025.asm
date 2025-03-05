;Class Examples
;COSC 350
;Michael Fournier

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword
.data
	; declare variables here
	myText	BYTE	"friday", "0ah", "0dh", 0
	myRev	BYTE	"?"

.code
main proc
	; Code Processes here
	;mov eax, 0
	;mov ecx, 3
	;top:
		;push ecx
		; Some code here
		;mov ecx, 3
		;top2:
		;add eax, 1
			;loop top2
		;pop ecx
		;loop top

reverse proc
	; loop through each letter
	mov ecx, LENGTHOF myText
	mov esi, OFFSET myText
	revtop:
		movzx eax, BYTE PTR [esi]
		inc esi
		push eax
		loop revtop


	mov ecx, LENGTHOF myText
	mov esi, OFFSET myRev
	revtime:
		pop eax
		inc esi
		mov [esi], eax
		loop revtime

	ret

reverse endp

	invoke ExitProcess, 0
main endp
end main
