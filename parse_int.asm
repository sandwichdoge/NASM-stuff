;nasm -g -felf64 parse_int.asm && ld parse_int.o print-int.o && ./a.out
                global _start
                extern printn
                section .text
_start:        ;example: print -1234560 to stdout
                mov rdi, sNum
                call _int
                mov rdi, rax
                call printn
                call _exit


_int:         ;parse integer, rax contains return value, rdi contains addr of buffer
                mov rcx, 0 ;rcx: counter
_loop1:    mov byte sil, [rdi + rcx]
                inc rcx
                push rsi ;push bytes in rsi on stack to reverse later
                cmp rsi, 0
                jne _loop1
                dec rcx  ;rcx = string len
                ;push rcx  ;save rcx
                pop rdi  ;rdi=\0
                mov rsi, 1
                xor r8, r8
                mov r10, 10
_loop2:     ;rdi contains char, rax=temp, rcx=counter, rsi=factorOf10, r8=result
                pop rdi
                cmp rdi, 45
                je _neg
                sub rdi, 48
                mov rax, rdi ; rax = rdi * rsi
                mul rsi ;
                add r8, rax ; //
                mov rax, rsi ; rsi *= 10
                mul r10
                mov rsi, rax ; //
                dec rcx
                jnz _loop2
                jmp _ret
_neg:       neg r8
_ret:       
                mov rax, r8
                ret

_exit:
                mov rax, 60
                xor rdi, rdi
                syscall

_msg:
                mov rax, 1
                mov rdi, 1
                mov rsi, sNum
                mov rdx, 4
                syscall
                ret

                section .data
sNum:      db "-1234560", 0