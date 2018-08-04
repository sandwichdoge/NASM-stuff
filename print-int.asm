;nasm -felf64 print-int.asm && gcc -no-pie print-int.o && ./a.out
;nasm -felf64 print-int.asm && ld print-int.o && ./a.out
;write signed integer to stdout

                global _start
                global printd

                section .text
_start:                
                mov rdi, -4247775  ;example
                call printn

                call _exit


printn:     ;print a signed number
                mov rcx, rdi  ;rdi is 1st arg
                mov rsi, 1000000000  ;should be 1bil
                cmp rcx, 0
                jge _loop1
                neg rcx
                push rcx
                push rsi
                mov rax, 1  ;print negative sign
                mov rdi, 1
                mov rsi, signneg
                mov rdx, 1
                syscall
                pop rsi
                pop rcx
_loop1:    
                xor rdx, rdx
                mov rax, rcx
                idiv rsi
                mov rcx, rdx

                ;print digit out to screen
                push rsi
                push rcx  ;must save rcx as well, since syscall uses rcx
                mov byte dil, al
                call printd
                pop rcx
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
                cmp dil, 0
                jge _ud
                push rdi
                mov rax, 1  ;print negative sign
                mov rdi, 1
                mov rsi, signneg
                mov rdx, 1
                syscall
                pop rdi
                neg dil
                add dil, 48
                jmp _pd
_ud:         add dil, 48  ;non negative digit
_pd:         mov byte [rsp-4], dil
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


                section .data
signneg: db "-"
