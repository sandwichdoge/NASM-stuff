;nasm -felf64 print-uint.asm && gcc -no-pie print-uint.o && ./a.out
;nasm -felf64 print-uint.asm && ld print-uint.o && ./a.out
;write unsigned integer to stdout

                global _start
                global printd

                section .text
_start:                
                mov rdi, 54247775  ;example
                call printn
                call _exit


printn:     ;print an unsigned number 
                mov rcx, rdi  ;rdi is 1st arg
                mov rsi, 1000000000  ;should be 1bil
_loop1:    
                xor rdx, rdx
                mov rax, rcx
                div rsi
                mov rcx, rdx

                ;print digit out to screen
                push rsi
                push rdx
                push rcx  ;must save rcx as well, since syscall uses rcx
                mov byte dil, al
                call printd
                pop rcx
                pop rdx
                pop rsi
                
                xor rdx, rdx  ;floating point exception if rdx is not cleared
                mov rax, rsi  ;divide rsi by 10
                mov r8, 10
                idiv r8
                mov rsi, rax  ;rsi has been divided by 10, no remainder

                cmp rsi, 0
                jne _loop1

                ret

printd:     ;uses rdi, rsi, rax, rdx
                add dil, 48
                mov byte [rsp-4], dil
                mov rax, 1
                mov rdi, 1
                lea rsi, [rsp-4]
                mov rdx, 1
                syscall
                ret


_exit:       mov rax, 60  ;exit program call
                xor rdi, rdi  ;return code 0
                syscall
                ret                
