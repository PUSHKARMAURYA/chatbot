section .data
    num dd 10   ; Predefined number of Fibonacci terms

section .text
    global _start

_start:
    ; Calculate and print the Fibonacci sequence
    mov ebx, 0      ; First Fibonacci term (F0) = 0
    mov ecx, 1      ; Second Fibonacci term (F1) = 1

fibonacci_loop:
    ; Print the current term (F0, F1, F2, ...)
    push ecx
    call print_integer
    pop ecx

    ; Calculate the next Fibonacci term (F2, F3, F4, ...)
    add ebx, ecx    ; F2 = F0 + F1
    xchg ebx, ecx   ; F0 = F1, F1 = F2

    ; Decrement the number of terms (num--)
    dec dword [num]

    ; Loop until num becomes 0
    jnz fibonacci_loop

    ; Exit the program
    mov eax, 1
    xor ebx, ebx
    int 0x80

print_integer:
    ; Convert integer to ASCII and print it
    mov edi, 10      ; divisor
    xor ebx, ebx     ; store the digit count

divide_loop:
    xor edx, edx     ; Clear the high 32 bits of edx
    div edi          ; Divide eax by 10, quotient in eax, remainder in edx
    add dl, '0'      ; Convert the remainder to ASCII
    push edx         ; Save the digit on the stack
    inc ebx          ; Increment the digit count

    test eax, eax    ; Check if quotient is zero
    jnz divide_loop

print_loop:
    pop edx          ; Get the digit from the stack
    mov eax, 4
    mov ebx, 1
    mov ecx, edx     ; Move the digit to ecx
    mov edx, 1       ; Set the length to 1
    int 0x80

    dec ebx          ; Decrement the digit count
    jnz print_loop

    ret
