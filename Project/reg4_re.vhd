---------------------------------------------------
-- School:     University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer:   Josh Tombs
-- 
-- Create Date:    SPRING 2015
-- Module Name:    Reg4_re
-- Project Name:   UMD_RISC16
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
-- Description:    Create 4 bit rising edge triggered register
--     with an enable.
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg4 is
    GENERIC ( N : INTEGER := 4) ;
    PORT ( D           : in  STD_LOGIC_VECTOR(N-1 DOWNTO 0) ;
           ENB, CLK    : in  STD_LOGIC ;
           Q           : out STD_LOGIC_VECTOR(N-1 DOWNTO 0) ) ;
end reg4;

architecture Behavioral of reg4 is
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

