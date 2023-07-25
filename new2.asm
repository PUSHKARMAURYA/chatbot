.data
  n: dd 10 ; number of Fibonacci numbers to calculate
  f0: dd 0 ; first Fibonacci number
  f1: dd 1 ; second Fibonacci number

.code
fib:
  mov eax, [n]
  cmp eax, 0
  je done
  cmp eax, 1
  je done

  mov eax, [f0]
  mov ebx, [f1]
  add eax, ebx
  mov [f0], eax
  mov [f1], ebx
  dec eax
  jmp fib

done:
  ret
