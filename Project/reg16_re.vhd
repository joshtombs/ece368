---------------------------------------------------
-- School:     University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer:   Josh Tombs
-- 
-- Create Date:    SPRING 2015
-- Module Name:    Reg16
-- Project Name:   UMD_RISC16
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
-- Description:    Create 16 bit edge triggered register
--     with an enable that reads on rising edge.
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg16_re is
    GENERIC ( N : INTEGER := 16 ) ;
    PORT ( D         : in  STD_LOGIC_VECTOR(N-1 DOWNTO 0) ;
           ENB, CLK  : in  STD_LOGIC ;
           Q         : out STD_LOGIC_VECTOR(N-1 DOWNTO 0) ) ;
end reg16_re;

architecture Behavioral of reg16_re is
begin
    PROCESS (CLK)
    BEGIN
        IF (CLK'EVENT AND CLK = '1') THEN
            IF ENB = '1' THEN
                Q <= D ;
            END IF;
        END IF;
    END PROCESS;
end Behavioral;
