section .data
    integer dd 12345    ; Integer to convert to ASCII string
    buffer db 12        ; Buffer to store the ASCII string (large enough to hold the largest possible integer)

section .text
    global _start

_start:
    ; Convert integer to ASCII and store it in the buffer
    mov eax, integer
    lea edi, [buffer + 11]   ; Point EDI to the last position of the buffer
    mov byte [edi], 0       ; Null-terminate the string

convert_loop:
    mov edx, 0          ; Clear EDX before the division
    mov ebx, 10         ; Divisor for base 10
    div ebx             ; Divide EAX by 10, quotient in EAX, remainder in EDX
    add dl, '0'         ; Convert the remainder to ASCII
    dec edi             ; Move EDI backward in the buffer
    mov [edi], dl       ; Store the digit in the buffer

    test eax, eax       ; Check if quotient is zero
    jnz convert_loop    ; If not zero, continue the loop

    ; EDI now points to the first character of the converted ASCII string
    ; You can use EDI and the length (12 - EDI) to work with the ASCII string

    ; Exit the program
    mov eax, 1
    xor ebx, ebx
    int 0x80
