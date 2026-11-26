.data
  c: .space 32
.text
  a: .word 4,2,5,8,6,3,7,1
  b: .word 9,5,2,3,7,8,4,6
//.global _main
_main:
  STP X29, X30, [SP, -32]!
  STP X19, X20, [SP, 16]      // save callee-saved registers
  MOV X29, SP

  BL _Add_ASM_
  ADRP X19, c@PAGE
  ADD  X19, X19, c@PAGEOFF
  MOV  X27, 32 //array length
  BL _print

  BL _Shift_ASM_
  BL _print

  BL _Mult_ASM_
  BL _print

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

.global _Shift_ASM_
  s: .word 3,6,2,4,2,3,1,5
_Shift_ASM_:
    ADR  X9, a
    ADR  X10, s
    ADRP X11, c@PAGE
    ADD  X11, X11, c@PAGEOFF
    MOV  X12, 0

  shift_loop:
    LDR W3, [X9, X12]
    LDR W4, [X10, X12]
    LSL W2, W3, W4
    STR W2, [X11, X12]
    ADD X12, X12, 4
    CMP X12, 32
    B.LT shift_loop
  RET

.global _Mult_ASM_
_Mult_ASM_:
    ADR  X9, a
    ADR  X10, b
    ADRP X11, c@PAGE
    ADD  X11, X11, c@PAGEOFF
    MOV  X12, 0

  mult_loop:
    LDR W3, [X9, X12]
    LDR W4, [X10, X12]
    MUL W2, W3, W4
    STR W2, [X11, X12]
    ADD X12, X12, 4
    CMP X12, 32
    B.LT mult_loop
  RET