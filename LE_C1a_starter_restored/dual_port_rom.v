////////////////////////////////////////////////////////////////////////////////////////////////////
// Filename: dual_port_rom.v
// Author:	K Cooper 
// Created:	 3 Oct 2019
// Version:  1
// Description: rom for OpA and OpB
//
//
//  You must not modify any part of this file.
//
////////////////////////////////////////////////////////////////////////////////////////////////////
 
module dual_port_rom (qA, qB, addrA, addrB);
   input [2:0] addrA, addrB;
   output [7:0] qA, qB;

   reg [7:0] rom [0:7];

	// Specify the ROM contents using the $readmemh command.
   // You must modify the contents of the rom.txt file to change the ROM contents.	
   initial $readmemh("rom.txt", rom);

   assign qA=rom[addrA];
   assign qB=rom[addrB];



endmodule