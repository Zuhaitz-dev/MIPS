    .data

prompt:     .asciiz "Enter a number: "
resultMsg:  .asciiz "Factorial is: "

    .text
    .globl main

main:
    # Print prompt for input
    li      $v0, 4
    la      $a0, prompt
    syscall

    # Read integer input
    li      $v0, 5
    syscall
    move    $t0, $v0

    li      $t1, 1  # We initialize factorial result to 1

factorial_loop:
    blez    $t0, print_result   # If $t0 <= 0, we go to print result
    mul     $t1, $t1, $t0       # Multiply result by input number
    sub     $t0, $t0, 1         # Decrease input number by one
    j       factorial_loop      # Repeat

    # What we do here is something like:
    #
    # while($t0 > 0)
    # {
    #   $t1 *= $t0;
    #   $t0--;
    # }

print_result:
    # Print prompt for result
    li      $v0, 4
    la      $a0, resultMsg
    syscall

    # Print the result ($t1)
    li      $v0, 1
    move    $a0, $t1
    syscall

    # Exit program
    li      $v0, 10
    syscall
