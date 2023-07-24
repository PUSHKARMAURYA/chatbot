section .data
    fib_num equ 10         ; Set the value of n (the desired Fibonacci number)

section .bss
    fib_result resd 1      ; Reserve space to store the result (32-bit integer)

section .text
    global _start

_start:
    ; Check if fib_num is 0 or 1
    cmp byte [fib_num], 0
    je fib_0
    cmp byte [fib_num], 1
    je fib_1

    ; Initialize the Fibonacci sequence
    mov eax, 0          ; First Fibonacci number
    mov ebx, 1          ; Second Fibonacci number

    ; Loop to calculate the nth Fibonacci number
    mov ecx, byte [fib_num] ; Load the value of n into the counter
    dec ecx             ; Decrement by 1 because we already have the first two numbers
fib_loop:
    add eax, ebx        ; Calculate next Fibonacci number: eax = eax + ebx
    mov ebx, eax        ; Update ebx to store the previous Fibonacci number
    dec ecx             ; Decrement the counter
    jnz fib_loop        ; Repeat the loop until ecx becomes zero

    ; Store the result (nth Fibonacci number) in fib_result
    mov dword [fib_result], eax

    ; Exit the program
    mov eax, 1          ; syscall number for exit
    xor ebx, ebx        ; status code 0
    int 0x80

fib_0:
    ; If n is 0, the result is 0
    mov dword [fib_result], 0
    jmp exit_program

fib_1:
    ; If n is 1, the result is 1
    mov dword [fib_result], 1

exit_program:
    ; Exit the program
    mov eax, 1          ; syscall number for exit
    xor ebx, ebx        ; status code 0
    int 0x80
