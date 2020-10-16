model small
.stack 100h

.data
NUM1 db ?
NUM2 db ?
RESULT db ?

welcome db "Press 1 for division and any other key for subtraction: ", 10, 13, '$'
warning db, 10, 13, "Program will terminate if any non-integer value is entered", 10, 13, '$'

sub1 db, 10, 13, "Please enter first number: ", '$'
sub2 db, 10, 13, "Please enter second number: ", '$'

dividend db, 10, 13, "Please enter dividend: ", '$'
divisor db, 10, 13, "Please enter divisor: ", '$'

resultmsg db, 10, 13, "The result is : ", '$'
invalid db, 10, 13, "Invalid character...exiting program", '$'

.code
    main proc
    mov ax, @data
    mov ds, ax
   

    start:
        mov dx, offset welcome
        mov ah, 09h
        int 21h
        
        mov ah, 01h
        int 21h
        
        cmp al, '1' 
        je division 
        
        jmp subtraction
        
        mov ah, 04ch
        int 21h

    subtraction: 
        mov ah, 09h
        mov dx, offset warning
        int 21h
        
        mov ah, 09h
        mov dx, offset sub1
        int 21h
        
        mov ah, 01h
        int 21h

        sub al, 30h
        mov bx, ax
        
        mov ah, 09h
        mov dx, offset sub2
        int 21h
        
        mov ah, 01h
        int 21h

        sub al, 30h
        
        sub bx, ax
        
        aas
        add bh, 30h 
        add bl, 30h
        
        mov dx, offset resultmsg
        mov ah, 09h
        int 21h
        
        mov ah, 2
        mov dl, bl
        int 21h
        
        ; exit to Operating system
        mov ah, 04ch
        int 21h
        
    
    division:
        mov ah, 09h
        mov dx, offset warning
        int 21h
        
        mov ah, 09h
        mov dx, offset dividend
        int 21h
        
        mov ah, 01h
        int 21h
                
        sub al, 30h
        mov NUM1, al
        
        mov dx, offset divisor
        mov ah, 09h
        int 21h
        
        mov ah, 01h
        int 21h
       
        sub al, 30h
        mov NUM2, al
        
        mov al, NUM1
        mov bl, NUM2
        
        mov ah, 0
        div bl
        
        mov dx, offset resultmsg
        mov ah, 09h
        int 21h
            
        mov ah, 2
        add al, 30h
        mov dl, al
        int 21h
        
        ; exit to Operating system
        mov ah, 04ch
        int 21h
        
    exit:
        mov ah, 09h
        mov dx, offset invalid
        int 21h
        
        
        ; exit to Operating system
        mov ah, 04ch
        int 21h
    
main endp
end main