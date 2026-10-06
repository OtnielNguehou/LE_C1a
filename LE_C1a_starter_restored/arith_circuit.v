////////////////////////////////////////////////////////////////////////////////////////////////////
// Filename: arith_circuit.v
// Author:	 KLC
// Created:	 3 Oct 2019
// Version:  4 (modified 18 Apr 2026, RCH)
// Description: The arithmetic circuit should take the operands OpA, OpB from the  
// ROM in the top level entity, and the inputs SW[9:7] from the DE10-Lite board 
// to select the operation.  The output result drives LEDs [7:0] on the DE10-Lite 
// board.
//
//  **************************************************
//  This file is the only Verilog file that you should modify6r66;pz.
//  It should be properly commented and formatted.
//  **************************************************
//
////////////////////////////////////////////////////////////////////////////////////////////////////

//Do not change the port declarations
module arith_circuit (result, OpA, OpB, opselect);
	input  [2:0] opselect;
	input  [7:0] OpA, OpB;
	output [7:0] result;

	// Replace this assign statement with your Verilog code.
	// The operation of the arithmetic circuit is defined in the specification.
	wire C0;
	wire [7:0] c;
	wire [7:0] Y;
	wire [7:0] X;
	//using the codes
	//mova(000) (A) C0 = 0
	//add(001) (A + B) C0 = 0
	//sub(010) (A - B) C0 = 1 everywhere else
	//negA(011) (-A)
	//negB(100) (-B)
	//subBA(101) (B - A)
	//the technology mapped output of C0 = opselect[2] + opselect[1]
	assign C0 = opselect[2] | opselect[1];
	//Y = 0 when opselect is mova(000) or negA(011) so Yor opeselect[0] and opselect[1]
	//Y = ~OpB when opselect is sub(010) or negB(100)
	//Y = OpB everywhere else
	assign Y = ((opselect==3'b000) || (opselect==3'b011)) ? {8{(opselect[1] ^ opselect[0])}}: ((opselect==3'b010) || (opselect==3'b100)) ? ~OpB : OpB;
					
	//X = 0 when opselect is negB(100) so when opselect[2]==1
	//X  = ~OpA when subBA(101) or negA(011)
	//X = OpA everywhere else
	assign X = ((opselect == 3'b011) || (opselect==3'b101)) ? ~OpA : (opselect==3'b100) ? {8{~opselect[2]}}: OpA;

	
	full_adder fa0(result[0], c[0],X[0],Y[0],C0);
	full_adder fa1 (result[1], c[1], X[1], Y[1], c[0]);
	full_adder fa2 (result[2], c[2], X[2], Y[2], c[1]);
	full_adder fa3 (result[3], c[3], X[3], Y[3], c[2]);
	full_adder fa4 (result[4], c[4], X[4], Y[4], c[3]);
	full_adder fa5 (result[5], c[5], X[5], Y[5], c[4]);
	full_adder fa6 (result[6], c[6], X[6], Y[6], c[5]);
	full_adder fa7 (result[7], c[7], X[7], Y[7], c[6]);
	
	
endmodule

module full_adder (sum,cout,a,b,cin);
	input a,b,cin;
	output sum,cout;
	assign sum = a^b^cin;
	assign cout = a&b |(cin & (a^b));
endmodule