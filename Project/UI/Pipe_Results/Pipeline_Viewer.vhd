---------------------------------------------------
-- School:     University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer:   Brett Southworth
-- 
-- Create Date:    SPRING 2015
-- Module Name:    UMD_RISC16
-- Project Name:   Pipeline_Viewer
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
-- Description:    Takes 29 full instruction sets (fetch, decode ...)
--						 and stores in VGA_Buffer_Ram to display on VGA
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.ALL;


entity Pipeline_Viewer is
Port(
		CLK_IN  : in STD_LOGIC;
		RST     : in STD_LOGIC;
		ASCII_IN : in STD_LOGIC_VECTOR(7 downto 0);
		Fetch   : in STD_LOGIC_VECTOR(15 downto 0);
		Decode  : in STD_LOGIC_VECTOR(15 downto 0);
		OP      : in STD_LOGIC_VECTOR(15 downto 0);
		Execute : in STD_LOGIC_VECTOR(15 downto 0);
		WB      : in STD_LOGIC_VECTOR(15 downto 0);
		Data_Out : out STD_LOGIC_VECTOR(7 downto 0);
		ASCII_RD : out STD_LOGIC;
		ASCII_WRITE : out STD_LOGIC
		);
end Pipeline_Viewer;

architecture Structural of Pipeline_Viewer is
signal FetchD, DecodeD, OperandD, ExecuteD, WriteD : STD_LOGIC_VECTOR(15 downto 0);
signal IMux : STD_LOGIC_VECTOR(2 downto 0);
signal DMux : STD_LOGIC_VECTOR(1 downto 0);
signal ADDRA : STD_LOGIC_VECTOR(4 downto 0);
signal ADDRB : STD_LOGIC_VECTOR(4 downto 0);
signal Data_Out1, Data_Out2, Data_Out3, Data_Out4, Data_Out5, Data_Convert : STD_LOGIC_VECTOR(3 downto 0);
signal CLKA, CLKB, ASCII_Out,ASCII_OutTEST   : STD_LOGIC;
signal Data_OutTEST : STD_LOGIC_VECTOR(7 downto 0);

begin
ASCII_RD <= '1';
ASCII_WRITE <= '0';

-- Test **Ingore what is typed**
Data_OutTEST <= ASCII_IN;


U1: entity work.Viewer_control
port map(
			CLK => CLK_In,
			RST => RST,
			IMUX => IMux,
		   DMUX => DMux,
		   --ASCII_SEND => ASCII_Out,
		   ADDRA => ADDRA,
		   ADDRB => ADDRB,
		   CLKB => CLKB,
		   CLKA => CLKA
		  	);		

U2: entity work.F_Mem
port map(
			DinA => Fetch,
			WEA(0) => '1',
		   CLKB => CLKB,
		   CLKA => CLKA,
			AddrA => ADDRA,
			AddrB => ADDRB,
			Doutb => FetchD
         );
U3: entity work.D_Mem
port map(
			DinA => Decode,
			WEA(0) => '1',
		   CLKB => CLKB,
		   CLKA => CLKA,
			AddrA => ADDRA,
			AddrB => ADDRB,
		   Doutb => DecodeD
         );
U4: entity work.OP_Mem
port map(
			DinA => OP,
			WEA(0) => '1',
		   CLKB => CLKB,
		   CLKA => CLKA,
			AddrA => ADDRA,
			AddrB => ADDRB,
			Doutb => OperandD
         );
U5: entity work.E_Mem
port map(
			DinA => Execute,
			WEA(0) => '1',
		   CLKB => CLKB,
		   CLKA => CLKA,
			AddrA => ADDRA,
			AddrB => ADDRB,
			Doutb => ExecuteD
         );
U6: entity work.WB_Mem
port map(
			DinA => WB,
			WEA(0) => '1',
		   CLKB => CLKB,
		   CLKA => CLKA,
			AddrA => ADDRA,
			AddrB => ADDRB,
			Doutb => WriteD
         );
			
U7: entity work.MUXB4to1
port map(
			In0 => FetchD(3 downto 0),
			In1 => FetchD(7 downto 4),
			In2 => FetchD(11 downto 8),
			In3 => FetchD(15 downto 12) ,
			Sel => DMux,
			Output => Data_Out1
			);
U8: entity work.MUXB4to1
port map(
			In0 => DecodeD(3 downto 0),
			In1 => DecodeD(7 downto 4),
			In2 => DecodeD(11 downto 8),
			In3 => DecodeD(15 downto 12) ,
			Sel => DMux,
			Output => Data_Out2
			);
U9: entity work.MUXB4to1
port map(
			In0 => OperandD(3 downto 0),
			In1 => OperandD(7 downto 4),
			In2 => OperandD(11 downto 8),
			In3 => OperandD(15 downto 12) ,
			Sel => DMux,
			Output => Data_Out3
			);
U10: entity work.MUXB4to1
port map(
			In0 => ExecuteD(3 downto 0),
			In1 => ExecuteD(7 downto 4),
			In2 => ExecuteD(11 downto 8),
			In3 => ExecuteD(15 downto 12) ,
			Sel => DMux,
			Output => Data_Out4
			);
U11: entity work.MUXB4to1
port map(
			In0 => WriteD(3 downto 0),
			In1 => WriteD(7 downto 4),
			In2 => WriteD(11 downto 8),
			In3 => WriteD(15 downto 12) ,
			Sel => DMux,
			Output => Data_Out5
			);
U12: entity work.MUXB5to1
port map(
			In0 => Data_Out1,
			In1 => Data_Out2,
			In2 => Data_Out3,
			In3 => Data_Out4,
			In4 => Data_Out5,
			Sel => IMUX,
			Output => Data_Convert
			);
U13: entity work.BS_KEYCODE_To_ASCII
port map(
			Keycode_In => Data_Convert,
			ASCII_Out => Data_Out
		   );			

end Structural;

