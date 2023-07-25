section .data
    buffer db 10          ; Buffer to store the ASCII string
    max_digits equ 10     ; Maximum number of digits supported (adjust as needed)
    newline db 0x0A       ; Newline character for printing

section .bss
    num resd 1            ; Input integer (reserved space)

section .text
    global _start

_start:
    ; Get input integer from the user
    mov eax, 4            ; System call number for sys_write
    mov ebx, 1            ; File descriptor 1 (stdout)
    mov ecx, input_msg    ; Message to prompt for input
    mov edx, input_msg_len; Message length
    int 0x80              ; Execute the system call

    ; Read the integer from the user
    mov eax, 3            ; System call number for sys_read
    mov ebx, 0            ; File descriptor 0 (stdin)
    mov ecx, num          ; Address to store the integer
    mov edx, 4            ; Number of bytes to read
    int 0x80              ; Execute the system call

    ; Convert the integer to ASCII
    mov eax, [num]        ; Load the input integer into eax
    mov edi, buffer + max_digits - 1 ; Start of buffer (from the end)

convert_loop:
    xor edx, edx         ; Clear edx to prepare for division
    mov ecx, 10          ; Divide by 10 (decimal)
    div ecx              ; Divide eax by 10, result in eax, remainder in edx
    add dl, '0'          ; Convert the remainder (0-9) to ASCII
    dec edi              ; Move edi to the previous character in buffer
    mov [edi], dl        ; Store the ASCII character in the buffer

    test eax, eax        ; Check if quotient is zero
    jnz convert_loop     ; If not zero, continue the loop

    ; Print the ASCII string
    mov
