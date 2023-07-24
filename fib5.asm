section .data
    input_string db 'Hello, World!', 0   ; Input string terminated with null (0) character
    ascii_values db 256                 ; Array to store ASCII values, assuming maximum 256 characters
    output_string db 'ASCII values of the input string: ', 0  ; Output string to display the result
    newline db 10, 0                     ; Newline character (ASCII 10) for formatting

section .bss
    index resb 1                        ; Variable to keep track of the index in the input string

section .text
    global _start

_start:
    ; Initialize index to 0
    mov byte [index], 0

convert_loop:
    ; Load the character at the current index
    mov al, byte [input_string + ebx]

    ; Check if it's the null terminator (end of the string)
    cmp al, 0
    je end_of_string

    ; Store the ASCII value in the corresponding array position
    mov byte [ascii_values + ebx], al

    ; Increment the index
    inc byte [index]

    ; Move to the next character in the string
    inc ebx

    ; Continue the loop
    jmp convert_loop

end_of_string:
    ; Display the input string
    mov eax, 4                  ; syscall number for sys_write (output to console)
    mov ebx, 1                  ; file descriptor 1 (stdout)
    mov ecx, input_string       ; pointer to the input string
    call print_string

    ; Newline for formatting
    mov eax, 4                  ; syscall number for sys_write (output to console)
    mov ebx, 1                  ; file descriptor 1 (stdout)
    mov ecx, newline            ; pointer to the newline string
    call print_string

    ; Display the output string
    mov eax, 4                  ; syscall number for sys_write (output to console)
    mov ebx, 1                  ; file descriptor 1 (stdout)
    mov ecx, output_string      ; pointer to the output string
    call print_string

    ; Display the ASCII values of the input string
    mov ecx, 0                  ; Start with index 0 for ASCII values array
print_ascii_values_loop:
    mov al, byte [ascii_values + ecx]
    cmp al, 0                   ; Check if it's the null terminator (end of the ASCII values)
    je end_of_program

    ; Convert ASCII value to a printable character (add 48)
    add al, 48
    mov [ascii_values + ecx], al

    ; Display the ASCII value
    mov eax, 4                  ; syscall number for sys_write (output to console)
    mov ebx, 1                  ; file descriptor 1 (stdout)
    mov edx, 1                  ; length of the output (1 byte)
    int 0x80

    ; Move to the next ASCII value
    inc ecx
    jmp print_ascii_values_loop

end_of_program:
    ; Newline for formatting
    mov eax, 4                  ; syscall number for sys_write (output to console)
    mov ebx, 1                  ; file descriptor 1 (stdout)
    mov ecx, newline            ; pointer to the newline string
    call print_string

    ; Exit the program
    mov eax, 1                  ; syscall number for exit
    xor ebx, ebx                ; status code 0
    int 0x80

print_string:
    ; Function to print the null-terminated string
    ; Parameters: ECX - pointer to the string
    ; Note: This function clobbers the ECX register

    next_char:
        mov al, byte [ecx]      ; Load the next character
        cmp al, 0               ; Check if it's the null terminator
        je end_printing         ; If null terminator, end the printing

        ; Print the character
        mov [esp - 4], eax      ; Save EAX on the stack (to avoid clobbering by INT 0x80)
        mov eax, 4              ; syscall number for sys_write
        mov ebx, 1              ; file descriptor 1 (stdout)
        mov edx, 1              ; number of bytes to write (1 character)
        sub esp, 4              ; align the stack (before INT 0x80)
        int 0x80                ; invoke syscall
        add esp, 4              ; restore the stack pointer

        inc ecx                 ; Move to the next character
        jmp next_char           ; Continue printing characters

    end_printing:
        ret

