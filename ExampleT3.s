#   Program that adds two integers and prints the result

    .data
cadpet:     .asciiz "Enter one integer: "
cadsum:     .asciiz "The sum is: "

    .text
    .globl main

main:
    # Print the string "Enter one integer: "
    li      $v0, 4          # Print the string ($v0 = 4)
    la      $a0, cadpet     # Load the address of the string to print ($a0 = cadpet)
    syscall

    # Read an integer
    li      $v0, 5          # Read an integer ($v0 = 5)
    syscall
    move    $s0, $v0        # Move the integer read to $s0

    # Print the string "Enter one integer: "
    li      $v0, 4          # Print the string ($v0 = 4)
    la      $a0, cadpet     # Load the address of the string to print ($a0 = cadpet)
    syscall

    # Read an integer
    li      $v0, 5          # Read an integer ($v0 = 5)
    syscall
    move    $s1, $v0        # Move the integer read to $s1

    add     $s2, $s0, $s1   # Add the integers read and store the result in $s2

    # Print the string "The sum is: "
    li      $v0, 4          # Print the string ($v0 = 4)
    la      $a0, cadsum     # Load the address of the string to print ($a0 = cadsum)
    syscall

    # Print the sum
    li      $v0, 1          # Print an integer ($v0 = 1)
    move    $a0, $s2        # Move the integer to print to $a0
    syscall

    # Print a newline

    li      $v0, 11         # Print a char ($v0 = 11)
    la      $a0, '\n¡'      # Load the address of the char to print ($a0 = '\n')
    syscall

    # Exit
    li     $v0, 10         # Exit ($v0 = 10)
    syscall