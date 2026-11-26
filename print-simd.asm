.global _main
.align 4

.section __TEXT,__cstring,cstring_literals
fmt:
    .asciz "v2.8b: [%3d, %3d, %3d, %3d, %3d, %3d, %3d, %3d]\n"
.text
.global _print_V8b
_print_V8b:
    // Save frame pointer and link register (16-byte aligned)
    stp     x28, x30, [sp, #-16]!
    mov     x28, sp

    // ---------------------------------------------------------
    // Print v2.8b using printf
    // ---------------------------------------------------------
    // 1. Allocate 80 bytes on the stack (must be a multiple of 16):
    //    - [sp, #0..63]  : 8 variadic args * 8 bytes each = 64 bytes
    //    - [sp, #64..71] : temporary buffer to store d2
    sub     sp, sp, #80

    // 2. Store the 8-byte vector (d2 / v2.8b) to our temp buffer
    str     d2, [sp, #64]

    // 3. Load each byte and store it as an 8-byte slot for printf's variadic args
    ldrb    w1, [sp, #64]
    str     x1, [sp, #0]
    ldrb    w1, [sp, #65]
    str     x1, [sp, #8]
    ldrb    w1, [sp, #66]
    str     x1, [sp, #16]
    ldrb    w1, [sp, #67]
    str     x1, [sp, #24]
    ldrb    w1, [sp, #68]
    str     x1, [sp, #32]
    ldrb    w1, [sp, #69]
    str     x1, [sp, #40]
    ldrb    w1, [sp, #70]
    str     x1, [sp, #48]
    ldrb    w1, [sp, #71]
    str     x1, [sp, #56]

    // 4. Load format string into x0 and call _printf
    adrp    x0, fmt@PAGE
    add     x0, x0, fmt@PAGEOFF
    bl      _printf

    // 5. Restore stack pointer
    add     sp, sp, #80

    // Exit cleanly
    mov     w0, #0
    ldp     x28, x30, [sp], #16
    ret
