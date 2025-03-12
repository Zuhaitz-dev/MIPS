    .data

message:    .asciiz "Hello World!\n"

    .text
    .globl main

main:
    li      $v0, 4          # Load system call code for print_string
    la      $a0, message    # Load address of message
    syscall                 # Make system call
    
    li      $v0, 10         # Load System call code for exit
    syscall                 # Exit programr
