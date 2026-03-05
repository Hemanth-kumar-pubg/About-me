.model tiny
.data

str1 db 'Use only a b c d e f g letters of the keyboard$'
str2 db 'Press q to exit $'

count dw 4
count1 dw 4
count2 dw 4
count3 dw 4
count4 dw 4

.code
.startup

lea dx, str1
mov ah, 09h
int 21h

mov dl, 0ah
mov ah, 02h
int 21h

lea dx, str2
mov ah, 09h
int 21h

in al, 61h
or al, 03h
out 61h, al

mov al, 0

tune:

	mov ah, 08h
	int 21h
	
	cmp al, 'q'
	je exit1
	
	cmp al, 'g'
	jg tune
	cmp al, 'a'
	jl tune
	
	call playtune
	call stoptunetemp
	
	jmp tune

exit1:

in al,61h
and al, 0fch
out 61h, al

.exit

stoptunetemp:
	
	in al,61h
	and al, 0fch
	out 61h, al
	
	mov al, 0
	
	in al, 61h
	or al, 03h
	out 61h, al
	
	call null
	
	mov al, 00h
	
	ret

playtune:
	
	cmp al, 'a'
	je playa
	cmp al, 'b'
	je playb
	cmp al, 'c'
	je playc
	cmp al, 'd'
	je playd
	cmp al, 'e'
	je playe
	cmp al, 'f'
	je playf
	cmp al, 'g'
	je playg
	
playa:
		
	call play_A4
	call delaysmall
		
	jmp exitplaytune
	
playb:
		
	call play_B4
	call delaysmall
		
	jmp exitplaytune
		
playc:
		
	call play_C
	call delaysmall
		
	jmp exitplaytune
	
playd:
		
	call play_D
	call delaysmall
		
	jmp exitplaytune
	
playe:
		
	call play_E
	call delaysmall
		
	jmp exitplaytune
	
playf:
		
	call play_F
	call delaysmall
		
	jmp exitplaytune
	
playg:
		
	call play_G
	call delaysmall
		
	jmp exitplaytune
	
exitplaytune:
	
	ret

play_C:
    mov bx, 1193180 / 523
    call set_frequency
    ret

play_D:
    mov bx, 1193180 / 587
    call set_frequency
    ret

play_E:
    mov bx, 1193180 / 659
    call set_frequency
    ret

play_F:
    mov bx, 1193180 / 698
    call set_frequency
    ret

play_G:
    mov bx, 1193180 / 784
    call set_frequency
    ret

play_A:
    mov bx, 1193180 / 880
    call set_frequency
    ret

play_B:
    mov bx, 1193180 / 988
    call set_frequency
    ret

play_C4:
    mov bx, 1193180 / 261
    call set_frequency
    ret

play_D4:
    mov bx, 1193180 / 293
    call set_frequency
    ret

play_E4:
    mov bx, 1193180 / 329
    call set_frequency
    ret

play_F4:
    mov bx, 1193180 / 349
    call set_frequency
    ret

play_G4:
    mov bx, 1193180 / 392
    call set_frequency
    ret

play_A4:
    mov bx, 1193180 / 440
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

set_frequency:
    mov al, 0B6h
    out 43h, al

    mov ax, bx
    out 42h, al
    mov al, ah
    out 42h, al
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

call delay

in al, 61h
or al, 03h
out 61h, al

ret

end