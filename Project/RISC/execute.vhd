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

begin


end Structural;

