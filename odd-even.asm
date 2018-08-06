;nasm -felf64 odd-even.asm && ld odd-even.o && ./a.out
                global _start
                global _exit

                section .text
_start:
                ;read from stdin
                xor rax, rax
                xor rdi, rdi
                lea rsi, [rsp - 12]  ;write on top of stack
                mov rdx, 12
                syscall
                lea rbx, [rsp - 12]
                mov rcx, 0 ;counter
_loop1:    mov byte sil, [rbx + rcx]
                inc rcx
                cmp sil, 0
                jne _loop1
                sub rcx, 3 ;addr of least significant byte
                
                mov byte dil, [rbx + rcx] ;dil now contains lsb
                sub dil, 48 ;parse lsb
                test dil, 1 ;test lsbit odd or even
                jz _even
_odd:       call printOdd
                call _endif1
_even:      call printEven
_endif1:   call _exit

printOdd:
                mov rax, 1 ;write
                mov rdi, 1 ;stdout
                mov rsi, mOdd ;read from top of stack
                mov rdx, 5
                syscall
                ret

printEven:
                mov rax, 1 ;write
                mov rdi, 1 ;stdout
                mov rsi, mEven ;read from top of stack
                mov rdx, 6
                syscall
                ret

_exit:       mov rax, 60  ;exit program call
                xor rdi, rdi  ;return code 0
                syscall
                ret

                section .data
mOdd:      db "Odd", 10, 0
mEven:     db "Even", 10, 0