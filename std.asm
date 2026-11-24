.align 4

.text
  a: .word 4,2,5,8,6,3,7,9
  b: .word 9,5,2,3,7,8,4,6
  c: .word 0,0,0,0,0,0,0,0
.global _Add_ASM_
_Add_ASM_:
    LDR S0,a
    LDR S1,b

    MOV W0,0

  add_loop:
    ADD S3,S0,S1

    CMP W0,7
    ADD W0,W0,1
    B.LT add_loop

    RET
