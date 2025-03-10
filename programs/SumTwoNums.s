    .data
    
prompt1:    .asciiz "Enter first number: "
prompt2:    .asciiz "Enter second number: "
resultMsg:  .asciiz "The sum is: "
    
    .text
    .globl main

main:

    # Prompt for first number
    li      $v0, 4
    la      $a0, prompt1
    syscall
    
    # Read first number
    li      $v0, 5
    syscall
    move    $t0, $v0    # Store first number in $t0
    
    # Prompt for second number
    li      $v0, 4
    la      $a0, prompt2
    syscall
    
    # Read second number
    li      $v0, 5
    syscall
    move    $t1, $v0    # Store second number in $1
    
    # Add two numbers
    add     $t2, $t0, $t1
    
    # Print result message
    li      $v0, 4
    la      $a0, resultMsg
    syscall
    
    # Print sum
    li      $v0, 1
    move    $a0, $t2
    syscall
    
    # Exit program
    li      $v0, 10
    syscall
