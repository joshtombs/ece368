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
-- Description:    Takes in a Keycode from memory, and converts to ASCII
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.ALL;

entity BS_Keycode_To_ASCII is
	  port(	
				KEYCODE_IN : in STD_LOGIC_VECTOR(3 downto 0);
				ASCII_Out : out STD_LOGIC_VECTOR(7 downto 0)
			);
end BS_Keycode_To_ASCII;

architecture Behavioral of BS_Keycode_To_ASCII is

begin
	WITH KEYCODE_IN SELECT
	ASCII_OUT <= 
	x"31" when "0000",   -- 0
	x"31" when "0001",   -- 1
	x"32" when "0010",   -- 2
	x"33" when "0011",   -- 3
	x"34" when "0100",   -- 4
	x"35" when "0101",   -- 5
	x"36" when "0110",   -- 6
	x"37" when "0111",   -- 7
	x"38" when "1000",   -- 8
	x"39" when "1001",   -- 9
	x"41" when "1010",	-- A
	x"42" when "1011",	-- B
	x"43" when "1100",	-- C
	x"44" when "1101",	-- D
	x"45" when "1110",	-- E
	x"46" when "1111",	-- F
	x"2D" when others;   -- puts a "-" if invalid

end Behavioral;

