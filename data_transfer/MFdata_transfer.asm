;Data Transfer Lab
;COSC 350
;Michael Fournier

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword
.data


.code
main proc


	invoke ExitProcess,0
main endp
end main