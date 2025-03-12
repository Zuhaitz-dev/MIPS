    .data

prompt1:    .asciiz "Enter the first floating-point number: "
prompt2:    .asciiz "Enter the second floating-point number: "
resultMsg:  .asciiz "The division is: "

    .text
    .globl main

main:
    # Print prompt1
    li      $v0, 4
    la      $a0, prompt1
    syscall

    # Read first floating-point number
    li      $v0, 6
    syscall
    mov.s   $f1, $f0

    # Print prompt2
    li      $v0, 4
    la      $a0, prompt2
    syscall

    # Read second floating-point number
    li      $v0, 6
    syscall
    mov.s   $f2, $f0

    # Calculate the division of the two floating-point numbers ($f2 / $f1)
    div.s   $f3, $f2, $f1

    # Print resultMsg
    li      $v0, 4
    la      $a0, resultMsg
    syscall

    # Print floating-point number (result)
    li      $v0, 2
    mov.s   $f12, $f3
    syscall

    # Exit Program
    li      $v0, 10
    syscall
