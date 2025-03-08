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

INCLUDE Irvine32.inc

.data
;--------------------------------------------------------
; Data Declarations for Task 1 (myLoops Procedure)
;--------------------------------------------------------
innerLoopPrompt BYTE "Your number of inner loops is: ", 0
outerLoopPrompt BYTE "Your number of outer loops is: ", 0
totalLoopPrompt BYTE "Your total number of loops is: ", 0
innerCount      DWORD ?           ; (Not used; inner loop count is stored in int2)
outerCount      DWORD ?           ; Counts the number of outer loop iterations executed
count           DWORD ?           ; Total number of inner loop iterations across all outer iterations
int1            DWORD ?           ; Stores the randomly generated outer loop count (range 1-10)
int2            DWORD ?           ; Stores the randomly generated inner loop count (range 1-10)

;--------------------------------------------------------
; Data Declarations for Task 2 (Procedure Chain Prompts)
;--------------------------------------------------------
procAPrompt   BYTE "procA: Loaded 'a' and calling procB.", 0
procBPrompt   BYTE "procB: Loaded 'b' and calling procC.", 0
procCPrompt   BYTE "procC: Loaded 'c' and returning.", 0

.code
;--------------------------------------------------------
; Task 0: printRandomLetters
; Expects: ECX = number of letters to print.
; For each iteration, this procedure:
;   - Generates a random letter ('A'..'Z').
;   - Generates a random color (0-15).
;   - Sets the text color and prints the letter.
;--------------------------------------------------------
printRandomLetters proc
    mov eax, 0000001Fh         ; Load 31d into EAX (upper bound for random letter count)
    call RandomRange           ; Generate a random number between 0 and 14 in EAX
    mov ecx, eax               ; Copy random letter count to ECX
    add ecx, 00000001h         ; Adjust count to range 1-31

prtRandLetters:
    mov eax, 10h               ; Load 16d into EAX (upper bound for random color)
    call RandomRange           ; Generate a random color between 0 and 15 in EAX
    call SetTextColor          ; Set text color based on random value in EAX

    mov eax, 1Ah               ; Load 26d into EAX (upper bound for random letter)
    call RandomRange           ; Generate a random number between 0 and 25 in EAX
    add eax, 'A'               ; Adjust to ASCII uppercase letter range
    call WriteChar             ; Output the random letter

    loop prtRandLetters        ; Repeat until ECX is 0

    mov eax, white             ; Reset text color to white
    call setTextColor

    call Crlf                  ; New line
    call Crlf                  ; New line

    ret
printRandomLetters endp

;--------------------------------------------------------
; Task 1: myLoops
; Expects:
;   EAX = number of outer loops (randomly generated)
;   EBX = number of inner loops (randomly generated)
; This procedure uses nested loops to count from 0.
; The final count (outerCount * innerCount) is returned in EAX.
;--------------------------------------------------------
myLoops proc
    ; Generate random outer loop count (range 1-10)
    mov eax, 0Ah             ; Load 10d into EAX (upper bound for random generation)
    call RandomRange         ; Generate a random value between 0 and 9 in EAX
    add eax, 1               ; Adjust value to range 1-10
    mov int1, eax            ; Save the generated outer loop count in int1

    ; Generate random inner loop count (range 1-10)
    mov eax, 0Ah             ; Load 10d into EAX (upper bound for random generation)
    call RandomRange         ; Generate a random value between 0 and 9 in EAX
    add eax, 1               ; Adjust value to range 1-10
    mov int2, eax            ; Save the generated inner loop count in int2

    ; Initialize counters for outer loop iterations and total inner iterations
    mov outerCount, 0        ; Clear outer loop iteration counter
    mov count, 0             ; Clear total inner loop iterations counter

    ; Set up the outer loop counter using the original outer count
    mov ecx, int1            ; Load outer loop count (int1) into ECX for looping

outerLoop:
    inc outerCount           ; Increment outer loop counter to track iterations

    ; Set up inner loop for each outer iteration using a separate register
    mov edx, int2            ; Load inner loop count (int2) into EDX for inner loop

innerLoop:
    inc count                ; Increment total inner loop iterations counter
    dec edx                ; Decrement inner loop counter
    jnz innerLoop            ; If EDX is not zero, continue inner loop

    loop outerLoop           ; Decrement ECX; if not zero, repeat outer loop

    ; Display inner loop count (original random inner loop value)
    mov edx, OFFSET innerLoopPrompt  ; Load address of inner loop prompt string
    mov eax, int2                    ; Move original inner loop count into EAX
    call WriteString                 ; Print the inner loop prompt
    call WriteDec                    ; Print the inner loop count
    call Crlf                      ; New line

    ; Display outer loop count (number of outer iterations executed)
    mov edx, OFFSET outerLoopPrompt  ; Load address of outer loop prompt string
    mov eax, outerCount              ; Move outer loop iteration count into EAX
    call WriteString                 ; Print the outer loop prompt
    call WriteDec                    ; Print the outer loop count
    call Crlf                      ; New line

    ; Display total loop count (sum of all inner loop iterations)
    mov edx, OFFSET totalLoopPrompt  ; Load address of total loop prompt string
    mov eax, count                   ; Move total inner loop iterations count into EAX
    call WriteString                 ; Print the total loop prompt
    call WriteDec                    ; Print the total loop count

    call Crlf                      ; New line
    call Crlf                      ; New line

    ret                        ; Return from the myLoops procedure
myLoops endp

;--------------------------------------------------------
; Task 2: Procedure Chain (procA, procB, procC)
; This task creates three procedures that call each other:
;   procA: Puts the character 'a' in EAX, displays a prompt, and calls procB.
;   procB: Puts the character 'b' in EAX, displays a prompt, and calls procC.
;   procC: Puts the character 'c' in EAX, displays a prompt, and returns.
;--------------------------------------------------------
procA proc
    mov eax, 'a'                 ; Load EAX with character 'a'
    mov edx, OFFSET procAPrompt  ; Load address of procA prompt string
    call WriteString             ; Display procA prompt
    call Crlf                  ; New line
    call procB                   ; Call procB
    ret                          ; Return from procA
procA endp

procB proc
    mov eax, 'b'                 ; Load EAX with character 'b'
    mov edx, OFFSET procBPrompt  ; Load address of procB prompt string
    call WriteString             ; Display procB prompt
    call Crlf                  ; New line
    call procC                   ; Call procC
    ret                          ; Return from procB
procB endp

procC proc
    mov eax, 'c'                 ; Load EAX with character 'c'
    mov edx, OFFSET procCPrompt  ; Load address of procC prompt string
    call WriteString             ; Display procC prompt
    call Crlf                  ; New line
    ret                          ; Return from procC
procC endp

;--------------------------------------------------------
; Main Procedure
;--------------------------------------------------------
main proc
    call Randomize         ; Seed the random number generator
    call printRandomLetters; Task 0: Print random letters with random colors
    call myLoops           ; Task 1: Execute nested loops and display counts
    call procA             ; Task 2: Execute procedure chain (procA -> procB -> procC)
    invoke ExitProcess, 0  ; Terminate the process with exit code 0
main endp

end main
