
SECTION .bss
	  c: resb 1
          buf: resb 1

SECTION .text
	  jmp _start

exit:
	  mov rax,60
	  syscall

printchar:
	  mov [c], bl
	  mov rax, 1
	  mov rdi, 1
	  ;mov bh,0
	  ;mov r11, rbx
	  mov rsi, c
	  mov rdx, 1
	  syscall
	  ret

printnum: 
	  mov ah, 0	  
	  mov al, bl
	  cmp al, 10       ;rbx == 10 or 100
          jl  .else
	  cmp al,100
	  jl .if
	  mov bl,100
	  div bl
	  mov bl, al
	  mov [buf], ah
 	  add bl,'0'
	  call printchar
	  mov al, [buf]
.if:
  	  mov ah, 0
	  mov bl, 10 
	  div bl
	  mov bl, al
	  mov [buf], ah
	  add bl, '0'
	  call printchar
	  mov al, [buf]
.else:
	  mov bl, al
	  add bl, '0'
	  call printchar

.done:
	  mov rdi, 0
	  ret
	  



printascii:
	   mov bh, 0 
	   mov r14,rbx
	   mov bl,`\t`
	   call printchar
	   mov rbx,r14
	   call printnum
	   mov bl,`:`
	   call printchar
	   mov bl, ` `
	   call printchar
	   mov bl, `\'`
	   call printchar
           mov rbx,r14
	   cmp bl, 32
	   jl .else
	   cmp bl, 127
	   jge .else
	   call printchar
	   mov bl, `\'`
	   call printchar
	   mov rbx, r14
           ret
.else:
	   mov bl, `.`
	   call printchar
	   mov bl, `\'`
	   call printchar
	   mov rbx, r14
	   ret

GLOBAL _start

_start:
	mov r15, 0
        mov rbx,0
        mov rax, 0
.loop:
	cmp r15, 32
	jge .done
	
	mov rbx, r15
	call printascii
	add bl, 32
	call printascii
	add bl, 32
	call printascii
	add bl, 32
	call printascii
	mov bl, `\n`
	call printchar
	inc r15
	jmp .loop

.done:
	mov bl, 0
	call exit

	
	   



