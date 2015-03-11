---------------------------------------------------
-- School:     University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer:   Josh Tombs
-- 
-- Create Date:    SPRING 2015
-- Module Name:    Execute Block
-- Project Name:   UMD_RISC16
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
-- Description:    Execute portion of Datapath
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity execute is
	Port( CLK    : in STD_LOGIC;
			OP1_IN : in STD_LOGIC_VECTOR(15 downto 0);
			OP2_IN : in STD_LOGIC_VECTOR(15 downto 0);
			OPCODE : in STD_LOGIC_VECTOR(3 downto 0);
			CCR_OUT: out STD_LOGIC_VECTOR(3 downto 0);
		   D_OUT  : out STD_LOGIC_VECTOR(15 downto 0));
end execute;

architecture Structural of execute is
	signal ALU_RESULT  : STD_LOGIC_VECTOR(15 downto 0);
	signal LDST_RESULT : STD_LOGIC_VECTOR(15 downto 0);
	signal HIGH : STD_LOGIC := '1';
begin

	ALU: entity work.ALU
	PORT MAP( CLK      => CLK,
         RA       => OP1_IN,
         RB       => OP2_IN,
         OPCODE   => OPCODE,
         CCR      => CCR_OUT,
         ALU_OUT  => ALU_RESULT,
         LDST_OUT => LDST_RESULT);
	
	RESULT_REG: entity work.reg16
	PORT MAP( CLK => CLK,
				 D   => ALU_RESULT,
			    ENB => HIGH,
				 Q   => D_OUT);
			
end Structural;
