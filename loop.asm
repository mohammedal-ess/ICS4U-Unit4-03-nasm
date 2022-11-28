; --------------------------------------------------------------
; prints 0-9 using a loop.
; Runs on 64-bit x86 Linux only.
; Date: 2022-11-28, Author: mohammed al-essawi
; --------------------------------------------------------------

section .bss
     number: RESD 1

section .data

    ;  constants here
     done: db 10, "Done.", 10      ; Done
     doneLen: equ $-done           ;  length of string
     newLine: db 10

section .text
    global _start                  ; entry point for linker

    _start:                        ; start here
        mov r8, 48

        LoopIncrement:
            ; reassigns some_number to another value
            mov [number], r8
            
            ; prints number
            mov rax, 4                 ; system call for write
            mov rdi, 1                 ; file handle 1 is stdout
            mov rcx, number       ; address of string to output
            mov rdx, 1                 ; number of bytes
            int 0x80                   ; call the kernel

            ; prints a newLine
            mov rax, 1
            mov rdi, 1
            mov rsi, newLine
            mov rdx, 1
            syscall

            inc r8
            cmp r8, 57
            jle LoopIncrement

        ; prints "Done."
        mov rax, 1
        mov rdi, 1
        mov rsi, done
        mov rdx, doneLen
        syscall

        mov rax, 60                ; system call for exit 
        mov rdi, 0                 ; exit code 0 
        syscall                    ; invoke operating system to exit 