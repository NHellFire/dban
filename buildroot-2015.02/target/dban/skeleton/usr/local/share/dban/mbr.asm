ORG 0x7C00 ; Bootcode

; Clear screen
mov ah,0h
mov al,12h
int 10h

; write string
mov ah,13h
mov al,1 ; write mode (advance cursor, ASCII string)
mov bl,0xF ; attribute (white on black)
mov cx,output_len ; string length
;mov dh,2 ; starting row
;mov dl,2 ; starting col
push cs
pop es
mov bp,output ; string
int 10h


; hang indefinitely
JMP $



output:
	db 0xA,0xD, "Model: #MODEL# - Serial: #SERIAL#"
	db 0xA,0xD, "Wipe finished at: #DATE# - #RESULT#"
	db 0xA,0xD, "Method: #METHOD#"
output_len: equ $ - output



; Keep this at the end
; Will pad out to 510 Bytes, then add MBR signature
; Total length 512 Bytes
; As is, program is 116 Bytes (with signature)
; Allows 433 Bytes for generated text (placeholders are 37 Bytes)

times 510-($-$$) db 0
dw 0xAA55
