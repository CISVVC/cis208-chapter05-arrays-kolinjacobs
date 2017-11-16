
; file: asm_main.asm

%include "asm_io.inc"
;
; initialized data is put in the .data segment
;
segment .data
        syswrite: equ 4
        stdout: equ 1
        exit: equ 1
        SUCCESS: equ 0
        kernelcall: equ 80h
	array   dw      1,2,3,4,5
	promt1	db "your current array: ",10,0
	promt2  db "your scalar is: ",10,0
	promt3	db "your array after the scalar is applied: ",10,0

; uninitialized data is put in the .bss segment
;
segment .bss

;
; code is put in the .text segment
;
segment .text
	extern _puts, _printf, _scanf, _dump_line
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha
; *********** Start  Assignment Code *******************
	
	mov	eax, promt1	;print out promt 1
	call 	print_string	;

	xor	eax,eax		;print out the current array
	mov	ebx,array 	;
	mov	ecx,5		;
	call	print_array	;
	call	print_nl	;
	
	mov ecx,5		
	mov ebx,array

	xor eax,eax		;print out promt2 and the scalar
	mov eax, promt2		;
	call print_string	;
	xor eax,eax
	mov ax,4
	call print_int
	call print_nl

	call scale_array	;call the scale array function with ax as the scalar
	
	mov eax,promt3		;print our promt 3
	call print_nl		;
	call print_string	;

	mov ebx,array		;set up the print array function
	mov ecx,5		;
	xor eax,eax		;
	call print_array	;

; *********** End Assignment Code **********************

        popa
        mov     eax, SUCCESS       ; return back to the C program
        leave                     
        ret

;*************** scale array function **************
scale_array:
 loop_scale:
	mov dx,[ebx]
	imul dx,ax
	mov [ebx],dx
	add ebx,2
	loop loop_scale
	ret

;************** print array function ***************
print_array:
 loop_array:
	mov al,[ebx]
	call print_int
	call print_nl
	add ebx,2
	loop loop_array
	ret	

