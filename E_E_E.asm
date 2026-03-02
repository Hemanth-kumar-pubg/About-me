.model tiny
.386
.data

n db 7
p dq 0.4, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1
l dq 2.0, 3.0, 3.0, 3.0, 3.0, 3.0, 3.0

entropy dq ?
expected dq ?
Efficiency dq ?

.code
.startup

finit

mov cl, n
mov si, 0

entrp1:

    fld qword ptr p[si]
    fld st(0)

    fyl2x
    fchs

    fld entropy
    fadd
    fstp entropy

    add si, 8
    loop entrp1

mov cl, n
mov si, 0
mov di, 0

expl:

    fld qword ptr p[si]
    fld qword ptr l[di]
    fmul

    fld expected
    fadd
    fstp expected

    add si, 8
    add di, 8

loop expl

fld expected
fld entropy
fdivr
fstp efficiency

.exit
end