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
	wire A,B,An,Bn;
	wire [7:0] X,Y;
	//using the codes
	//mova(000) (A) 	 C0 = 0
	//add(001) (A + B) C0 = 0
	//sub(010) (A - B) C0 = 1 everywhere else
	//negA(011) (-A)
	//negB(100) (-B)
	//subBA(101) (B - A)
	//the technology mapped output of C0 = opselect[2] + opselect[1]
	assign C0 = opselect[2] | opselect[1];

	//A and B technology mapped
	//assign A = ~(opselect[2] | opselect[1]) | ~(~opselect[2] | ~opselect[0]);
	//assign B =  ~(opselect[1] | ~opselect[0]);
	//An Bn mapped
	//assign An = ~(~opselect[2] | ~opselect[0]) | ~(~opselect[1] | ~opselect[0]);
	//assign Bn = ~(~opselect[2] | opselect[0]) | ~(~opselect[1] | ~opselect[0]);

	//assign X =  OpA & ({8{A}} & {8{An}}) ;
	//assign Y =  ^ ({8{B}} & {8{Bn}});

	MuxA muxA(X, opselect, OpA);
	MuxB muxB(Y,opselect, OpB);
	full_adder fa0(result[0], c[0],X[0],Y[0],C0);
	full_adder fa1 (result[1], c[1], X[1], Y[1], c[0]);
	full_adder fa2 (result[2], c[2], X[2], Y[2], c[1]);
	full_adder fa3 (result[3], c[3], X[3], Y[3], c[2]);
	full_adder fa4 (result[4], c[4], X[4], Y[4], c[3]);
	full_adder fa5 (result[5], c[5], X[5], Y[5], c[4]);
	full_adder fa6 (result[6], c[6], X[6], Y[6], c[5]);
	full_adder fa7 (result[7], c[7], X[7], Y[7], c[6]);
	
	
endmodule


module full_adder (sum,cout,a,b,c);
    input a, b, c;
    output sum, cout;
    wire w1, w2, w3, w4, w5, w6, w7;
    assign w1 = ~(~a & b);
    assign w2 = ~(a & ~b);
    assign w3 = ~(a & b);
    assign w4 = ~(w1 & w2);
    assign w5 = ~(~w4 & c);
    assign w6 = ~(w4 & ~c);
    assign w7 = ~(w4 & c);
    assign sum = ~(w5 & w6);
    assign cout = ~(w3 & w7);
endmodule


module MuxA (result, opselect, OpA);
output [7:0] result;
input [2:0] opselect;
input [7:0] OpA;

assign result[0] = ~(~(opselect[2] & opselect[1] & opselect[0] & OpA[0]) & //mova 000 for A bit 0
~(~opselect[2] & ~opselect[1] & opselect[0] & OpA[0]) & //add 001 for A bit 0
~(~opselect[2] & opselect[1] & ~opselect[0] & OpA[0]) & //sub 010 for A bit 0
~(~opselect[2] & opselect[1] & opselect[0] & ~OpA[0]) & //negA 011 for A bit 0
~(opselect[2] & ~opselect[1] & ~opselect[0] & 1'b0) & //negB 100 for A bit 0
~(opselect[2] & ~opselect[1] & opselect[0] & ~OpA[0])); //subBA 101 for A bit 0

assign result[1] = ~(~(opselect[2] & opselect[1] & opselect[0] & OpA[1]) & //mova 000 for A bit 1
~(~opselect[2] & ~opselect[1] & opselect[0] & OpA[1]) & //add 001 for A bit 1
~(~opselect[2] & opselect[1] & ~opselect[0] & OpA[1]) & //sub 010 for A bit 1
~(~opselect[2] & opselect[1] & opselect[0] & ~OpA[1]) & //negA 011 for A bit 1
~(opselect[2] & ~opselect[1] & ~opselect[0] & 1'b0) & //negB 100 for A bit 1
~(opselect[2] & ~opselect[1] & opselect[0] & ~OpA[1])); //subBA 101 for A bit 1

assign result[2] = ~(~(opselect[2] & opselect[1] & opselect[0] & OpA[2]) & //mova 000 for A bit 2
~(~opselect[2] & ~opselect[1] & opselect[0] & OpA[2]) & //add 001 for A bit 2
~(~opselect[2] & opselect[1] & ~opselect[0] & OpA[2]) & //sub 010 for A bit 2
~(~opselect[2] & opselect[1] & opselect[0] & ~OpA[2]) & //negA 011 for A bit 2
~(opselect[2] & ~opselect[1] & ~opselect[0] & 1'b0) & //negB 100 for A bit 2
~(opselect[2] & ~opselect[1] & opselect[0] & ~OpA[2])); //subBA 101 for A bit 2

assign result[3] = ~(~(opselect[2] & opselect[1] & opselect[0] & OpA[3])& //mova 000 for A bit 3
~(~opselect[2] & ~opselect[1] & opselect[0] & OpA[3]) & //add 001 for A bit 3
~(~opselect[2] & opselect[1] & ~opselect[0] & OpA[3]) & //sub 010 for A bit 3
~(~opselect[2] & opselect[1] & opselect[0] & ~OpA[3]) & //negA 011 for A bit 3
~(opselect[2] & ~opselect[1] & ~opselect[0] & 1'b0) & //negB 100 for A bit 3
~(opselect[2] & ~opselect[1] & opselect[0] & ~OpA[3])); //subBA 101 for A bit 3

assign result[4] = ~(~(opselect[2] & opselect[1] & opselect[0] & OpA[4]) & //mova 000 for A bit 4
~(~opselect[2] & ~opselect[1] & opselect[0] & OpA[4]) & //add 001 for A bit 4
~(~opselect[2] & opselect[1] & ~opselect[0] & OpA[4]) & //sub 010 for A bit 4
~(~opselect[2] & opselect[1] & opselect[0] & ~OpA[4]) & //negA 011 for A bit 4
~(opselect[2] & ~opselect[1] & ~opselect[0] & 1'b0) & //negB 100 for A bit 4
~(opselect[2] & ~opselect[1] & opselect[0] & ~OpA[4])); //subBA 101 for A bit 4

assign result[5] = ~(~(opselect[2] & opselect[1] & opselect[0] & OpA[5]) & //mova 000 for A bit 5
~(~opselect[2] & ~opselect[1] & opselect[0] & OpA[5]) & //add 001 for A bit 5
~(~opselect[2] & opselect[1] & ~opselect[0] & OpA[5]) & //sub 010 for A bit 5
~(~opselect[2] & opselect[1] & opselect[0] & ~OpA[5]) & //negA 011 for A bit 5
~(opselect[2] & ~opselect[1] & ~opselect[0] & 1'b0) & //negB 100 for A bit 5
~(opselect[2] & ~opselect[1] & opselect[0] & ~OpA[5])); //subBA 101 for A bit 5

assign result[6] = ~(~(opselect[2] & opselect[1] & opselect[0] & OpA[6]) & //mova 000 for A bit 6
~(~opselect[2] & ~opselect[1] & opselect[0] & OpA[6]) & //add 001 for A bit 6
~(~opselect[2] & opselect[1] & ~opselect[0] & OpA[6]) & //sub 010 for A bit 6
~(~opselect[2] & opselect[1] & opselect[0] & ~OpA[6]) & //negA 011 for A bit 6
~(opselect[2] & ~opselect[1] & ~opselect[0] & 1'b0) & //negB 100 for A bit 6
~(opselect[2] & ~opselect[1] & opselect[0] & ~OpA[6])); //subBA 101 for A bit 6

assign result[7] = ~(~(opselect[2] & opselect[1] & opselect[0] & OpA[7]) & //mova 000 for A bit 7
~(~opselect[2] & ~opselect[1] & opselect[0] & OpA[7]) & //add 001 for A bit 7
~(~opselect[2] & opselect[1] & ~opselect[0] & OpA[7]) & //sub 010 for A bit 7
~(~opselect[2] & opselect[1] & opselect[0] & ~OpA[7]) & //negA 011 for A bit 7
~(opselect[2] & ~opselect[1] & ~opselect[0] & 1'b0) & //negB 100 for A bit 7
~(opselect[2] & ~opselect[1] & opselect[0] & ~OpA[7])); //subBA 101 for A bit 7
endmodule


module MuxB(result,opselect,OpB);
	input [2:0] opselect;
	output[7:0] result;
	input [7:0] OpB;
	wire ops0n, ops1n, ops2n, w3, w4, w5, w6, w7, w8, w9;
	wire 
	
	not n1(ops0n,opselect[0]);
	not n2(ops1n,opselect[1]);
	not n3(ops2n,opselect[2]);
	
	//result[0]
	nand n4(w4,ops2n,ops1n,ops0n,1'b0);//000
	nand n5(w5,ops2n,ops1n,opselect[0],OpB[0]);//001
	nand n6(w6,ops2n,opselect[1],ops0n,~OpB[0]);//010
	nand n7(w7,ops2n,opselect[1],opselect[0],1'b0);//011
	nand n8(w8,opselect[2],ops1n,ops0n,~OpB[0]);//100
	nand n9(w9,opselect[2],ops1n,opselect[0],OpB[0]);//101
	
	nand n10(result[0],w4,w5,w6,w7,w8,w9);
	
	//result[1]
	nand n14(w4,ops2n,ops1n,ops0n,1'b0);//000
	nand n15(w5,ops2n,ops1n,opselect[0],OpB[1]);//001
	nand n16(w6,ops2n,opselect[1],ops0n,~OpB[1]);//010
	nand n17(w7,ops2n,opselect[1],opselect[0],1'b0);//011
	nand n18(w8,opselect[2],ops1n,ops0n,~OpB[1]);//100
	nand n19(w9,opselect[2],ops1n,opselect[0],OpB[1]);//101
	
	nand n110(result[1],w4,w5,w6,w7,w8,w9);
	
	//result[2]
	nand n42(w4,ops2n,ops1n,ops0n,1'b0);//000
	nand n11(w5,ops2n,ops1n,opselect[0],OpB[2]);//001
	nand n62(w6,ops2n,opselect[1],ops0n,~OpB[2]);//010
	nand n72(w7,ops2n,opselect[1],opselect[0],1'b0);//011
	nand n82(w8,opselect[2],ops1n,ops0n,~OpB[2]);//100
	nand n92(w9,opselect[2],ops1n,opselect[0],OpB[2]);//101
	
	nand n102(result[2],w4,w5,w6,w7,w8,w9);
	
	//result[3]
	nand n34(w4,ops2n,ops1n,ops0n,1'b0);//000
	nand n35(w5,ops2n,ops1n,opselect[0],OpB[3]);//001
	nand n36(w6,ops2n,opselect[1],ops0n,~OpB[3]);//010
	nand n37(w7,ops2n,opselect[1],opselect[0],1'b0);//011
	nand n38(w8,opselect[2],ops1n,ops0n,~OpB[3]);//100
	nand n39(w9,opselect[2],ops1n,opselect[0],OpB[3]);//101
	
	nand n310(result[3],w4,w5,w6,w7,w8,w9);
	
	//result[4]
	nand n44(w4,ops2n,ops1n,ops0n,1'b0);//000
	nand n54(w5,ops2n,ops1n,opselect[0],OpB[4]);//001
	nand n64(w6,ops2n,opselect[1],ops0n,~OpB[4]);//010
	nand n75(w7,ops2n,opselect[1],opselect[0],1'b0);//011
	nand n84(w8,opselect[2],ops1n,ops0n,~OpB[4]);//100
	nand n94(w9,opselect[2],ops1n,opselect[0],OpB[4]);//101
	
	nand n104(result[4],w4,w5,w6,w7,w8,w9);
	
	//result[5]
	nand n52(w4,ops2n,ops1n,ops0n,1'b0);//000
	nand n55(w5,ops2n,ops1n,opselect[0],OpB[5]);//001
	nand n51(w6,ops2n,opselect[1],ops0n,~OpB[5]);//010
	nand n57(w7,ops2n,opselect[1],opselect[0],1'b0);//011
	nand n58(w8,opselect[2],ops1n,ops0n,~OpB[5]);//100
	nand n59(w9,opselect[2],ops1n,opselect[0],OpB[5]);//101
	
	nand n510(result[5],w4,w5,w6,w7,w8,w9);
	
	//result[6]
	nand n46(w4,ops2n,ops1n,ops0n,1'b0);//000
	nand n56(w5,ops2n,ops1n,opselect[0],OpB[6]);//001
	nand n66(w6,ops2n,opselect[1],ops0n,~OpB[6]);//010
	nand n78(w7,ops2n,opselect[1],opselect[0],1'b0);//011
	nand n86(w8,opselect[2],ops1n,ops0n,~OpB[6]);//100
	nand n96(w9,opselect[2],ops1n,opselect[0],OpB[6]);//101
	
	nand n106(result[6],w4,w5,w6,w7,w8,w9);
	
	//result[7]
	nand n74(w4,ops2n,ops1n,ops0n,1'b0);//000
	nand n89(w5,ops2n,ops1n,opselect[0],OpB[7]);//001
	nand n76(w6,ops2n,opselect[1],ops0n,~OpB[7]);//010
	nand n77(w7,ops2n,opselect[1],opselect[0],1'b0);//011
	nand n85(w8,opselect[2],ops1n,ops0n,~OpB[7]);//100
	nand n79(w9,opselect[2],ops1n,opselect[0],OpB[7]);//101
	
	nand n710(result[7],w4,w5,w6,w7,w8,w9);
endmodule