.text
.align 4
//Prints X2
.global _itoa
_itoa:
    SUB SP, SP, 32
    ADD X6, SP, 30
    MOV X7, 0
    MOV X8, 10

    itoa_loop:
        UDIV X9, X2, X8
        MSUB X10, X9, X8, X2
        ADD W10, W10, '0'
        STRB W10, [X6]
        SUB X6, X6, 1
        ADD X7, X7, 1
        MOV X2, X9
        CBNZ X2, itoa_loop

        ADD X6, X6, 1       //append
        MOV W11, 0x20       //w5=' '
        STRB W11, [X6, X7] //append newline to string
        ADD X7, X7, 1    //append

    print_res:
        MOV X1, X6
        MOV X0, 1
        MOV X2, X7
        MOV X16, 4
        SVC 0x80

    return:
        ADD SP, SP, 32
        RET
    
.global _newline
_newline:
    SUB SP,SP,16

    MOV W8,0x0A
    strb W8, [sp]
    MOV X0, 1   //stdout
    MOV X1, SP //point to stack
    MOV X2, 1 //write 1 byte
    MOV X4,16//write
    SVC 0x80

    ADD SP,SP,16
    RET