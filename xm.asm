section .data
    fib_num equ 10         ; Set the value of n (the desired Fibonacci number)

section .bss
    fib_result resq 8      ; Reserve space to store the result (64-bit integer)

section .text
    global _start

_start:
    ; Check if fib_num is 0 or 1
    cmp byte [fib_num], 0
    je fib_0
    cmp byte [fib_num], 1
    je fib_1

    ; Initialize the Fibonacci sequence
    mov rax, 0          ; First Fibonacci number
    mov rbx, 1          ; Second Fibonacci number

    ; Loop to calculate the nth Fibonacci number
    mov rcx, byte [fib_num] ; Load the value of n into the counter
    dec rcx             ; Decrement by 1 because we already have the first two numbers
fib_loop:
    add rax, rbx        ; Calculate next Fibonacci number: rax = rax + rbx
    mov rbx, rax        ; Update rbx to store the previous Fibonacci number
    dec rcx             ; Decrement the counter
    jnz fib_loop        ; Repeat the loop until rcx becomes zero

    ; Store the result (nth Fibonacci number) in fib_result
    mov qword [fib_result], rax

    ; Exit the program
    mov rax, 60         ; syscall number for exit
    xor rdi, rdi        ; status code 0
    syscall

fib_0:
    ; If n is 0, the result is 0
    mov qword [fib_result], 0
    jmp exit_program

fib_1:
    ; If n is 1, the result is 1
    mov qword [fib_result], 1

exit_program:
    ; Exit the program
    mov rax, 60         ; syscall number for exit
    xor rdi, rdi        ; status code 0
    syscall
