;create a file then write its own name in that file.
;nasm -felf64 file-write.asm && ld file-write.o && ./a.out
global _start
section .text
_exit:
mov rax, 60
xor rdi, rdi
syscall

_start:
;create file
mov rax, 2
mov rdi, fname
mov rsi, [O_CREAT]
xor rsi, [O_RDWR]
mov rdx, 0666o ;mode
syscall

;write data
mov rdi, rax      ;file descriptor
mov rdx, 21       ;len
mov rsi, fname  ;data
mov rax, 1         ;syswrite
syscall

;close file
mov rax, 3
syscall

call _exit

section .data
O_CREAT: dd 0x0040
O_RDWR: dd 0x0002
fname: db "/home/z/Work/tes.txt", 0


;    // Invented values to support what package os expects.
;    O_RDONLY   = 0x00000
;    O_WRONLY   = 0x00001
;    O_RDWR     = 0x00002
;    O_CREAT    = 0x00040
;    O_EXCL     = 0x00080
;    O_NOCTTY   = 0x00100
;    O_TRUNC    = 0x00200
;    O_NONBLOCK = 0x00800
;    O_APPEND   = 0x00400
;    O_SYNC     = 0x01000
;    O_ASYNC    = 0x02000
;    O_CLOEXEC  = 0x80000
