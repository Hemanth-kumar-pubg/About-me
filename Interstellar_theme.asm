.model tiny
.data

count dw 4
count1 dw 4
count2 dw 4
count3 dw 4
count4 dw 4

.code
.startup

push cs
pop ds

in al, 61h
or al, 03h
out 61h, al

call play_A4
call delay

call play_E
call delay

call play_A4
call delay

call play_E
call delay

call play_A4
call delay

call play_E
call delay

call play_B4
call delay

call play_E
call delay

call play_B4
call delay

call play_E
call delay

call play_B4
call delay

call play_E
call delay

call play_C
call delay

call play_E 
call delay

call play_C
call delay

call play_E 
call delay

call play_D
call delay

call play_E
call delay

call play_D
call delay

call play_E
call delay

tinykeys:
dec count

call play_C
call delaysmall

call play_E4
call delaysmall

mov cx, count

cmp cx, 0
jne tinykeys

tinykeys1:
dec count1

call play_D
call delaysmall

call play_G4
call delaysmall

mov cx, count1

cmp cx, 0
jne tinykeys1

tinykeys2:
dec count2

call play_E
call delaysmall

call play_A4
call delaysmall

mov cx, count2

cmp cx, 0
jne tinykeys2

tinykeys3:
dec count3

call play_B
call delaysmall

call play_E
call delaysmall

mov cx, count3

cmp cx, 0
jne tinykeys3

tinykeys4:
dec count4

call play_G
call delaysmall

call play_B
call delaysmall

mov cx, count4

cmp cx, 0
jne tinykeys4

in al,61h
and al, 0fch
out 61h, al

mov ax, 04c00h
int 21h

.exit
; Constants:
; PIT input clock frequency = 1,193,180 Hz

play_C:
    mov bx, 1193180 / 523     ; Frequency for C4 ~ 261 Hz
    call set_frequency
    ret

play_D:
    mov bx, 1193180 / 587     ; Frequency for D4 ~ 293 Hz
    call set_frequency
    ret

play_E:
    mov bx, 1193180 / 659     ; Frequency for E4 ~ 329 Hz
    call set_frequency
    ret

play_F:
    mov bx, 1193180 / 698     ; Frequency for F4 ~ 349 Hz
    call set_frequency
    ret

play_G:
    mov bx, 1193180 / 784     ; Frequency for G4 ~ 392 Hz
    call set_frequency
    ret

play_A:
    mov bx, 1193180 / 880     ; Frequency for A4 ~ 440 Hz (Concert pitch)
    call set_frequency
    ret

play_B:
    mov bx, 1193180 / 988     ; Frequency for B4 ~ 493 Hz
    call set_frequency
    ret

play_C4:
    mov bx, 1193180 / 261  ; ~4571
    call set_frequency
    ret

play_D4:
    mov bx, 1193180 / 293  ; ~4071
    call set_frequency
    ret

play_E4:
    mov bx, 1193180 / 329  ; ~3625
    call set_frequency
    ret

play_F4:
    mov bx, 1193180 / 349  ; ~3417
    call set_frequency
    ret

play_G4:
    mov bx, 1193180 / 392  ; ~3042
    call set_frequency
    ret

play_A4:
    mov bx, 1193180 / 440  ; ~2711
    call set_frequency
    ret

play_B4:
    mov bx, 1193180 / 494
	call set_frequency
	ret

null:
    mov bx, 0
	call set_frequency
	ret

; --------------------
; Subroutine to set the frequency on PIT Channel 2
; --------------------
set_frequency:
    mov al, 0B6h               ; Control word: Channel 2, LSB/MSB, mode 3 (square wave)
    out 43h, al

    mov ax, bx                 ; Load divisor value into AX
    out 42h, al                ; Send low byte of divisor
    mov al, ah
    out 42h, al                ; Send high byte of divisor
    ret

delay:
mov cx, 3000h
delay_outer:
mov dx, 02Fh
delay_inner:
nop
dec dx
jnz delay_inner
loop delay_outer
ret

delaysmall:
mov cx, 1750h
delay_outer1:
mov dx, 02fh
delay_inner1:
nop
dec dx
jnz delay_inner1
loop delay_outer1
ret

delaylarge:
in al, 61h
and al, 0fch
out 61h, al

call delaysmall

in al, 61h
or al, 03h
out 61h, al

ret

end
