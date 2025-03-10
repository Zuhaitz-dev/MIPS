    .data

prompt:     .asciiz "Enter a number: "
newline:    .asciiz "\n"

    .text
    .globl main

#----------------#
#  Values Table  #
#----------------#
#    $t0 -> N    #
#    $t1 -> i    #
#----------------#

main:
    # Print prompt
    li      $v0, 4
    la      $a0, prompt
    syscall

    # Read integer N
    li      $v0, 5
    syscall
    move    $t0, $v0

    # Initialize counter i
    li      $t1, 0

while_loop:
    bge     $t1, $t0, exit      # If i >= N, exit

    # Print i
    li      $v0, 1
    move    $a0, $t1
    syscall

    # Print newline
    li      $v0, 4
    la      $a0, newline
    syscall

    # Increment i
    add     $t1, $t1, 1

    # jump to the start of the loop
    j       while_loop

exit:
    # Exit program
    li      $v0, 10
    syscall
