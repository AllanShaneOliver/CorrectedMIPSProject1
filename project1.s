.data
list: .space 12 #can store 1000 characters into a string named "list"

.text
.globl main

main:
  #li $v0, 4 #prints input statement
  #la $a0, input
  li $v0, 8 #reads strings into list string
  la $a0, list
  li $a1, 11 #input no more than 10 characters
  syscall
  move $t1, $a0

li $s1, '0' #character 0
li $s2, '9' #character 9
li $t4, 'a' #character a - lower boundary for base 29
li $t5, 's' #character s - upper boundary for base 29
li $t6, 'A' #character A - lower boundary for base 29
li $t7, 'S' #character S - upper boundary for base 29
li $s3, 0 #result variable
li $s4, 0 #variable which will print the final result

begin:
  li $t2, 0 #$i=0;
  li $s5, 11 #exit condition - exit loop if at 10th character

loop:
    beq $s5, $t2, afterloop #jump to afterloop after 10th character is reached
    addi $t2, $t2, 1 #add 1 after each iteration, i++;
    lb $t0, 0($t1) #loads byte of user input into $t0
    addi $t1, $t1, 1

L1: blt $t0, $s1, L2 #test the next condition if this falls through
    bgt $t0, $s2, L2 #move to L2 if this isn't true
    addi $s3, $t0, -48 #subtract 48, place result into $s3
    add $s4, $s4, $s3
    j FN

L2: blt $t0, $t4, L3 #test the next condition if this falls through
    bgt $t0, $t5, L3 #move to L3 if this isn't true
    addi $s3, $t0, -87 #subtract 87, place result into $s3
    add $s4, $s4, $s3
    j FN

L3: blt $t0, $t6, EL #test the next condition if this falls through
    bgt $t0, $t7, EL #move to ELSE if this isn't true
    addi $s3, $t0, -55 #subtract 55, place result into $s3
    add $s4, $s4, $s3
    j FN

EL: add $s3, $zero, $zero
    add $s4, $s4, $s3
FN: j loop

afterloop:
  li $v0, 1
  move $a0, $s4
  syscall

exit:
  jr $ra #exit program
