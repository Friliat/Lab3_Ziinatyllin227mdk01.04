data segment
   A DB ?
   X DB ?
   Y1 DB ?    
   Y DB ?   
   Y2 DB ? 
   PERENOS DB 13,10,"$"
   VVOD_A DB 13,10,"VVEDITE A=$" 
   VVOD_X DB 13,10,"VVEDITE X=$",13,10  
   VIVOD_Y DB "Y=$"
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax

    ; add your code here
                    
                    
    XOR AX, AX 
    MOV DX, OFFSET VVOD_A
    mov ah, 9
    int 21h      
    
    SLED2:
    MOV AH, 1
    INT 21H 
    CMP AL, "-"
    JNZ SLED1 
    MOV BX, 1 
    JMP SLED2     
    
    SLED1:
    SUB AL, 30H 
    TEST BX, BX 
    JZ SLED3
    NEG AL
    
    SLED3:
    MOV A, AL 
    
    XOR AX, AX
    XOR BX, BX
    
    MOV DX, OFFSET VVOD_X
    MOV AH, 9 
    INT 21H  
    
    SLED4:
    MOV AH, 1
    INT 21H 
    CMP AL, "-"
    JNZ SLED5 
    MOV BX, 1
    JMP SLED4
    
    SLED5:
    SUB AL, 30H 
    TEST BX, BX 
    JZ SLED6 
    NEG AL 
    
    SLED6:
    MOV X, AL
    
    mov AL,X
    CMP AL,7
    JG @RIGHT
    mov AL,A
    add AL,9
    MOV Y1,AL
    JMP @Y2PROV  
    
     @RIGHT:
      mov AL,X
      add AL, 15
      MOV Y1,AL
      JMP @Y2PROV
      
       @Y2PROV:
       CMP X,2
       JG @LEVO
       MOV AL,X
       SUB AL,5
       MOV Y2,AL
       JMP @OTV_Y
       
             
       @LEVO:
       mov AL, 3
       MOV Y2,AL
       JMP @OTV_Y
       
       @OTV_Y:
       MOV BL,Y1
       MOV CL,Y2
       DIV CL
       MOV Y,AL
       
       MOV DX, OFFSET PERENOS 
       MOV AH, 9 
       INT 21H     
       
      MOV DX, OFFSET VIVOD_Y 
      MOV AH, 9 
      INT 21H 
      
      MOV AL, Y
      CMP Y, 0
      JGE SLED7 
      
      NEG AL 
      MOV BL, AL
      MOV DL, "-"
      MOV AH, 2
      INT 21H
      MOV DL, BL
      ADD DL, 30H
      INT 21H
      JMP SLED8

SLED7:
MOV DL, Y
ADD DL, 30H
MOV AH, 2 
INT 21H 

SLED8:
MOV DX, OFFSET PERENOS 
MOV AH, 9
INT 21H

MOV AH, 1
INT 21H    

MOV AX, 4C00H 
INT 21H
ends

end start ; set entry point and stop the assembler.
