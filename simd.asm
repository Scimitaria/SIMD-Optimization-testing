.align 4

.text
  a: .word 4,2,5,8,6,3,7,9
  b: .word 9,5,2,3,7,8,4,6
.global _Add_SIMD_
_Add_SIMD_:
    LDR X0,=a
    LD1 {V0.8b}, [X0]
    LDR X0,=b
    LD1 {V1.8b}, [X0]

    FADD V2.8b,V0.8b,V1.8b

    RET
    
