;nasm -felf64 scan-val.asm && ld scan-val.o && ./a.out
                global _start
                global _exit

                section .text
_start:
                ;read from stdin
                xor rax, rax
                xor rdi, rdi
                lea rsi, [rsp - 8]  ;write on top of stack
                mov rdx, 12
                syscall

                ;print to stdout
                mov rax, 1 ;write
                mov rdi, 1 ;stdout
                lea rsi, [rsp -8] ;read from top of stack
                mov rdx, 12
                syscall

                call _exit

_exit:       mov rax, 60  ;exit program call
                xor rdi, rdi  ;return code 0
                syscall
                ret