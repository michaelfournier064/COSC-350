;***************************************************************
; Title:       Conditional Branching Lab
; Course:      COSC 350 - Assembly Language Programming
; Author:      Michael Fournier (modified for camel case)
;***************************************************************

.386
.model flat, stdcall
.stack 4096

ExitProcess proto, dwExitCode:dword

INCLUDE Irvine32.inc

.data
;***************************************************************
; Task 0 Data - Memory location for if-else value
;***************************************************************
myVar DWORD ?  ; Variable to store the result of the condition

;***************************************************************
;  Task 2 Data - Lower/upper bounds and sample PIN
;  Each label is an array of 5 ASCII digits
;***************************************************************
lowerBound db '0','0','0','0','0'
upperBound db '9','9','9','9','9'
samplePin  db '1','2','3','4','5'

.code
;***************************************************************
; Task 0: Conditional Branching Procedure
; Compares EAX with ECX and EDX using short-circuit evaluation
;***************************************************************
conditionalCheck proc
    ; Compare EAX with ECX
    cmp eax, ecx
    jle orCheck       ; If EAX is less than or equal to ECX, skip to the OR condition

    ; Compare EAX with EDX.
    cmp eax, edx
    jge orCheck       ; If EAX is greater than or equal to EDX, skip to the OR condition

    ; Both conditions satisfied: (EAX > ECX) AND (EAX < EDX)
    mov myVar, 10000000h
    jmp callEnd

orCheck:
    ; Check OR condition: if (EDX > ECX)
    cmp edx, ecx
    jle elseCase      ; If EDX is less than or equal to ECX, go to the else case
    mov myVar, 10000000h
    jmp callEnd

elseCase:
    ; Neither condition satisfied; assign alternative value
    mov myVar, 20000000h

callEnd:
    ret
conditionalCheck endp

;***************************************************************
; Task 1: Decrement Loop Procedure
; A loop that decrements EAX and EBX while conditions are met
;***************************************************************
decrementLoop proc
loopStart:
    ; Check if EAX is greater than 1.
    cmp eax, 1
    jle loopExit    ; Exit loop if EAX is less than or equal to 1

    ; Check if EBX is greater than 2
    cmp ebx, 2
    jle loopExit    ; Exit loop if EBX is less than or equal to 2

    ; Both conditions met; decrement EAX and EBX
    dec eax
    dec ebx

    ; Repeat the loop
    jmp loopStart

loopExit:
    ret
decrementLoop endp

;***************************************************************
; Task 2: Validate PIN Procedure
; Validates a 5-digit PIN against predefined bounds
;***************************************************************
validatePin proc
    push    ebp
    mov     ebp, esp
    push    ebx
    push    esi
    push    edi

    ; Parameter: pointer to the 5-digit PIN array
    mov     esi, [ebp+8]
    lea     edi, lowerBound   ; Point to the lower bounds array
    lea     ebx, upperBound   ; Point to the upper bounds array

    xor     edx, edx          ; Initialize index (EDX = 0)

validateLoop:
    cmp     edx, 5            ; Process 5 digits
    jge     allValid          ; If index equals 5, all digits are valid

    ; Load current digit and check against the lower bound
    mov     al, [esi + edx]
    cmp     al, [edi + edx]
    jl      invalidDigit

    ; Check against the upper bound.
    cmp     al, [ebx + edx]
    jg      invalidDigit

    inc     edx               ; Move to the next digit
    jmp     validateLoop

invalidDigit:
    mov     eax, edx          ; Return index of the invalid digit
    jmp     cleanup

allValid:
    mov     eax, -1           ; All digits valid: return -1

cleanup:
    pop     edi
    pop     esi
    pop     ebx
    mov     esp, ebp
    pop     ebp
    ret     4               ; Clean up the parameter from the stack
validatePin endp

;***************************************************************
; Main Procedure
;***************************************************************
main proc
    ; Execute Task 0: Conditional Branching
    call conditionalCheck

    ; Execute Task 1: Decrement Loop
    call decrementLoop

    ; Execute Task 2: Validate PIN
    push    offset samplePin
    call    validatePin

    invoke ExitProcess, 0
main endp

end main
