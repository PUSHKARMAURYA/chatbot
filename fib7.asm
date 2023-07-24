section .data
    prompt db "Enter the number of Fibonacci terms: ", 0
    output db "Fibonacci Sequence: ", 0
    newline db 10, 0

section .bss
    num resb 2

section .text
    extern printf, scanf

    global main

main:
    ; Display prompt to enter the number of terms
    push prompt
    call printf
    add esp, 4

    ; Read user input
    lea eax, [num]
    push eax
    push number_format
    call scanf
    add esp, 8

    ; Convert ASCII to integer (atoi)
    mov al, byte [num]
    sub al, '0'
    mov bl, byte [num + 1]
    sub bl, '0'
    movzx eax, byte [num] ; Clear upper bits of eax
    imul eax, eax, 10
    add eax, ebx

    ; Calculate and print the Fibonacci sequence
    push eax
    call print_fibonacci
    add esp, 4

    ; Exit the program
    xor eax, eax
    ret

print_fibonacci:
    ; Save registers
    push eax
    push ebx
    push ecx
    push edx

    mov ebx, 0     ; First Fibonacci term
    mov ecx, 1     ; Second Fibonacci term
    mov edx, eax   ; Loop counter (number of terms)
    mov eax, output
    call printf

fibonacci_loop:
    ; Print the current term
    push ecx
    call print_integer
    pop ecx

    ; Print a comma and a space except for the last term
    dec edx
    jz fibonacci_end
    push comma_space_format
    call printf

fibonacci_end:
    ; Print a newline
    push newline
    call printf

    ; Restore registers and return
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret

print_integer:
    ; Convert integer to ASCII and print it
    push eax
    push ebx
    push edx
    push edi

    mov edi, 10 ; divisor
    xor ebx, ebx  ; store the digit count

divide_loop:
    xor edx, edx  ; Clear the high 32 bits of edx
    div edi       ; Divide eax by 10, quotient in eax, remainder in edx
    add dl, '0'   ; Convert the remainder to ASCII
    push edx      ; Save the digit on the stack
    inc ebx       ; Increment the digit count

    test eax, eax ; Check if quotient is zero
    jnz divide_loop

print_loop:
    pop edx       ; Get the digit from the stack
    pusha
    mov eax, 4
    mov ebx, 1
    mov ecx, edx   ; Move the digit to ecx
    mov edx, 1     ; Set the length to 1
    int 0x80
    popa

    dec ebx        ; Decrement the digit count
    jnz print_loop

    pop edi
    pop edx
    pop ebx
    pop eax
    ret

section .data
    number_format db "%d", 0
    comma_space_format db ", ", 0

section .bss
    num resb 2
