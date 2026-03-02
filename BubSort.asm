.model tiny
.386
.stack 100h

.data

n db 6

prob dq 0.45, 0.07, 0.03, 0.30, 0.05, 0.10

temp dq ?

.code
.startup

    finit

    mov cl, n
    dec cl

outer_loop:

    mov si, 0

    mov ch, n
    dec ch


inner_loop:

    mov bx, si
    shl bx, 3

    fld qword ptr prob[bx]

    add bx, 8
    fld qword ptr prob[bx]

    fcompp

    fstsw ax
    sahf

    jae no_swap

    mov bx, si
    shl bx, 3

    fld qword ptr prob[bx]
    fstp temp

    add bx, 8

    fld qword ptr prob[bx]
    sub bx, 8
    fstp qword ptr prob[bx]

    add bx, 8

    fld temp
    fstp qword ptr prob[bx]


no_swap:

    inc si
    dec ch
    jnz inner_loop


    dec cl
    jnz outer_loop


.exit
end
