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
	
endmodule

module full_adder (sum,cout,a,b,cin);
	input a,b,cin;
	output sum,cout;
	assign sum = a^b^cin;
	assign cout = a&b |(cin & (a^b);
endmodule