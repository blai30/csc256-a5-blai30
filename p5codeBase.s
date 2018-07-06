.data
  expVal23:    .asciiz  "Expected Value : 23  Your Value : "
  expVal21:    .asciiz  "Expected Value : 21  Your Value : "
  endl:        .asciiz  "\n"

.text

# #
# int getDigit(int number);
# List Used Registers Here:
#
# #
getDigit:
  li $t0, 0
  li $t9, 10
  bge  $a0, $t8, else   # if (number < 10)
  move $t0, $a0
  j update
  else:
  rem  $t8, $a0, 10     # number % 10
  div  $t7, $a0, 10     # number / 10
  add  $t0, $t8, $t7    # sum = $t0 + $t1
  update:
  add $v1, $0, $t0
  jr $ra

##
# int sumOfDoubleEvenPlace(int number);
# List Used Registers Here:
# sum --> $s0
# digit --> $s1
# 
##
sumOfDoubleEvenPlace:
  addi $sp, $sp, -12
  sw $s0, ($sp)
  sw $s1, 4($sp)
  sw $s4, 8($sp)
  sw $ra, 12($sp)

  li $s0, 0
  li $t6, 10
  li $t5, 100

  move $s4, $a0
  div $s4, $s4, $t6     # number = number / 10

  ble $s4, $0, endloop  # while (number > 0)
  wloop:
  rem $s1, $s4, $t6     # digit = (number % 10)
  mul $t7, $s1, 2       # (digit*2)

  add $a0, $0, $t7
  jal getDigit          # sum += getDigit(digit*2)
  add $s0, $s0, $v1

  div $s4, $s4, $t5     # number = number/100

  bgt $s4, $0, wloop    # while (number > 10)

  endloop:
  add $v0, $0, $s0
  lw $ra, 12($sp)
  lw $s4, 8($sp)
  lw $s1, 4($sp)
  lw $s0, ($sp)
  addi $sp, $sp, 12
  jr $ra


main:
  li $s0, 89744563  # int test1 = 89744563;
  li $s1, 98756421  # int test2 = 98756421;
  li $s2, 0         # int result1 = 0;
  li $s3, 0         # int result2 = 0;


  # code for first function call

  add $a0, $0, $s0
  jal sumOfDoubleEvenPlace
  add $s2, $0, $v0 

  la   $a0, expVal23     
  addi $v0, $0, 4     
  syscall             

  move $a0, $s2       
  addi $v0, $0, 1     
  syscall             

  la   $a0, endl      
  addi $v0, $0, 4     
  syscall

   # code for first function call

  add $a0, $0, $s1
  jal sumOfDoubleEvenPlace
  add $s3, $0, $v0 

  la   $a0, expVal21     
  addi $v0, $0, 4     
  syscall             

  move $a0, $s3       
  addi $v0, $0, 1     
  syscall             

  la   $a0, endl      
  addi $v0, $0, 4     
  syscall

  li $v0, 10
  syscall
