section .data
    num1 db 10        ; First number (change the value as needed)
    num2 db 20        ; Second number (change the value as needed)
    result db 0       ; Variable to store the sum, initialized to 0

section .text
    global _start     ; Entry point for the program

_start:
    ; Load the values of num1 and num2 into registers
    mov al, [num1]    ; Move the value of num1 into the AL register
    mov bl, [num2]    ; Move the value of num2 into the BL register

    ; Add the two numbers
    add al, bl        ; Add the values in AL and BL registers

    ; Store the result in the 'result' variable
    mov [result], al  ; Move the value in AL into the 'result' variable

    ; Terminate the program
    mov eax, 1        ; syscall number for 'exit'
    xor ebx, ebx      ; exit code 0
    int 0x80          ; Call the kernel to exit the program
