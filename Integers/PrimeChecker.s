
    .data
strTitle:       .asciiz "\nPR1. Principles of Computers.\n"
strDescription: .ascii  "\nA prime number is a natural number greater than 1 that is\n"
                .ascii  "divisible only by 1 and itself. This program finds prime\n"
                .ascii  "numbers in a range of natural numbers [a, b], where both\n"
                .ascii  "a and b are natural numbers greater than 1. The program\n"
                .ascii  "also ensures that b is greater than or equal to a and\n"
                .asciiz "both are less than 1001 to ensure reasonable execution time.\n\n"
strInfLimit:    .asciiz "Enter the lower limit [a]: "
strSupLimit:    .asciiz "Enter the upper limit [b]: "
strError:       .asciiz "Error, please re-enter the range.\n"
strSpace:       .asciiz " "
strFin:         .asciiz "\nEnd of the program.\n"

    .text
    .globl main

# Registers:
#   $s0 = lower limit (a)
#   $s1 = upper limit (b)
#   $t0 = current number (i)
#   $t1 = current divisor (j)
#   $t2 = isPrime (boolean flag)

main:
    # Print title and description
    li      $v0, 4
    la      $a0, strTitle
    syscall
    li      $v0, 4
    la      $a0, strDescription
    syscall

input_loop:
    # Ask for lower limit
    li      $v0, 4
    la      $a0, strInfLimit
    syscall
    li      $v0, 5
    syscall
    move    $s0, $v0            # lower limit = input

    # Validate lower limit (2 <= a <= 1000)
    blt     $s0, 2, input_error
    bgt     $s0, 1000, input_error

    # Ask for upper limit
    li      $v0, 4
    la      $a0, strSupLimit
    syscall
    li      $v0, 5
    syscall
    move    $s1, $v0            # upper limit = input

    # Validate upper limit (2 <= b <= 1000 && b >= a)
    blt     $s1, 2, input_error
    blt     $s1, $s0, input_error
    bgt     $s1, 1000, input_error
    j       process_range       # Valid input, continue

input_error:
    li      $v0, 4
    la      $a0, strError
    syscall
    j       input_loop          # Repeat input

process_range:
    # Loop to check prime numbers
    move    $t0, $s0            # i = lower limit

prime_check_loop:
    bgt     $t0, $s1, end_program  # Exit if i > upper limit
    li      $t2, 1              # isPrime = true

    # Check if number is prime (optimized up to sqrt(i))
    li      $t1, 2              # j = 2

divisor_check:
    mul     $t3, $t1, $t1       # j^2 for optimization
    bgt     $t3, $t0, prime_found  # If j^2 > i, it's prime
    div     $t0, $t1
    mfhi    $t3                 # t3 = i % j
    beqz    $t3, not_prime      # If divisible, not prime
    addi    $t1, $t1, 1         # j++
    j       divisor_check

not_prime:
    li      $t2, 0              # isPrime = false

prime_found:
    beqz    $t2, skip_print
    li      $v0, 1
    move    $a0, $t0
    syscall                     # Print number
    li      $v0, 4
    la      $a0, strSpace
    syscall                     # Print space

skip_print:
    addi    $t0, $t0, 1         # i++
    j       prime_check_loop

end_program:
    li      $v0, 4
    la      $a0, strFin
    syscall                     # Print final message
    li      $v0, 10
    syscall                     # Exit