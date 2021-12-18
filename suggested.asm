; Idea : Array
; Author: Dr. Mina S. Younan
; Email: mina.younan@mu.edu.eg
;-----------------------------
.386	; processor version
.MODEL FLAT	; memory type 32-bit
ExitProcess PROTO NEAR32 stdcall, dwExitCode: DWORD
INCLUDE io.h
cr	EQU 0dh
Lf	EQU 0ah
max_size EQU 20
.STACK 4096


.DATA

idea	BYTE cr, Lf, ' Idea: User enters up to 20 positive numbers'
       BYTE 'To terminate input enter negative number',cr,Lf
       BYTE ' Output: average and list of numbers above the average', cr,Lf,Lf,0

prm	BYTE ' Enter number = ',0
string	BYTE 20 DUP (?)	; array

Arr	 DWORD max_size DUP (?)	; array each item 4-bytes 
Arr_size DWORD ?	  

lb_avg	BYTE cr,Lf,Lf,' Avg='
result	BYTE 11 DUP (?), cr,Lf,0

lb_above  BYTE cr,Lf,' Above avg:',cr,Lf,Lf,0

.CODE

_start:

output	idea	; output idea
 mov	Arr_size, 0 ; Arr_size := 0
lea	ebx, Arr	; store address of Arr in register ebx
mov edx,0   ; to store summation of array elements
;--------------------------
whilebody:
output	prm	; ‘Enter number = ’
input	string,20	; input string
atod	string
jng	endWhile  ; jump if negative
mov	[ebx],eax	; store item at address in ebx (array)
add     edx , eax            ; -------------NEW CHANGE-------------

inc	Arr_size
add	ebx, 4	; prepare address for the next item
jmp whilebody	; repeat

endwhile:
 
;--------------------------<Sum & Avg>-------------------------------
mov	eax,edx	; total=summation
lea	ebx,Arr	; load effective address
mov	ecx,Arr_size   
jecxz	quit	; quit if no numbers

comment !   
; -------------NEW CHANGE------------- 
;------------------------------------------------------------------------------

;for_1:
;add	eax,[ebx]	; add item to total (eax) 
;add	ebx,4	; next item address
;loop	for_1	; repeat n iteration based on ecx value

;------------------------------------------------------------------------------
!
cdq	; extend total (eax) to quadword
; idiv	Arr_size   ; why to use idiv instead of div ?!  all values are positive !!   -------------NEW CHANGE-------------
div     Arr_size   ; -------------NEW CHANGE-------------
dtoa	result,eax 
output	lb_avg 
output	lb_above
;lea ebx,Arr     ; -------------NEW CHANGE-------------
;mov ecx,Arr_size  ; -------------NEW CHANGE-------------
;--------------------------------------------------------------------------------
for_2:
cmp 	[ebx],eax
jng 	endIfBig ; continuing if>=average
dtoa 	result,[ebx]
output	result

endIfBig:
add ebx,4
loop for_2
;------------------------------------------------------------------------------------

quit:

INVOKE ExitProcess,0  ; exit and return 0 
Public _start    ;	entry point:public
END
