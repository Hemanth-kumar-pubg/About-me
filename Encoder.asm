.model tiny
.data

buff db 100 dup(?)
count db ?
inp1 db 100 dup(?)

m db ?
m1 db 0
m2 db 0

tempm db ?
tempm1 db ?
tempm2 db ?

output1 db 100 dup('$')

notbinary db 'The entered number is not binary', 0ah, '$'
text1 db 'Enter the message: $'
text2 db 'The convoluted code: $'

.code
.startup

lea di, buff

lea dx, text1
mov ah, 09h
int 21h

inputl1:

	 mov ah, 08h
	 int 21h

	 cmp al, 0dh
	 je exitinputloopl1
	 cmp al, '0'
	 jb retype
	 cmp al, '1'
	 ja retype
	 
	 
	 mov ah, 02h
	 mov dl, al
	 int 21h
	 
	 sub al, 30h

	 mov [di], al
	 
	 inc di
	 inc byte ptr count
	 
	 jmp inputl1
	 
	 retype:
		 
		 mov ah, 02h
		 mov dl, '*'
		 int 21h
		 
		 jmp inputl1

exitinputloopl1:

lea di, buff
lea si, output1

mov al, [di]

mov m, al

mov al, m
mov tempm, al
mov al, m1
mov tempm1, al
mov al, m2
mov tempm2, al

mov cl, count
mov ch, 0

encoding1:
	 
	 mov al, tempm
	 mov ah, tempm1
	 
	 xor al, ah   ;tempm xor tempm2 => x1
	 mov [si], al ;x1 => output1
	 
	 inc si
	 
	 mov al, tempm
	 mov ah, tempm1
	 
	 xor al, ah ;tempm xor tempm1 xor tempm2 => x2
	 
	 mov ah, tempm2
	 
	 xor al, ah
	 
	 mov [si], al  ;x2 => output1
	 
	 inc si
	 inc di
	 
	 mov al, m1
	 
	 mov m2, al
	 
	 mov al, m
	 
	 mov m1, al
	 
	 mov al, [di]
	 
	 mov m, al
	 
	 mov al, m
	 mov tempm, al
	 mov al, m1
	 mov tempm1, al
	 mov al, m2
	 mov tempm2, al
	 
	 loop encoding1
	 
lea si, output1

mov al, count
mov ah, 0
mov cx, 2

mul cl

mov cx, ax

inthextoascii:

	 mov al, [si]
	 add al, 30h
	 mov [si], al
	 
	 inc si
	 
	 loop inthextoascii

mov ah, 02h
mov dl, 0ah
int 21h

lea dx, text2
mov ah, 09h
int 21h

lea dx, output1
mov ah, 09h
int 21h

.exit
end