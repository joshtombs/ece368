---------------------------------------------------
-- School:     University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer:   Josh Tombs
-- 
-- Create Date:    SPRING 2015
-- Module Name:    instr_reg_re
-- Project Name:   UMD_RISC16
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
-- Description:    Create edge triggered register
--     with an enable of same width as UMDRISC instructions.
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.UMDRISC_PKG.all;

entity instr_reg_re is
    PORT ( D         : in  STD_LOGIC_VECTOR(INSTR_LENGTH-1 DOWNTO 0) ;
           ENB, CLK  : in  STD_LOGIC ;
           Q         : out STD_LOGIC_VECTOR(INSTR_LENGTH-1 DOWNTO 0) ) ;
end instr_reg_re;

architecture Behavioral of instr_reg_re is
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
