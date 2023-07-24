section .bss
    fib_num resb 10            ; Buffer to store the Fibonacci sequence

section .data
    prompt db "Enter the number of Fibonacci numbers to generate (max 9): ", 0
    out_of_range db "Number out of range. Please enter a value between 1 and 9.", 0
    newline db 10, 0

section .text
    global _start

_start:
    ; Display the prompt
    mov rax, 4
    mov rbx, 1
    mov rcx, prompt
    mov rdx, 57
    syscall

    ; Read user input
    mov rax, 0
    mov rdi, 0
    mov rsi, fib_num
    mov rdx, 2
    syscall

    ; Convert the user input (ASCII) to an integer in RAX
    xor rsi, rsi
    xor rdx, rdx
convert_loop:
    mov al, byte [rsi+rbx]
    cmp al, 10              ; Check if it's the newline character
    je convert_done
    sub al, '0'
    imul rax, rax, 10
    add rax, rax
    add rax, rax
    add rax, rax
    add rax, rdx
    add rax, rax
    add rax, rdx
    inc rbx
    jmp convert_loop
convert_done:

    ; Check if the number is out of range (1 to 9)
    cmp rax, 0
    jle out_of_range_error
    cmp rax, 10
    jg out_of_range_error

    ; Calculate and print Fibonacci sequence
    mov rbx, 0              ; Counter for Fibonacci numbers
    mov rsi, fib_num        ; Address to store Fibonacci numbers
    mov rdx, 0              ; Previous number in the sequence (F(n-1))
    mov rdi, 1              ; Current number in the sequence (F(n))
print_loop:
    mov byte [rsi+rbx], dl  ; Store the Fibonacci number in the buffer
    add dl, dil             ; Calculate the next Fibonacci number
    mov al, dl
    mov byte [rsi+rbx+1], al; Store the remainder (if any) in the next buffer byte
    mov dl, al              ; Move the current number to dl for the next iteration
    inc rbx                 ; Increment the counter
    cmp rbx, rax            ; Check if we've generated enough Fibonacci numbers
    jge print_done
    mov rax, rsi            ; Print the current Fibonacci number
    add rax, rbx
    mov rdi, 1
    mov rdx, 1
    mov rbx, 1
    syscall
    mov al, ','
    mov rdi, 1
    mov rdx, 1
    mov rbx, 1
    syscall
    jmp print_loop
print_done:
    ; Exit the program
    mov rax, 60
    xor rdi, rdi
    syscall

out_of_range_error:
    ; Display error message and exit
    mov rax, 4
    mov rdi, 1
    mov rsi, out_of_range
    mov rdx, 56
    syscall

    ; Exit the program
    mov rax, 60
    xor rdi, rdi
    syscall
