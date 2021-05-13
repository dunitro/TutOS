;clear ax

xor ax, ax

;set direction flag to forward

cld


;setting up the stack


;move the address of the segment location the BIOS loads into ax

mov ax, 0x07c0

;add decimal 288 to the segment location the BIOS loads

add ax, 288

;move the value of the ax register into the ss register (stack segment)

mov ss, ax

;set the offset of the stack

mov sp, 65024

;move the address of the segment location into ax again

mov ax, 0x07c0

;mov ax into the ds register (data segment)

mov ds, ax

;infinite loop the prevent shutdown


;move our string label to bx

mov bx, FirstName

;call the print function

call printirm

mov bx, LastName

call printirm

jmp $

printirm:
    mov ah, 0x0E ;print a char in the basic VGA text mode
    main:
        cmp [bx], byte 0 ;compare dereferenced bx to a byte 0
        je end ;if it is equal, return
        mov al, [bx] ;move the char that is inside dereferenced bx to the char the will be printed out
        int 0x10 ;call the interrupt
        inc bx ;increment the memory address
        jmp main ;jump back to our label
    end:
        ret ;return

FirstName:
    db 'Dumitru', 10, 10, 13, 0

LastName:
    db 'Grajdieru', 10, 13, 0

;fill in the bytes with zeros

times 510-($-$$) db 0

;standard boot signature

dw 0xAA55
