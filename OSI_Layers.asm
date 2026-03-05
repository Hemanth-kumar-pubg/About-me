.model tiny
.data

fn db 'packet1.txt', 0
handle dw ?

message1 db 'Message received: $'

layer db 'Layer 7- current packet: $'

null db 50 dup(0)
buffer db 50 dup('$')

count dw ?

currentstr db 50 dup('$')

OSI db '[APP]', '[PRES]', '[SESS]', '[TCP]', '[IP]', '[ETH]', '[FCS]'
leninc db 0,5,11,17,22,26,31,36
leng db 5,6,6,5,4,5,5

max1 db 10
num1 db ?
inp1 db 11 dup('$')

.code
.startup

lea dx, fn
mov ah, 3ch
mov cl, 01h
int 21h
mov handle, ax

lea dx, max1
mov ah, 0ah
int 21h

mov bx, handle
lea dx, inp1
mov cl, num1
mov ch, 0
mov ah, 40h
int 21h

mov si, 0
mov di, 0

mov cl, num1
mov ch, 0
mov count, cx
mov cl, leng[di]
mov ch, 0

mov cx, 6

apppre:
	 
	 push cx
	 
	 mov ah, 42h
	 mov al, 0
	 mov cx, 0
	 mov dx, 0
	 int 21h ;start of the file
	 
	 mov ah, 3fh
	 lea dx, buffer
	 mov cx, count
	 int 21h ;read the message using num1
	 
	 call clearfile
	 
	 mov ah, 42h
	 mov al, 0
	 mov cx, 0
	 mov dx, 0
	 int 21h
	 
	 lea dx, OSI
	 call dxinc
	 mov ah, 40h
	 mov cl, leng[di]
	 mov ch, 0
	 int 21h
	 
	 mov ah, 42h
	 mov al, 0
	 mov cx, 0
	 mov dl, leng[di]
	 mov dh, 0
	 int 21h
	 
	 lea dx, buffer
	 mov ah, 40h
	 mov cx, count
	 int 21h
	 
	 call countinc
	 
	 call strprint
	 
	 inc si
	 inc di
	 
	 pop cx
	 loop apppre

mov ah, 42h
mov al, 2
mov cx, 0
mov dx, 0
int 21h

lea dx, OSI
add dx, 31
mov cx, 5
mov ah, 40h
int 21h

mov cx, count
add cx, 5
mov count, cx

call strprint

mov ah, 3eh
int 21h

.exit

	 countinc:
		 
		 mov cl, leng[di]
		 mov ch, 0
		 mov ax, count
		 add ax, cx
		 mov count, ax ;how many characters in the file
		 
		 ret
	 
	 clearfile:
		 
		 mov bx, handle
		 mov ah, 42h
		 mov al, 0
		 mov cx, 0
		 mov dx, 0
		 int 21h
		 
		 lea dx, null
		 mov cx, count
		 mov ah, 40h
		 int 21h
		 
		 ret
	 
	 dxinc:
		 
		 mov cl, leninc[si]
		 mov ch, 0
		 add dx, cx
		 
		 ret
	 
	 strprint:
		 
		 
		 mov ah, 42h
		 mov al, 0
		 mov cx, 0
		 mov dx, 0
		 int 21h
		 
		 lea dx, currentstr
		 mov ah, 3fh
		 mov cx, count
		 int 21h
		 
		 lea dx, layer
		 mov ah, 09h
		 int 21h
		 
		 push di
		 
		 lea di, layer
		 
		 add di, 6
		 mov al, [di]
		 
		 cmp al, 32h
		 je print2
		 
		 dec al
		 mov [di], al
		 
		 print2:
			 
			 lea dx, currentstr
			 mov ah, 09h
			 int 21h
			 
			 mov dl, 0ah
			 mov ah, 02h
			 int 21h
			 
			 pop di
			 
			 ret
	
end
