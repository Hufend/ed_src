[org 0x7c00]

; Set screen mode to text mode and clear the screen
mov ax, 3
int 0x10

; Initialize segment register
mov ax, 0
mov ds, ax
mov es, ax
mov ss, ax
mov sp, 0x7c00

; Huh?
huh:
	mov bl, 13 ; \n
	call excuse_me
	mov si, what_the_fuck
	call print
	jmp huh

; No need to care
print:
	mov ah, 0x0e
.loop:
	mov al, [si]
	cmp al, 0
	jz .done
	int 0x10
	inc si
	jmp .loop
.done:
	ret

; What did you say?
excuse_me:
	mov cx, 127
.loop:
	mov ah, 0
	int 0x16
	cmp al, bl
	je .done
	cmp al, 8
	je .backspace
	mov ah, 0x0e
	int 0x10
	loop .loop
.done:
	mov si, line
	call print
	ret
.backspace:
	cmp cx, 127
	je .loop
	int 0x10
	mov al, 32
	int 0x10
	mov al, 8
	int 0x10
	inc cx
	jmp .loop

; What the fuck?
what_the_fuck:
	db '?', 13, 10, 0
line:
	db 13, 10, 0

; What is that?
times 510 - ($ - $$) db 0
db 0x55, 0xaa
