#
# An x86-32 assembly program that echos one character
#

	.globl check
	.globl _check
	.globl reverse
	.globl _reverse

	# int check(Node* p)
check:
	mov 4(%esp), %eax #pointer is in eax
	mov $0, %ecx #counter
	cmp $0, %eax #if no nodes...
	jz endlin #...end
	inc %ecx
	mov (%eax), %eax #first node into eax
	cmp $0, %eax #if one node...
	jz endlin #...end
	inc %ecx
	mov (%eax), %edx #create hare
	cmp $0, %edx #if two nodes...
	jz endlin #...end
	inc %ecx
	mov (%eax), %ebx
	cmp %ebx, (%edx) #if single cell cycle...
	jz endloop
checktwo:
	mov (%eax), %eax #move tortoise forward one
	cmp $0, (%eax) #if tortoise holds end
	jz endlin
	mov (%edx), %edx #move hare forward one
	inc %ecx
	cmp $0, (%edx) #if hare holds end
	jz endlin
	mov (%edx), %edx #move hare forward one
	inc %ecx
	cmp $0, (%edx) #if hare holds end
	jz endlin
	mov (%eax), %ebx
	cmp %ebx, (%edx) #if equal nodes
	jz endloop
	jmp checktwo
isloop:
	mov (%eax), %eax
	mov (%edx), %edx
	mov (%edx), %edx
	inc %ecx
	mov (%eax), %ebx
	cmp %ebx, (%edx)
	jz endloop
	jmp isloop
endloop:
	mov $0, %ebx
	mov $-1, %eax
	ret
endlin:
	mov $0, %ebx
	mov %ecx, %eax
	ret

reverse:
	push %ebp #push base pointer to stack
	mov %esp, %ebp #move top of stack to bottom of stack
	mov 8(%esp), %ecx #move pointer into ecx
	cmp $0, %ecx
    jz end
loop:
	push 4(%ecx)
    mov (%ecx), %ecx
    cmp $0, %ecx
    jz orig
    jmp loop
orig:
	mov %ebp, %ecx
    mov 8(%ebp), %ecx
popit:
	pop 4(%ecx)
    mov (%ecx), %ecx
    cmp $0, %ecx
    jz end
    jmp popit
end:
	mov %ebp, %esp
    pop %ebp
    ret



#eax ecx edx aren't reserved, esi, edi, ebx | esp, and ebp are preserved across function calls
