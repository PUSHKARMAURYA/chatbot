segment .data
n dq 3

segment .text
        global main
main:

    mov rax,0
    cmp [n],0
    je done
    
    mov rax,1
    mov rbx,0
    sub [n],1
    cmp [n],0
    je done 

lop: 
    mov rcx,rax
    add rax,rbx
    mov rbx,rcx
    sub [n],1
    cmp [n],0
    jne lop
    
done:    
    mov rax,60
    xor rdi,rdi
    syscall
