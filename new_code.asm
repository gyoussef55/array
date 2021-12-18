.386	
.MODEL FLAT	
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
string	BYTE 20 DUP (?)	

Arr	 DWORD max_size DUP (?)
Arr_size DWORD ?	  

lb_avg	BYTE cr,Lf,Lf,' Avg='
result	BYTE 11 DUP (?), cr,Lf,0

lb_above  BYTE cr,Lf,' Above avg:',cr,Lf,Lf,0

.CODE

_start:

output	idea	
 mov	Arr_size, 0  
lea	ebx, Arr	
mov edx,0   

whilebody:
output	prm	
input	string,20	
atod	string
jng	endWhile  
mov	[ebx],eax	
add     edx , eax

inc	Arr_size
add	ebx, 4	
jmp whilebody	

endwhile:
 

mov	eax,edx	
lea	ebx,Arr	
mov	ecx,Arr_size   
jecxz	quit	

cdq	

div     Arr_size
dtoa	result,eax 
output	lb_avg 
output	lb_above


for_2:
cmp 	[ebx],eax
jng 	endIfBig 
dtoa 	result,[ebx]
output	result

endIfBig:
add ebx,4
loop for_2


quit:

INVOKE ExitProcess,0  
Public _start    
END