.data
msun : .float 1.989e30 # Mass of the sun (kg)
melectron : .float 9.109e-31 # Mass of an electron (kg)

.text
.globl main

main:
    la $s0, msun
    lwc1 $f1, 0( $s0 )  # Load the mass of the sun into $f1 register 
                        #(In this case we use $f1 instead of $f0 just to differenciate floats and doubles more, but it's not composed of any special reason)
                        # Also, c1 represents the coprocessor 1, which is the floating point coprocessor
    la $s0, melectron
    lwc1 $f3, 0( $s0 )  # Load the mass of an electron into $f3 register

    add.s $f1, $f1, $f3 # Add the masses of the sun and the electron (in the $f1 register)

    mfc1 $t1, $f1       # Move the result (bits) from the $f1 register to the $t1 register, not actual conversion

    li $v0, 10          # Exit

    syscall