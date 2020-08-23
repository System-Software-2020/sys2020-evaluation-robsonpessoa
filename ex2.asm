        global write

        section .text
write:
        push ebp ; prologue
        mov ebp, esp

        push ebx ; saves the value of the ebx in the stack before using it

        mov ebx, [esp+12]       ; updates the offsets because now there is new
        mov ecx, [esp+16]       ; data in the stack (the ebx)
        mov edx, [esp+20]
        mov eax, 4
        int 0x80               ; syscall write (4) in x86

        pop ebx  ; takes the previous value of ebx back from the stack

        mov esp, ebp ; epilogue
        pop ebp
        ret