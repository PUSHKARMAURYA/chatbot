section .data
    fib_limit   dd 10      ; Set the limit for the Fibonacci sequence (change as needed)
    newline     db 10      ; Newline character for output

section .bss
    fib_array   resd 100   ; Array to store the Fibonacci sequence

section .text
    global _start

_start:
    ; Initialize the first two elements of the Fibonacci sequence
    mov dword [fib_array], 0    ; fib_array[0] = 0
    mov dword [fib_array + 4], 1; fib_array[1] = 1

    ; Compute and print the Fibonacci sequence
    mov rax, 2      ; Start computing from the 2nd element
fib_loop:
    cmp rax, [fib_limit]   ; Compare with the limit
    jge print_result      ; If greater or equal, jump to print_result

    ; Compute the next Fibonacci number
    mov rbx, [fib_array + rax - 1]
    add rbx, [fib_array + rax - 2]
    mov [fib_array + rax], rbx

    inc rax         ; Move to the next element
    jmp fib_loop    ; Repeat the loop

print_result:
    ; Print the Fibonacci sequence
    mov rcx, rax    ; Store the number of elements to print in rcx
    mov rdi, fib_array  ; Set rdi to point to the beginning of the array

print_loop:
    mov rax, [rdi]  ; Load the current element
    call print_num  ; Call the function to print the number
    mov rax, newline ; Print newline character
