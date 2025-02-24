

;Beginning Lab
;COSC 350
;Michael Fournier

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword
.data
    MY_A    DWORD    00000023h
    MY_B    DWORD    00000042h
    MY_C    DWORD    00000091h
    MY_D    DWORD    00000012h

    MY_24   DWORD    00000018h
    MY_13   DWORD    0000000Dh

;QUESTION 4-----------------------------------------------------------
    myName BYTE "Michael Fournier", 0

    myByte      BYTE    0FFh           ; 8-bit  (255 in unsigned decimal)
    myWord      WORD    1234h          ; 16-bit (4660 in decimal)
    myDword     DWORD   12345678h      ; 32-bit (305419896 in decimal)

    mySignedByte   SBYTE  -10        ; -10 decimal = 0xF6 in hex
    mySignedWord   SWORD  -1234      ; -1234 decimal
    mySignedDword  SDWORD -12345678  ; -12,345,678 decimal


.code
main proc
;QUESTION 1-----------------------------------------------------------
    mov eax,    5   ;moves 5h to eax register
    add eax,    6   ;adds 6h to eax register

;QUESTION 2-----------------------------------------------------------
    mov eax,MY_A    ;moves MY_A to eax register
    mov ebx,MY_B    ;moves MY_B to ebx register
    mov ecx,MY_C    ;moves MY_C to ecx register
    mov edx,MY_D    ;moves MY_D to edx register

    add ecx,edx     ;adds value stored in edx to ecx    (MY_C + MY_D)
    add eax,ebx     ;adds value stored in ebx to eax    (MY_A + MY_B)
    sub eax,ecx     ;subtracts value of ecx from eax    (MY_A + MY_B) - (MY_C + MY_D)

;QUESTION 3-----------------------------------------------------------
    mov eax,MY_A    ;moves MY_A to eax register
    mov ebx,MY_B    ;moves MY_B to ebx register
    mov ecx,MY_C    ;moves MY_C to ecx register
    mov edx,MY_D    ;moves MY_D to edx register

    mov esi,ecx   ;moves value of MY_C to temp register esi
    sub esi,MY_13 ;subtracts 13d from MY_C   (MY_C – 13d)
    add edx,MY_24       ;adds 18h(24d) to edx register      (MY_D + 24d)

    add ebx,esi         ;adds vaue in esi to ebx register   ((MY_C - 13d) + B)
    add eax,ebx         ;(MY_A + ((MY_C - 13d) + B))
    sub ecx,eax         ;(MY_C - (MY_A + ((MY_C - 13d) + B)))
    add ecx,edx         ;((MY_A + ((MY_C - 13d) + B)) + (MY_D + 24d))

    mov eax,ecx         ;MY_A = MY_C


	invoke ExitProcess,0
main endp
end main