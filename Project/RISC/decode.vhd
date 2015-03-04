---------------------------------------------------
-- School:     University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer:   Josh Tombs
-- 
-- Create Date:    SPRING 2015
-- Module Name:    Decode Block
-- Project Name:   UMD_RISC16
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
-- Description:    Decode portion of Datapath
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decode is
    Port( INST_IN : in  STD_LOGIC_VECTOR (15 downto 0);
          DATA_OUT: out STD_LOGIC_VECTOR (39 downto 0));
end decode;

architecture Behavioral of decode is
    signal tmp : STD_LOGIC_VECTOR (39 downto 0) := (OTHERS => '0');
begin
    tmp(39 downto 36) <= INST_IN(15 downto 12);
    tmp(35 downto 32) <= INST_IN(11 downto 8);
    tmp(31 downto 28) <= INST_IN(7 downto 4);
    tmp(27 downto 20) <= x"00";
    tmp(19 downto 12) <= INST_IN(7 downto 0);
    tmp(11 downto 0)  <= INST_IN(11 downto 0);
    
    DATA_OUT <= tmp;
end Behavioral;

