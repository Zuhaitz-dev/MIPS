    .data

string:     .asciiz "Hello, MIPS!"
lengthMsg:  .asciiz "String length: "

# Little exercise:
#
# Change string to "1234" and then to "····"
# Check string length. What is happening?
#
# For better understanding: https://en.wikipedia.org/wiki/UTF-8

    .text
    .globl main

#----------------------#
#     Table Values     #
#----------------------#
#  $a0 -> addressStr   #
#  $t0 -> charCounter  #
#  $t1 -> CurrentChar  #
#----------------------#

main:
    la      $a0, string     # Load address of string
    li      $t0, 0          # Initialize counter

count_loop:
    lb      $t1, 0($a0)     # Load one byte
    # If null terminator, stop
    beq     $t1, $zero, print_result
    addi    $t0, $t0, 1     # Increment counter
    addi    $a0, $a0, 1     # Move to next byte
    j       count_loop

    # In C++
    #
    # ...
    #
    # while (*str != '\0')      -> $t1
    # {
    #   count++;                -> $t0
    #   str++;                  -> $a0
    # }

print_result:
    # Print lengthMsg
    li      $v0, 4
    la      $a0, lengthMsg
    syscall

    # Print counter ($t0)
    li      $v0, 1
    move    $a0, $t0
    syscall

    # Exit program
    li      $v0, 10
    syscall
