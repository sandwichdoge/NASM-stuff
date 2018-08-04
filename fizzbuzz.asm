;nasm -felf64 fizzbuzz.asm && ld fizzbuzz.o && ./a.out
            global _start
            global print_fizz
            global print_buzz

section .text
_start:
                mov rbx, 1  ;index 
 _loop:     xor r9, r9  ;fizz flag
                xor rdx, rdx  ;clear remainder reg
                mov r12, 3  ;divisor
                mov rax, rbx;move index to dividend
                div r12        ;result in rax, remainder in rdx
                push rbx
                cmp rdx, 0  ;check if remainder is 0
                jne non3   ;if false jmp to non3
                mov r9, 1
                call print_fizz
non3:       xor rdx, rdx  ;
                mov r12, 5
                mov rax, rbx
                div r12
                cmp rdx, 0
                jne non5
                call print_buzz
                jmp lf
non5:       pop rbx
                cmp r9, 0;  fizz not triggered
                jne lf
                mov rdi, rbx
                call printn
lf:             call print_lf
                inc rbx
                cmp rbx, 100
                jne _loop

                call _exit


print_fizz:
                mov rax, 1
                mov rdi, 1
                mov rsi, mfizz
                mov rdx, 5
                syscall
                ret

print_buzz:
                mov rax, 1
                mov rdi, 1
                mov rsi, mbuzz
                mov rdx, 5
                syscall
                ret

print_lf:
                mov rax, 1
                mov rdi, 1
                mov rsi, mlf
                mov rdx, 5
                syscall
                ret

printn:     ;print an unsigned number in rdi
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
section .data
mfizz:      db "fizz", 0
mbuzz:    db "buzz", 0
mlf:         db "", 10