    .data
msg_kms:        .asciiz "Enter travel distance in Km (integer): "
msg_kms_liter:  .asciiz "Enter Km per liter (integer): "
msg_price:      .asciiz "Enter price per liter: "
msg_budget:     .asciiz "Enter the budget: "
msg_result:     .asciiz "The journey of "
msg_km:         .asciiz " Km costs "
msg_exceeds:    .asciiz "\nExceeds the budget"
msg_end:        .asciiz "\nProgram ends\n"

    .text
    .globl main

main:
    # Print msg_kms
    li    $v0, 4
    la    $a0, msg_kms
    syscall

    # Read int (km)
    li    $v0, 5
    syscall
    move  $s0, $v0

    # Print msg_kms_liter
    li    $v0, 4
    la    $a0, msg_kms_liter
    syscall

    # Read int (kmPerLiter)
    li    $v0, 5
    syscall
    move  $s1, $v0

    # Print msg_price
    li    $v0, 4
    la    $a0, msg_price
    syscall

    # Read float (pricePerLiter)
    li    $v0, 6
    syscall
    mov.s  $f20, $f0

    # Print msg_budget
    li    $v0, 4
    la    $a0, msg_budget
    syscall

    # Read float (budget)
    li    $v0, 6
    syscall
    mov.s  $f22, $f0

    # Calculate (km / kmPerLiter) * price
    mtc1   $s0, $f24
    mtc1   $s1, $f26

    cvt.s.w  $f24, $f24
    cvt.s.w  $f26, $f26

    div.s  $f28, $f24, $f26
    mul.s  $f28, $f28, $f20

    # Print msg_result
    li    $v0, 4
    la    $a0, msg_result
    syscall

    # Print km
    li    $v0, 1
    move  $a0, $s0
    syscall
    
    # Print msg_km
    li    $v0, 4
    la    $a0, msg_km
    syscall

    # Print price
    li    $v0, 2
    mov.s  $f12, $f28
    syscall

if_budget:
    c.le.s  $f28, $f22
    bc1t    end

if_then:
    # Print msg_exceeds
    li    $v0, 4
    la    $a0, msg_exceeds
    syscall

end:
    # Print msg_end
    li    $v0, 4
    la    $a0, msg_end
    syscall

    # Exit program
    li    $v0, 10
    syscall
