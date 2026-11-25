.data
  c: .space 32
.text
  a: .word 4,2,5,8,6,3,7,9
  b: .word 9,5,2,3,7,8,4,6

//.global _main
_main:
    STP X29, X30, [SP, -32]!
    STP X19, X20, [SP, 16]      // save callee-saved registers
    MOV X29, SP

    BL _Add_ASM_

    ADRP X19, c@PAGE
    ADD  X19, X19, c@PAGEOFF
    MOV  X20, 0 // byte offset

  print_loop:
    LDR W2, [X19, X20]
    BL _itoa
    ADD X20, X20, 4
    CMP X20, 32
    B.LT print_loop

    MOV W0, 0 // exit status
    LDP X19, X20, [SP, 16]
    LDP X29, X30, [SP], 32
    RET

.global _Add_ASM_
_Add_ASM_:
    ADR  X9, a
    ADR  X10, b
    ADRP X11, c@PAGE
    ADD  X11, X11, c@PAGEOFF
    MOV  X12, 0

  add_loop:
    LDR W3, [X9, X12]
    LDR W4, [X10, X12]
    ADD W2, W3, W4
    STR W2, [X11, X12]
    ADD X12, X12, 4
    CMP X12, 32
    B.LT add_loop
    RET