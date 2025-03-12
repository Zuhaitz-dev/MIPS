    .data

prompt:      .asciiz "Enter number of Fibonacci terms: "
newline:    .asciiz "\n"

    .text
    .globl main

#----------------#
#  Table Values  #
#----------------#
#  $t0 -> input  #
#  $t1 -> F(n-2) #
#  $t2 -> F(n-1) #
#  $t3 -> F(n)   #
#----------------#

main: 
    # Print prompt for input
    li      $v0, 4
    la      $a0, prompt
    syscall

    # Read the integer input
    li      $v0, 5
    syscall
    move    $t0, $v0    # Store N ($t0)

    # Let's define the two Fibonacci numbers (F0 and F1)
    li      $t1, 0
    li      $t2, 1

    # Print first number
    li      $v0, 1
    move    $a0, $t1
    syscall

    # Print newline
    li      $v0, 4
    la      $a0, newline
    syscall

    # Check if only one number is needed
    beq     $t0, 1, exit

    # Print second number
    li      $v0, 1
    move    $a0, $t2
    syscall

    # Print newline
    li      $v0, 4
    la      $a0, newline
    syscall

    # Let's decrease count by 2 as we already printed two numbers
    sub     $t0, $t0, 2

fibonacci_loop:
    blez    $t0, exit       # If count reaches 0, exit
    add     $t3, $t1, $t2   # F(n) = F(n-1) + F(n-2)

    # Print $t3
    li      $v0, 1
    move    $a0, $t3
    syscall

    # Print newline
    li      $v0, 4
    la      $a0, newline
    syscall

    # Update values
    move    $t1, $t2
    move    $t2, $t3

    # Decrease count
    sub     $t0, $t0, 1
    j       fibonacci_loop

    # In C++
    #
    # ...
    #
    # for($t0; $t0 > 0; $t0--)
    # {
    #   $t3 = $t1 + $t2;
    #   $t1 = $t2
    #   $t2 = $t3
    #   std::cout << '\n';
    # }

exit:
    # Exit program
    li      $v0, 10
    syscall
