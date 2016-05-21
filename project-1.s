.globl main
.globl addition
.globl multiplication
.globl division
.globl mod
.globl Power
.globl CLR
.globl MS
.globl MC
.globl start
.globl PowerLoop
.globl lp
.globl asciiLoop
.globl Solve_P_Loop
.globl PCheck
.globl Solve

.data

newline:	.asciiz  "\n"

.text

main:
	add $s0, $0, $0		#this is the stored area of memory for the MR MC, and MS commands	
	add $s5, $0, $0		#register used to keep track of whether it is the first calculation or not, if it is greater then 0 then it is past the first calculation
	add $t7, $0, $0
	lui $t7, 0x1000
        addi $t7, $t7, 196
	addi $t1, $0, 1
	sw $t1, 0($t7)
	add $0, $0, $0

start:
	add $a0, $0, $0		#resetting the registeres for multiple calculations
	add $t0, $0, $0
	add $t1, $0, $0
	add $t2, $0, $0
	add $t3, $0, $0
	add $t4, $0, $0
	add $t5, $0, $0
	add $t6, $0, $0
	add $t7, $0, $0
	add $s1, $0, $0
	add $s2, $0, $0
	add $s3, $0, $0
	add $s4, $0, $0
	add $s5, $0, $0
	add $s6, $0, $0
	add $s7, $0, $0	

	addi $a1, $0, 100	#prints a newline	
	add $a0, $0, $0
	lui $a0, 0x1000
	addi $v0, $0, 4
	syscall
	
	addi $a0, $a0, 100 
	addi $v0, $0, 8
	syscall			#reads in the input string
	
	add $s1, $a0, $0	#sets up the memory address for the to be converted 
	add $t7, $0, $0
	lui $t7, 0x1000
	addi $t7, $t7, 196
	
convert:
	jal AsciiConvert
	addi $t3, $0, 10
		
	add $a0, $0, $v0
	
	bne $t1, $t3, convert
	add $0, $0, $0

	sw $0, 0($t7)	#hopefully this puts a null character right before the new line
        add $0, $0, $0
        addi $t7, $t7, 4

	addi $t3, $0, 10
	sw $t3, 0($t7)
	add $0, $0, $0

Solve:				#starts the process of iterating through the string three times in order to solve the equation in the correct order
	add $s7, $0, $0
	add $s6, $0, $0
	lui $s7, 0x1000
	addi $s7, $s7, 200
	lui $s6, 0x1000
	addi $s6, $s6, 200
	lw $t1, 0($s7)
	add $0, $0, $0
	bne $t1, $0, reset
	add $0, $0, $0

	lw $t2, -4($s7)
        add $0, $0, $0


Solve_P_Loop:			#iterates through the string and solves all of the power operations
	add $t1, $0, $0
	lw $t1 0($s7)
	add $0, $0, $0

	add $t2, $0, $0
	lw $t2, -4($s6)
        add $0, $0, $0

        bne $t2, $0, no_P_sign
        add $0, $0, $0

	addi $t3, $0, 10
	beq $t1, $t3, Solve_Mul_Div
	add $0, $0, $0
	addi $t2, $0, 94
	beq $t1, $t2, Power
	add $0, $0, $0

no_P_sign:
	sw $t1, 0($s6)
	add $0, $0, $0
	addi $s7, $s7, 4
	addi $s6, $s6, 4
	j Solve_P_Loop
	add $0, $0, $0

Solve_Mul_Div:			#iterates through new string and solves all of the divisions, multiplications, and mods

	addi $t3, $0, 10	#adds a newline character to the end of the new string
	sw $t3, 0($s6)
	add $0, $0, $0	

	add $s7, $0, $0
        add $s6, $0, $0
        lui $s7, 0x1000
        addi $s7, $s7, 200
        lui $s6, 0x1000
        addi $s6, $s6, 200
Solve_M_D_Loop:
        add $t1, $0, $0
        lw $t1 0($s7)
        add $0, $0, $0

	add $t2, $0, $0
	lw $t2, -4($s6)
	add $0, $0, $0	
	
	add $0, $0, $0
	bne $t2, $0, no_MDM_sign
	add $0, $0, $0

        addi $t3, $0, 10
        beq $t1, $t3, Solve_Add_Sub
        add $0, $0, $0

        addi $t2, $0, 42
        beq $t1, $t2, multiplication
        add $0, $0, $0

	addi $t2, $0, 47
        beq $t1, $t2, division
        add $0, $0, $0

	addi $t2, $0, 37
        beq $t1, $t2, mod
        add $0, $0, $0

no_MDM_sign:
        sw $t1, 0($s6)
        add $0, $0, $0
        addi $s7, $s7, 4
        addi $s6, $s6, 4
        j Solve_M_D_Loop
        add $0, $0, $0
	
Solve_Add_Sub:			#iterates through the remaining string and solves the additions and subtractions

	addi $t3, $0, 10        #adds a newline character to the end of the new string
        sw $t3, 0($s6)
        add $0, $0, $0

	add $s7, $0, $0
        add $s6, $0, $0
        lui $s7, 0x1000
        addi $s7, $s7, 200
        lui $s6, 0x1000
        addi $s6, $s6, 200

Solve_A_S_Loop:
        add $t1, $0, $0
        lw $t1 0($s7)
        add $0, $0, $0

	add $t2, $0, $0
	lw $t2, -4($s6)	#checks to make sure that the previous word was a null, if it was then the current word will be an operator or newline
        add $0, $0, $0
    
	bne $t2, $0, no_AS_sign
        add $0, $0, $0

        addi $t3, $0, 10
        beq $t1, $t3, Solve_Done
        add $0, $0, $0

        addi $t2, $0, 43
        beq $t1, $t2, addition
        add $0, $0, $0

        addi $t2, $0, 45
        beq $t1, $t2, subtraction
        add $0, $0, $0

no_AS_sign:
        sw $t1, 0($s6)
        add $0, $0, $0
        addi $s7, $s7, 4
        addi $s6, $s6, 4
        j Solve_A_S_Loop
        add $0, $0, $0

Solve_Done:
	addi $t3, $0, 10        #adds a newline character to the end of the new string
        sw $t3, 0($s6)
        add $0, $0, $0
	
	beq $0, $s5 first
	add $0, $0, $0

	lw $a0, -8($s6)		#displays the answer, ran if there was a carry over argument from a previous calculation
	add $0, $0, $0
	addi $v0, $0, 1
	syscall
	add $0, $0, $0

	j start
	add $0, $0, $0
	
first:				#ran if it is the first time the calculator is ran, so there was no carry over answer from last time. It also prints out the answer
	addi $s5, $0, 1
	lw $a0, -8($s6)
	add $0, $0, $0
	addi $v0, $0, 1
	syscall
	sw $a0, -12($s6)
	add $0, $0, $0
	j start
	add $0, $0, $0
	
reset:
	add $s5, $0, $0
	j Solve_P_Loop
	add $0, $0, $0

AsciiConvert:
        addi $s2, $0, 0
        add $v0, $0, $0 
lp:
        lbu $t1, ($s1)       #load char  into t1
	addi $t3, $0, 10
      
	add $0, $0, $0
        beq $t1, $t3, stop     #New line  found
        add $0, $0, $0
    
	addi $t3, $0, 48	#checks to see if the character is an acscii character below 48, such as an operator like +,-,*,/, %
	slt $t4, $t1, $t3
	bne $t4, $0, symbol
	add $0, $0, $0

	addi $t3, $0, 57	#checks if the ascii value is above the value for 9
	slt $t4, $t3, $t1
	bne $t4, $0, symbol
        add $0, $0, $0

	addi $t1, $t1, -48   #converts t1's ascii value to the actual number
	addi $t3, $0, 10
        addi $t4, $0, 1		#multiplies the sum by 10
        add $t5, $s2, $0
asciiLoop:
        add $t5, $t5, $s2
        addi $t4, $t4, 1
        bne $t4, $t3, asciiLoop
        add $0, $0, $0
        add $s2, $t5, $0

        add $s2, $s2, $t1    #sum + the new number
        addi $s1, $s1, 1     
        add $v0, $s2, $0
	j lp                
        add $0, $0, $0
stop:				#this is the end of the string, so it saves the last number
        add $v0, $s2, $0
	addi $t7, $t7, 4
	sw $v0, 0($t7)
	add $0, $0, $0
	addi $t7, $t7, 4
	addi $t6, $0, 10
	sw $t6, 0($t7)
	add $0, $0, $0 
        jr $ra
        add $0, $0, $0

symbol:
	addi $t6, $0, 77
	beq $t6, $t1, memory	#checks to see if the first char is an M, goes to the memory subroutine if it is
	add $0, $0, $0
	addi $t6, $0, 67
	beq $t6, $t1, CLR	#checks to see if the first char is a C, goes to the CLR subroutine if it is
	add $0, $0, $0
	bne $v0, $0, integer	#goes to integer subroutine if there was a number read in during the last loop, otherwise it just saves a null char and then the operator
	add $0, $0, $0
	addi $t7, $t7, 4
        sw $0, 0($t7)
        add $0, $0, $0
        addi $t7, $t7, 4
        sw $t1, 0($t7)
        add $0, $0, $0
        addi $s1, $s1, 1
        jr $ra
        add $0, $0, $0

integer:
	addi $t7, $t7, 4	#the following code adds the number and then a null character and then the ascii code for the operator at the converted memory address
	sw $v0, 0($t7)
	add $0, $0, $0
	addi $t7, $t7, 4
	sw $0, 0($t7)
	add $0, $0, $0
	addi $t7, $t7, 4
	sw $t1, 0($t7)
	add $0, $0, $0
	addi $s1, $s1, 1
	jr $ra
	add $0, $0, $0


memory:
	addi $s1, $s1, 1
	lbu $t1, 0($s1)
	add $0, $0, $0

	addi $t6, $0, 67	#MC was typed, so it has to clear the calculator's stored value
	beq $t1, $t6, MC
	add $0, $0, $0

	addi $t6, $0, 83	#MS was typed, so it goes to the subroutine to store the last value in $s0
	beq $t1, $t6, MS
	add $0, $0, $0
				#else it has to be MR, so it will store the saved value of $s0 into v0 and start the loop again
	add $v0, $0, $s0
	add $s2, $0, $s0
	addi $s1, $s1, 1
	j lp
	add $0, $0, $0	

addition:			#start of the addition subroutine for the first two argument registers
        add $0, $0, $0
	lw $a0, -8($s6)
        add $0, $0, $0
        lw $a1, 4($s7)
        add $0, $0, $0

	add $v0, $a0, $a1
	
	sw $v0, -8($s6)
        add $0, $0, $0
        addi $s6, $s6, -4
        addi $s7, $s7, 8
        j Solve_A_S_Loop
        add $0, $0, $0

subtraction:			#start of the subtraction subroutine for the first two argument registers
	lw $a0, -8($s6)
        add $0, $0, $0
        lw $a1, 4($s7)
        add $0, $0, $0

	sub $v0, $a0, $a1
	
	sw $v0, -8($s6)
        add $0, $0, $0
        addi $s6, $s6, -4
        addi $s7, $s7, 8
        j Solve_A_S_Loop
        add $0, $0, $0

multiplication:		#start of the multiplication subroutine for the first two argument registers
	lw $a0, -8($s6)
        add $0, $0, $0
        lw $a1, 4($s7)
        add $0, $0, $0

	beq $a0, $0, zero_mul
	add $0, $0, $0

	beq $a1, $0, zero_mul
	add $0, $0, $0

	addi $t0, $0, 0	#start of the multiplication process
        add $t1, $0, $0
multLoop1:
        add $t1, $t1, $a0
        addi $t0, $t0, 1
        bne $t0, $a1, multLoop1
	add $0, $0, $0
	
	sw $t1, -8($s6)
        add $0, $0, $0
        addi $s6, $s6, -4
        addi $s7, $s7, 8
        j Solve_M_D_Loop
        add $0, $0, $0
	
zero_mul:			#case that it is multiplication by 0
	add $t1, $0, $0
	 sw $t1, -8($s6)
        add $0, $0, $0
        addi $s6, $s6, -4
        addi $s7, $s7, 8
	j Solve_M_D_Loop
	add $0, $0, $0

division:			#start of the division subroutine
	lw $a0, -8($s6)
        add $0, $0, $0
        lw $a1, 4($s7)
        add $0, $0, $0

	beq $a0, $0, zero_top
	add $0, $0, $0

	addi $t0, $0, 17	#done to prepare for the loop for division operation	
	addi $t2, $0, 16	#start of a loop to shift the divisor to the left 16 times inorder to put it in the left half of the register
loop1:
	sll $a1, $a1, 1
	addi $t2, $t2, -1
	bne $0, $t2, loop1
	add $0, $0, $0		#the divisor should now be in the left half of the register 
	add $t1, $0, $0		#sets the quotient register to an initial value of 0 	
   
top1:
	sub $a0, $a0, $a1	#subtracts the divisor register from the remainder register and placers the result in the remainder register
	bgez $a0, greater1	#branches down to a different part of the routine if the remainder is greater then or equal to zero. If it is less then it keeps going
	add $0, $0, $0
	add $a0, $a0, $a1	#adds the remainder register and the divisor register togther ands places it back into the remainder register
	sll $t1, $t1, 1		#shifts the integer in the quotient register to the left one digit
	srl $a1, $a1, 1		#shifts the integer in the divisor register over to the right one digit
	addi $t0, $t0, -1       #part of the loop, marks one iteration
        bne $0, $t0, top1	#if the loop is done then it keeps on going back to main, if not then it returns to the top of division and loops again
	
	sw $t1, -8($s6)
        add $0, $0, $0
        addi $s6, $s6, -4
        addi $s7, $s7, 8
        j Solve_M_D_Loop
        add $0, $0, $0	

greater1:
	sll $t1, $t1, 1		#shifts the quotient register to the left one bit
	addi $t1, $t1, 1	#sets the new bit to 1
	srl $a1, $a1, 1		#shifts the divsior register over by one bit
	addi $t0, $t0, -1	#part of the loop, marks the end of one iteration
	bne $0, $t0, top1	#if the loop is done then it keeps on going back to main, if not then it returns to the top of division and loops again
	add $0, $0, $0

	sw $t1, -8($s6)
        add $0, $0, $0
        addi $s6, $s6, -4
        addi $s7, $s7, 8
        j Solve_M_D_Loop
        add $0, $0, $0

zero_top:			#case that it is zero divided by a number
	sw $0, -8($s6)
        add $0, $0, $0
        addi $s6, $s6, -4
        addi $s7, $s7, 8
	j Solve_M_D_Loop
	add $0, $0, $0



mod:				#start of modulo subroutine
	lw $a0, -8($s6)
        add $0, $0, $0
        lw $a1, 4($s7)
        add $0, $0, $0


moddone1:                          #breakpoint to check that the correct numbers were input into the correct registers
        addi $t0, $0, 17        #done to prepare for the loop for division operation

        addi $t2, $0, 16       #start of a loop to shift the divisor to the left 16 times inorder to put it in the left half of the register
modloop1:
        sll $a1, $a1, 1
        addi $t2, $t2, -1
        bne $0, $t2, modloop1
        add $0, $0, $0          #the divisor should now be in the left half of the register
        add $t1, $0, $0         #sets the quotient register to an initial value of 0

modtop1:
        sub $a0, $a0, $a1       #subtracts the divisor register from the remainder register and placers the result in the remainder register
        bgez $a0, modgreater1       #branches down to a different part of the routine if the remainder is greater then or equal to zero. If it is less then it keeps going
        add $0, $0, $0
        add $a0, $a0, $a1       #adds the remainder register and the divisor register togther ands places it back into the remainder register
        sll $t1, $t1, 1         #shifts the integer in the quotient register to the left one digit
        srl $a1, $a1, 1         #shifts the integer in the divisor register over to the right one digit
        addi $t0, $t0, -1       #part of the loop, marks one iteration
        bne $0, $t0, modtop1       #if the loop is done then it keeps on going back to main, if not then it returns to the top of division and loops again
        
	sw $a0, -8($s6)
        add $0, $0, $0
        addi $s6, $s6, -4
        addi $s7, $s7, 8
	j Solve_M_D_Loop
        add $0, $0, $0

modgreater1:
        sll $t1, $t1, 1         #shifts the quotient register to the left one bit
        addi $t1, $t1, 1        #sets the new bit to 1
        srl $a1, $a1, 1         #shifts the divsior register over by one bit
        addi $t0, $t0, -1       #part of the loop, marks the end of one iteration
        bne $0, $t0, modtop1       #if the loop is done then it keeps on going back to main, if not then it returns to the top of division and loops again
        add $0, $0, $0
        add $v0, $0, $a0
        
	sw $a0, -8($s6)
        add $0, $0, $0
        addi $s6, $s6, -4
        addi $s7, $s7, 8
	j Solve_M_D_Loop
        add $0, $0, $0

Power:				#start of the power subroutine for first set of argument registers
	
	lw $a0, -8($s7)
	add $0, $0, $0
	lw $a1, 4($s7)
	add $0, $0, $0

	beq $0, $a1, zero_power		#there is a series of special cases for a power operation, an the code checks for that
	add $0, $0, $0

	beq $0, $a0, zero_base
	add $0, $0, $0

	addi $t1, $0, 1

	beq $a0, $t1, one_base
	add $0, $0, $0

	beq $a1, $t1, one_power
	add $0, $0, $0

	addi $t3, $0, 0		#start of the power process
        add $t2, $0, $0
        add $t4, $0, $a0
	add $t0, $0, $0
	add $t1, $0, $0

Pmultiply:
        addi $t0, $0, 1
        add $t1, $0, $a0
	addi $t3, $0, 1
	add $t5, $a0, $0
PowerLoop:
        add $t1, $t1, $a0
        addi $t0, $t0, 1
        bne $t0, $t5, PowerLoop
	add $0, $0, $0

	add $a0, $t1, $0
        addi $t3, $t3, 1
	addi $t0, $0, 1
        bne $t3, $a1, PowerLoop
        add $0, $0, $0

	sw $t1, -8($s6)
	add $0, $0, $0
	addi $s6, $s6, -4
	addi $s7, $s7, 8
	#add $v0, $t1, $0
PCheck:
	j Solve_P_Loop
	add $0, $0, $0


zero_power:			#The case that the power is 0, returns 1
	addi $t1, $0, 1
        sw $t1, -8($s6)
        add $0, $0, $0
        addi $s6, $s6, -4
        addi $s7, $s7, 8
	 j Solve_P_Loop
        add $0, $0, $0

zero_base:			#the case that the base is 0, saves 0
	add $t1, $0, $0
        sw $t1, -8($s6)
        add $0, $0, $0
        addi $s6, $s6, -4
        addi $s7, $s7, 8
        j Solve_P_Loop
        add $0, $0, $0

one_power:			#the case that the power is 1, it saves the base
	add $t1, $0, $a0
        sw $t1, -8($s6)
        add $0, $0, $0
        addi $s6, $s6, -4
        addi $s7, $s7, 8
        j Solve_P_Loop
        add $0, $0, $0

one_base:			#the case that the base is 1, saves a 1
	addi $t1, $0, 1
        sw $t1, -8($s6)
        add $0, $0, $0
        addi $s6, $s6, -4
        addi $s7, $s7, 8
        j Solve_P_Loop
        add $0, $0, $0



CLR:				#start of the clear subroutine
	add $a0, $0, $0		#clears the last answer at 0x10000196 as well
	add $a1, $0, $0
	add $a2, $0, $0
	add $v1, $0, $0
	addi $v0, $0, 1
	syscall
	add $t1, $0, $0
	add $t3, $0, $0
	lui $t1, 0x1000
	addi $t1, $t1, 196
	addi $s5, $0, 1
	sw $s5, 0($t1)
	add $0, $0, $0
	add $s5, $0, $0
	j start
	add $0, $0, $0

MS:				#start of the memory set subroutine
	lui $t0, 0x1000		# the last calculated answer is at 0x10000196, so it stores that word in $s0
        addi $t0, $t0, 196
        lw $s0, 0($t0)
	add $0, $0, $0
	j start
	add $0, $0, $0

MC:				#start of the memory clear subroutine
	add $s0, $0, $0		#it just clears the register $s0
	j start
	add $0, $0, $0
