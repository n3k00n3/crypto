;----------------------------------------
;   
; :: XOR ENCRYPT ::
; usage: ./xor <message> <key>
;
;---------------------------------------


[BITS 64]

section .data
    usageMessage: db  'usage: ./xor <message> <key>, 0x0a, 0x00
    lenMessage: equ $-usageMessage

section .text
    global main
    global xor

    main:
    push rbp
    mov rbp, rsp
    sub rsp, 0x20
    
    mov [rbp-0x04], edi       ;ARGC
    mov [rbp-0x10], rsi       ;ARGV
    cmp edi, 0x03             ;ARGC == 3?
    jl  usage

    usage:
        mov rax, 0x01
        mov rdi, 0x01
        mov rsi, usageMessage
        mov rdx, lenMessage
        syscall

    exit:
        mov rsp, rbp
        pop rbp
        ret

