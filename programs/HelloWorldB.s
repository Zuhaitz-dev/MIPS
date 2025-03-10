    .section    .text
    .global __start

__start:
    ; STDIN = 0
    ; STDOUT = 1
    ; STDOUT = 2

    li      $v0, 4004
    li      $a0, 1
    la      $a1, msg
    li      $a2, 13
    syscall

    li      $v0, 4001
    li      $a0, 13
    syscall

    .section    .data

msg:        .asciiz     "Hello World!\n"
