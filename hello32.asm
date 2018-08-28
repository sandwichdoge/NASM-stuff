;nasm -felf hello32.asm && ld -m elf_i386 hello32.o && ./a.out
global _start
section .text
_exit:
mov al, 1           ;exit code for 32bit linux
xor ebx, ebx      ;return code 0
int 80h
ret

_start: 
mov eax, 4           ; the system interprets 4 as "write" in 32bit mode IDT
mov ebx, 1           ; standard output (print to terminal)
mov ecx, msg    ; pointer to the value being passed
mov edx, [len]           ; length of output (in bytes)
int 0x80             ; call the kernel
call _exit

 section .data
 msg: db "Hello, World!", 0
 len: dd $-msg      ;current line - msg pos