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
    Port( CLK     : in  STD_LOGIC;
          INST_IN : in  STD_LOGIC_VECTOR (15 downto 0);
          DATA_OUT: out STD_LOGIC_VECTOR (43 downto 0));
end decode;

architecture Behavioral of decode is
    signal tmp : STD_LOGIC_VECTOR (43 downto 0) := (OTHERS => '0');
begin
    tmp(43 downto 40) <= INST_IN(15 downto 12);
    tmp(39 downto 36) <= INST_IN(11 downto 8);
    tmp(35 downto 32) <= INST_IN(7 downto 4);
    tmp(31 downto 24) <= x"00";
    tmp(23 downto 16) <= INST_IN(7 downto 0);
    tmp(15 downto 4)  <= x"000";
    tmp(3 downto 0)   <= INST_IN(7 downto 4);
    PROCESS(CLK)
    BEGIN
        IF(CLK'EVENT AND CLK = '0') THEN
            DATA_OUT <= tmp;
        END IF;
    END PROCESS;
end Behavioral;

