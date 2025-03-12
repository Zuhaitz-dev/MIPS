    .data

prompt:     .asciiz "Enter a number to countdown from: "
newline:    .asciiz "\n"

    .text
    .globl main

main:
    # Print prompt
    li      $v0, 4
    la      $a0, prompt
    syscall

    # Read integer n
    li      $v0, 5
    syscall
    move    $t0, $v0            # We store n in $t0

while_loop:
    blt     $t0, $zero, exit    # If n < 0, exit

    # Print current number
    li      $v0, 1
    move    $a0, $t0
    syscall

    # Print newline
    li      $v0, 4
    la      $a0, newline
    syscall

    # Decrement n
    sub    $t0, $t0, 1

    # Jump to start
    j       while_loop


exit:
    # Exit program
    li      $v0, 10
    syscall
