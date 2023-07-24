section .data
    input_string db 'Hello, World!', 0   ; Input string terminated with null (0) character
    ascii_values db 256                 ; Array to store ASCII values, assuming maximum 256 characters

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
    ; End of string conversion
    ; (You can put any further processing or display the ASCII values if desired)

    ; Exit the program
    mov eax, 1                  ; syscall number for exit
    xor ebx, ebx                ; status code 0
    int 0x80
