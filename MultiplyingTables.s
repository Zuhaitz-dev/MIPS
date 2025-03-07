.data

strTitle:       .asciiz "Multiplying Tables (Practice)\n"
strWhichTable:  .asciiz "Which table do you want to practice? "
strX:           .asciiz " x "
strEqual:       .asciiz " = "
strCorrect:     .asciiz "Correct!\n"
strIncorrect:   .asciiz "Incorrect!\n"
strYourPercent: .asciiz "Your percentage is: "
strPercent:     .asciiz "%\n"
strEnd:         .asciiz "End of the program\n"

    .text
    .globl main

main:

# Values (summary)
# ----------------
# $t0: Counter for the table (i = 1)
# $t1: Counter for the table (i = 10)
# $s0: Table to practice (integer read)
# $s1: Answer to the multiplication
# $s2: Correct answers
# $s3: Percentage
# ----------------

    # Print the title
    li      $v0, 4              # Print the string ($v0 = 4)
    la      $a0, strTitle       # Load the address of the string to print ($a0 = strTitle)
    syscall

    # Print the string "Which table do you want to practice? "
    li      $v0, 4              # Print the string ($v0 = 4)
    la      $a0, strWhichTable  # Load the address of the string to print ($a0 = strWhichTable)
    syscall

    # Read an integer
    li      $v0, 5              # Read an integer ($v0 = 5)
    syscall
    move    $s0, $v0            # Move the integer read to $s0

    # Initialize counters and correct answers
    li      $t0, 1              # Counter for the table (i = 1)
    li      $t1, 10             # Counter for the table (i = 10)
    li      $s2, 0              # Correct answers counter



while:
    bgt     $t0, $t1, end       # If i > 10, end the program
    b       whilePrint          # Print the table



whilePrint:
    # Print the table
    li      $v0, 1              # Print an integer ($v0 = 1)
    move    $a0, $s0            # Move the integer to print to $a0
    syscall

    # Print the string " x "
    li      $v0, 4              # Print the string ($v0 = 4)
    la      $a0, strX           # Load the address of the string to print ($a0 = strX)
    syscall

    # Print the integer i
    li      $v0, 1              # Print an integer ($v0 = 1)
    move    $a0, $t0            # Move the integer to print to $a0
    syscall

    # Print the string " = "
    li      $v0, 4              # Print the string ($v0 = 4)
    la      $a0, strEqual       # Load the address of the string to print ($a0 = strEqual)
    syscall

    # Read an integer
    li      $v0, 5              # Read an integer ($v0 = 5)
    syscall
    move    $s1, $v0            # Move the integer read to $s1

    # Calculate the answer
    mul     $t2, $s0, $t0       # $t2 = $s0 * $t0

    # Check if the answer is correct
    beq     $s1, $t2, whileCorrect # If the answer is correct, print "Correct!" and increment the counter
    b       whileIncorrect        # If the answer is incorrect, print "Incorrect!" and increment the counter



whileCorrect:
    # Print the string "Correct!"
    li      $v0, 4              # Print the string ($v0 = 4)
    la      $a0, strCorrect     # Load the address of the string to print ($a0 = strCorrect)
    syscall

    # Increment the variable correct
    addi    $s2, $s2, 1

    # Increment the counter
    addi    $t0, $t0, 1         # Increment the counter
    b       while                # Repeat the loop



whileIncorrect:
    # Print the string "Incorrect!"
    li     $v0, 4              # Print the string ($v0 = 4)
    la     $a0, strIncorrect   # Load the address of the string to print ($a0 = strIncorrect)
    syscall

    # Increment the counter
    addi    $t0, $t0, 1         # Increment the counter
    b       while                # Repeat the loop



# Table printed, now show results and exit
end:
    # Print "Your percentage is: "
    li      $v0, 4              # Print the string ($v0 = 4)
    la      $a0, strYourPercent # Load the address of the string to print ($a0 = strYourPercent)
    syscall

    # Calculate the percentage
    mul     $s3, $s2, 100       # Multiply correct answers by 100
    div     $s3, $s3, $t1       # Divide by the total number of questions
    mflo    $s3                 # Move the result to $s3

    # Print the percentage
    li      $v0, 1              # Print an integer ($v0 = 1)
    move    $a0, $s3            # Move the integer to print to $a0
    syscall
    
    li      $v0, 4              # Print the string ($v0 = 4)
    la      $a0, strPercent     # Load the address of the string to print ($a0 = strPercent)
    syscall

    # Exit
    li      $v0, 4              # Print the string ($v0 = 4)
    la      $a0, strEnd         # Load the address of the string to print ($a0 = strEnd)
    syscall
    li      $v0, 10             # Exit ($v0 = 10)
    syscall