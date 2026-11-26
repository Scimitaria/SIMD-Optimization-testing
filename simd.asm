.align 4

.text
//.global _main
_main:
  STP X29, X30, [SP, -32]!
  MOV X29, SP

  BL _Add_SIMD_
  BL _print_V8b

  BL _Shift_SIMD_
  BL _print_V8b

  BL _Mult_SIMD_
  BL _print_V8b

  MOV W0,0
  LDP X29, X30, [SP], 32
  RET

.global _Add_SIMD_
  a: .byte 4,2,5,8,6,3,7,1
  b: .byte 9,5,2,3,7,8,4,6
_Add_SIMD_:
    ADR X0,a
    LD1 {V0.8b}, [X0]
    ADR X0,b
    LD1 {V1.8b}, [X0]

    ADD V2.8b,V0.8b,V1.8b

    RET

.global _Shift_SIMD_
  s: .byte 3,6,2,4,2,3,1,5
_Shift_SIMD_:
    ADR X0,a
    LD1 {V0.8b}, [X0]
    ADR X0,s
    LD1 {V1.8b}, [X0]

    USHL V2.8b,V0.8b,V1.8b

    RET

.global _Mult_SIMD_
_Mult_SIMD_:
    ADR X0,a
    LD1 {V0.8b}, [X0]
    ADR X0,b
    LD1 {V1.8b}, [X0]

    MUL V2.8b,V0.8b,V1.8b

    RET
