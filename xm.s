section .data
    hello db 'Hello, World!', 0

section .text
    global _start

_start:
    ; Write the message to stdout (file descriptor 1)
    mov eax, 4          ; syscall number for sys_write
    mov ebx, 1          ; file descriptor 1 (stdout)
    mov ecx, hello      ; address of the message
    mov edx, 13         ; message length
    int 0x80            ; invoke the kernel

    ; Exit the program (sys_exit)
    mov eax, 1          ; syscall number for sys_exit
    xor ebx, ebx        ; exit code 0
    int 0x80            ; invoke the kernel
