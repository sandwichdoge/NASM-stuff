                global _start

                section .text
_start:     ;example pow(2,7)
                mov rax, 2
                mov rdi, 7
                call pow  ;pow(rax, rdi)
                mov rdi, rax  ;print result
                call printn
                call _exit

pow:
                mov r10, rax  ;1st power
                mov rsi, rax  ;store rax in rsi
_loopx:     mov rax, rsi
                mul rsi  ;rsi *= rsi
                mov rsi, rax
                mov rax, rdi  ;divide rdi by 2
                xor rdx, rdx
                mov rcx, 2
                div rcx
                mov rdi, rax  ;update rdi after division

                mov rax, rsi  ;multiply ret by remainder
                cmp rdx, 0
                je _zrem
                mul r10
_zrem:     mov rsi, rax  ;update rsi
                cmp rdi, 1
                jg _loopx
                mov rax, rsi  ;return value
                ret

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
                push rcx  ;must save rcx as well, since syscall uses rcx
                mov byte dil, al
                call printd
                pop rcx
                pop rsi
                
                xor rdx, rdx  ;floating point exception if rdx is not cleared
                mov rax, rsi  ;divide rsi by 10
                mov r8, 10
                div r8
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