
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h


org 100h

.data        ; declaring variable
    n1 db 0
    n2 db 0
    
.code                                                     
MAIN PROC       
    
         
    MOV DX,OFFSET WhatOption
    MOV AH,09H  
    INT 21H
    ; Display a new line
    MOV AH, 02h     
    MOV DL, 10 
    INT 21h
     
    MOV AH,01H
    INT 21H
    CMP AL,31H
    JE ADDITION
    CMP AL,32H
    JE SUBTRACTION
    CMP AL,33H
    JE MULTIPLICATION
    CMP AL,34H
    JE DIVISION
    
               
MAIN ENDP    
    
InPut PROC
    ; Display a new line
    MOV AH, 02h     
    MOV DL, 10 
    INT 21h
    ; enter the first number
    MOV AH, 09H       
    MOV DX, OFFSET inPut1
    INT 21H 

    ; Read the first number from keyboard
    MOV AH, 01H
    INT 21H    
    SUB AL, '0'   
    MOV n1,AL
    ; Display a new line
    MOV AH, 02h     
    MOV DL, 10 
    INT 21h         
    ; Prompt user to enter the second number
    MOV AH, 09H       
    MOV DX, OFFSET inPut2
    INT 21H 

    ; Read the second number
    MOV AH, 01H
    INT 21H    
    SUB AL, '0'   ; Convert ASCII digit to binary  
    mov n2 , al
    ; Display a new line
    MOV AH, 02h     
    MOV DL, 10 
    INT 21h
    
    MOV AH,00H

    RET 
InPut ENDP

    

        
ADDITION PROC
    CALL InPut
    MOV AX , 0000h
    MOV BX , 0000h
    MOV AL , n1
    MOV BL , n2
    ADD AX,BX
    MOV CX,AX
    ;printing 
    MOV AH, 09H       
    MOV DX, OFFSET REsult
    INT 21H
    
    MOV AX,CX  
    MOV BL , 10
    DIV BL
    MOV BH , AH   

    MOV AH , 02h
    MOV DL , AL
    ADD DL , '0'
    INT 21h
    MOV AH , 02h
    MOV DL , BH
    ADD DL , '0'
    INT 21h    
    RET 
                           
ADDITION ENDP

SUBTRACTION PROC
    CALL InPut
    MOV AX , 0000h
    MOV BX , 0000h
    MOV AL , n1
    MOV BL , n2 
    
    SUB AL,BL
    JS NEGETIVE
     
    MOV AX , 0000h
    MOV BX , 0000h
    MOV AL , n1
    MOV BL , n2
    
    SUB AX,BX  
    MOV CX,AX
    ;printing
    MOV AH, 09H       
    MOV DX, OFFSET REsult
    INT 21H    
    
    MOV AX,CX  
    MOV BL , 10
    DIV BL
    MOV BH , AH   

    MOV AH , 02h
    MOV DL , AL
    ADD DL , '0'
    INT 21h
    MOV AH , 02h
    MOV DL , BH
    ADD DL , '0'
    INT 21h    
    RET 
                           
SUBTRACTION ENDP 

NEGETIVE PROC
    MOV AX , 0000h
    MOV BX , 0000h  
    MOV AL , n2
    MOV BL , n1 
    SUB AX,BX 
    MOV CX,AX
    ;printing
    MOV AH, 09H       
    MOV DX, OFFSET REsult
    INT 21H
    MOV AH, 09H       
    MOV DX, OFFSET MINUS
    INT 21H
    
    MOV AX,CX   
    MOV BL , 10
    DIV BL
    MOV BH , AH   

    MOV AH , 02h
    MOV DL , AL
    ADD DL , '0'
    INT 21h
    MOV AH , 02h
    MOV DL , BH
    ADD DL , '0'
    INT 21h    
    RET
NEGETIVE ENDP    
    
    

MULTIPLICATION PROC
    CALL InPut
    MOV AX , 0000h
    MOV BX , 0000h
    MOV AL , n1
    MOV BL , n2
    MUL BX  
    MOV CX,AX
    ;printing 
    MOV AH, 09H       
    MOV DX, OFFSET REsult
    INT 21H
    MOV AX,CX  
    MOV BL , 10
    DIV BL
    MOV BH , AH   

    MOV AH , 02h
    MOV DL , AL
    ADD DL , '0'
    INT 21h
    MOV AH , 02h
    MOV DL , BH
    ADD DL , '0'
    INT 21h    
    RET 
                           
MULTIPLICATION ENDP

DIVISION PROC
    
    
    
    CALL InPut
    

    CMP n2, 0
    JE DivisionByZeroError
    
    MOV AX, 0000h
    MOV BX, 0000h
    MOV AL, n1
    MOV BL, n2
    DIV BL  
    MOV CL,AL
    MOV CH, AH  
    ; Display quotient
    
    MOV AH, 09H       
    MOV DX, OFFSET REsult
    INT 21H        
    
    
    MOV DL,CL
    
    MOV AH, 02h
    ADD DL, '0'   
  
    INT 21h       ; Display quotient
    
    ; Display remainder                
    MOV AH, 09H       
    MOV DX, OFFSET rem
    INT 21H
     
    MOV DL,CH 
    MOV AH, 02h  
    ADD DL, '0'   ; Convert remainder to ASCII character
    INT 21h       ; Display remainder
    
    RET 
                          
DIVISION ENDP



DivisionByZeroError PROC
    ; Handle division by zero error here, such as displaying an error message
    MOV AX, 0H         
    MOV ES, AX         
    MOV AL, 65H
    MOV BL,4H
    MUL BL
           
    MOV BX, AX   
                  
    MOV SI,offset [ZEROO]
    MOV ES:[BX],SI
    ADD BX,2
    MOV AX,CS
    MOV ES:[BX],AX
                  

   
    INT 65H            ; Trigger division by zero error
    RET
    
DivisionByZeroError ENDP

ZEROO:
    MOV AH, 09H
    MOV DX, OFFSET intterrupt
    INT 21H
    
    MOV AH, 4Ch ;END PROGRAM
    INT 21h



WhatOption DB "Which operation to perform - 1.ADDITION 2.SUBTRACTION 3.MULTIPLICATION 4.DIVISION",'$'
inPut1 DB "Enter 1st No:",'$'
inPut2 DB "Enter 2nd No:",'$' 
REsult DB "ANSWER : ",'$'
rem DB "REMAINDER : ",'$' 
intterrupt DB "I CAN'T DIVIDE BY ZERO! I QUIT...",'$'
MINUS DB "-",'$'

END MAIN




ret




