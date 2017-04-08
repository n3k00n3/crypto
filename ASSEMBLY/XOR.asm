;----------------------------------------
;   
; :: XOR ENCRYPT ::
; usage: ./xor <message> <key>
;
;---------------------------------------


[BITS 64]

section .data
    usageMessage: db  'usage: ./xor <message> <key>', 0x0a, 0x00
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
    jg  usage
    
    mov rdi, [rsi+0x08]       ;Second Pointer
    mov rsi, [rsi+0x10]       ;Third Pointer
    call stringLen
    call xor
    
    jmp exit
    
    xor:
        push rbp
        mov rbp, rsp
        
        xor rax, rax

        .xorCipher:
            mov dl, byte [rdi+rax]
            xor byte[rsi + rax], dl
            inc rax
            cmp rax, rcx
            je .printMessage
            jmp .xorCipher

        .printMessage:
            mov rax, 0x01
            mov rdi, 0x01
            mov rdx, rcx
            syscall

        mov rsp, rbp
        pop rbp
        ret
    
    stringLen:
        push rbp
        mov rbp, rsp
        xor rcx, rcx
        
        .nextchar:
            cmp byte[rdi+rcx * 1], 0x00
            je  .exitStrlen
            inc rcx
            jmp .nextchar

        .exitStrlen:
            mov rsp, rbp
            pop rbp
            ret

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

