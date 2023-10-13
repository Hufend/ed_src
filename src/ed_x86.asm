; This is a joke about ed.
; See <https://www.gnu.org/fun/jokes/ed.html>.
; 64-bit mode
[BITS 64]
; 32-bit mode
; [BITS 32]
section .data
	what:
		times 32 db 0 ; what are you said?
	what_the_fuck:
		db '?', 13, 10, 0 ; what the fuck?
section .text
	global _start
	_start:
		; 64-bit mode
		mov rax, 3
		mov rbx, 0
		mov rcx, what
		mov rdx, 32
		int 0x80

		mov rax, 4
		mov rbx, 1
		mov rcx, what_the_fuck
		mov rdx, 4
		int 0x80

		; 32-bit mode
		; mov eax, 3
		; mov ebx, 0
		; mov ecx, what
		; mov edx, 32
		; int 0x80

		; mov eax, 4
		; mov ebx, 1
		; mov ecx, what_the_fuck
		; mov edx, 4
		; int 0x80

		jmp _start
