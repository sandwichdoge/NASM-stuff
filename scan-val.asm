;nasm -felf64 scan-val.asm && ld scan-val.o && ./a.out
                global _start
                global _exit

                section .text
_start:
                ;read from stdin
                xor rax, rax
                xor rdi, rdi
                lea rsi, [rsp - 64]  ;write on top of stack, 64bytes buffer
                mov rdx, 64
                syscall

                ;print to stdout
                mov rax, 1 ;write
                mov rdi, 1 ;stdout
                lea rsi, [rsp - 64] ;read from top of stack
                mov rdx, 64
                syscall

                call _exit

_exit:       mov rax, 60  ;exit program call
                xor rdi, rdi  ;return code 0
                syscall
                ret
