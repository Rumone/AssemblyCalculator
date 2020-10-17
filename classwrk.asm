model small
.stack 100h

.data
NUM1 db ?
NUM2 db ?
RESULT db ?
TEMP db ?
welcome db, 10, 13, "Assembly Math------------------------------------- $"
menuop1 db, 10, 13, "1. Division $"
menuop2 db, 10, 13, "2. Subtraction $"
menuop3 db, 10, 13, "3. Exit $"
input db, 10, 13, "Enter option choice: $"
warning db, 10, 13, "Program will terminate if any non-integer value is entered", '$'
sub1 db, 10, 13, "Please enter first number: ", '$'                                                 ;operation inputs sub1 and sub2 for subtraction
sub2 db, 10, 13, "Please enter second number: ", '$'
dividend db, 10, 13, "Please enter dividend: ", '$'                                                 ;operation inputs divisor and dividend for division    
divisor db, 10, 13, "Please enter divisor: ", '$'
resultmsg db, 10, 13, "The result is : ", '$'
.code
    main proc
    mov ax, @data
    mov ds, ax
    start:
        mov dx, offset welcome                  ;Assembly Math-------------------------------------        
        mov ah, 09h
        int 21h
        mov dx, offset menuop1                  ;1. Division 
        mov ah, 09h
        int 21h
        mov dx, offset menuop2                  ;2. Subtraction
        mov ah, 09h
        int 21h
        mov dx, offset menuop3                  ;3. Exit
        mov ah, 09h
        int 21h
        mov dx, offset input                    ;Enter option choice:
        mov ah, 09h
        int 21h
        mov ah, 01h                             ;Accepts user single character input and stored in the low end of the accumulator register
        int 21h
        cmp al, '1'                             ;compares the value in al to 1
        je division                             ;jumps to division if al == 1
        cmp al, '2'                             ;compares the value in al to 2
        je subtraction                          ;jumps to subtraction if al == 2
        cmp al, '3'                             ;compares the value in al to 3
        je exit                                 ;jumps to exit if al == 3
        jg start                                ;restarts if al greater than the accepted amount
        jmp exit                                ;default error handler if the value is not in the condision then exit the program
    exit:                                       ;Exits to the operating system                     
        mov ah, 04ch                            
        int 21h
    warnuserintinput:
        mov ah, 09h
        mov dx, offset warning                  ;warns the user not to enter a value that is a integer
        int 21h
        ret                                     ;returns from the function or pop instructions from call stack
    subtraction:                                ;Subtraction instruction set 
        call warnuserintinput                   ;call function to warn user
        mov ah, 09h                             
        mov dx, offset sub1                     ;prompt user for the first number to subtract from
        int 21h
        mov ah, 01h                             ;accept the first number and store it in the al register
        int 21h
        sub al, '0'                             
        cmp al, 9                               ;compares al to 9
        jg subtraction                          ;restarts the instruction subtraction set if al > 9
        sub al, 30h                             ;subtracts 30h from the value in al and stores the actual value entered in al
        mov TEMP, al                            ;stores the values in the al register into TEMP variable
        mov ah, 09h
        mov dx, offset sub2                     ;prompt user for the second number
        int 21h
        mov ah, 01h                             ;accept the first number and store it in the al register
        int 21h
        sub al, '0'
        cmp al, 9
        jg subtraction
        sub al, 30h
        cmp al, TEMP                            ;if the first value entered is smaller than the second value entered then loop function
        jg subtraction        
        mov bx, ax                              ;moves current value into the bx register  
        mov al, TEMP                            ;moves the initial value stores in temp into al register  
        mov ah, 0                               ;clears the ah register therefore only the low end of the accumulator has a valye  
        sub ax, bx                              ;subtract the value in the ax register from the value in the bx register
        aas                                     ;adjust the values in the al register [adjust after substraction]
        add ah, 30h                             ;adds 30h from the value in al  
        add al, 30h                             ;adds 30h from the value in al      
        mov bx, ax                              ;moves the value from the ax register to the bx register
        mov dx, offset resultmsg                ;display message before outputting the result
        mov ah, 09h             
        int 21h
        mov ah, 2                               ;prints the value stored in the dl register on int 21h interrupt which is why bl is moved into the dl register 
        mov dl, bl                              
        int 21h
        jmp exit                                ;jumps to the exit instructions to close the program    
    division:                                   ;division instruction set 
        call warnuserintinput                   ;call warn user abt integer input
        mov ah, 09h
        mov dx, offset dividend                 ;prompt user to enter dividend
        int 21h                                 
        mov ah, 01h                             ;accept user value input for dividend
        int 21h 
        sub al, '0'
        cmp al, 9
        jg division
        sub al, 30h                             
        mov NUM1, al                            ;stores value entered into num1
        mov dx, offset divisor                  ;prompts user to enter divisor
        mov ah, 09h
        int 21h
        mov ah, 01h                             ;accpets user value input for divisor
        int 21h
        sub al, '0'
        cmp al, 9
        jg division
        sub al, 30h
        cmp al, NUM1                            ;redo division if value is greater than al
        jg division
        mov NUM2, al                            ;stores the second value in bl register
        mov al, NUM1                            ;puts the value in NUM1 back in al register
        mov bl, NUM2                            ;puts the value in NUM2 in the bl register
        mov ah, 0                               ;clears out the ah register
        div bl                                  ;divides the ax register by the value in the bl register [it implicitly knows the the dividend is stored in the accumulator registor]
        mov dx, offset resultmsg                ;prints message for calculation result
        mov ah, 09h                             
        int 21h
        mov ah, 2                               ;instruction prints to value in the dl register on DOS interrups
        add al, 30h                             ;adds 30h to the result value that is stored in the accumulator register
        mov dl, al                              ;moves the value in the dl register to be printed to the console
        int 21h
        jmp exit
main endp
end main