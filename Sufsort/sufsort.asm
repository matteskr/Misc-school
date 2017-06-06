%include "asm_io.inc"
 
global asm_main

SECTION .data ;initialized data
ERRarg: db "Incorrect number of arguments", 10, 0   
ERRlen: db "Incorrect length", 10, 0
ERRinp: db "Incorrect input", 10, 0
Sort:	db "sorted suffixes", 10, 0


SECTION .bss ;unitialized data
N: resb 1  ;Length of input string
X: resb 31 ;String
Y: resb 31 
i: resd 1
j: resd 1
k: resd 1

SECTION .text

 

sufcmp:
	enter 0,0
	pusha

	mov ebx, dword[ebp+8]		;set ebx to the first parameter 
	mov ecx, dword[ebp+12]		;set ecx to the second parameter 
	mov edx, dword[ebp+16]		;set edx to the third parameter 

	LOOPcmp:
       cmp byte [ebx+ecx], '0' 
	   je RETMINUS
       cmp byte [ebx+edx], '0'  
	   je RETPLUS
	   mov al, byte[ebx+edx]
       cmp byte [ebx+ecx], al
	   jl RETMINUS
       cmp byte [ebx+ecx], al
	   jg RETPLUS
	   add ecx, dword 4 		;increment ecx by 1
       add edx, dword 4 		;increment edx by 1
       jmp LOOPcmp
	RETPLUS:
       popa
       mov eax, dword 1 ;set EAX to 1
       jmp END
	RETMINUS:
       popa
       mov eax, dword -1 ;set EAX to -1
	END:
	add esp, 12	
	leave
	ret	

 
asm_main:				  
	enter 0, 0            ; setup routine
	pusha                 ; save all registers
  
  ;----------------------ErrorArg----------------------------
	mov eax, dword [ebp+8]   ; argc
	cmp eax, dword 2         ; argc must be 2
	je Init
	jne ERR1
  ;------------------------Init------------------------------
	Init:
		mov ebx, dword [ebp+12]  
		mov eax, dword [ebx+4]   
		mov ebx, eax
		mov edx, eax
		mov ecx, 0
	
  ;-----------------------ErrInp/CountingLoop---------------
	LOOPcount:
		mov al, byte [ebx]
		cmp byte [ebx], 0	; Checks for null char at end of string
		je Next
		 
		try1: cmp byte [ebx], '0'
		jne try2
		jmp valid
		try2: cmp byte [ebx], '1'
		jne try3
		jmp valid
		try3: cmp byte [ebx], '2'
		jne ERR3
		jmp valid
		valid:
		inc ecx
		inc ebx
		jmp LOOPcount
  
  ;--------------------ErrorLen/length----------------------  	
	Next:
		cmp ecx, 30				
		ja ERR2					
		cmp ecx, 1				
		jb ERR2					
		mov [N], ecx
		mov eax, [N]
		mov edi, eax
		mov ecx, 0 				
		mov ebx, edx			
	;----------Storing and displaying array-------------------  	
	SetArray: 					;moving each byte into X
		mov al, byte [ebx]		;Taking first byte from ebx into al.
		cmp byte [ebx], 0		
		je DisplayArray
		mov edx, X			
		add edx, ecx		
		mov [edx], al		
		inc ebx					;move to next char
		inc ecx
		jmp SetArray
	
	DisplayArray: 
		mov eax , dword 0
		mov eax, X
		call print_string
		mov eax, Sort
		call print_nl
		call print_string

	
	 ;----------------------Comparing suffixes(INCOMPLETE)----------------- 
	CallSufcmp:
		call sufcmp ;No errors calling
		Lstart:   ;for i in range (N,0,-1) attempt from python code
		cmp edi, 0
		je TillEnter
		mov eax, X
		call print_string ;Checking if loop works
		call print_nl
		dec edi
		jmp Lstart
		
		Loop2: ;for j in range(1,i) attempt from python code
		; cmp byte [esi], byte [edi-1] 
		; je TillEnter
		; call sufcmp  ; Would use sufcmp to compare suffixes through an array of indices somehow
		; inc esi
		; jmp TillEnter
		
		
		
				
	

  ;;---------------Wait for user to press Enter to Terminate-----------
	TillEnter:
		call read_char			;must press enter to Terminate
		jmp main_end
  
  ;;-----------------------Calling Error Messages----------------------
    ERR1:
   		mov eax, ERRarg
		call print_string  
		jmp main_end	
	ERR2:
		mov eax, ERRlen
		call print_string  
		jmp main_end
	ERR3:
		mov eax, ERRinp
		call print_string  
		jmp main_end
	
	main_end:
		popa                  ; restore all registers
		leave                     
		ret
	
	
	

	
