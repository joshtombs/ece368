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
-- Description:    Create edge triggered register
--     with an enable of same width as UMDRISC data.
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.UMDRISC_PKG.all;

entity data_reg is
    PORT ( D         : in  STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0) ;
           ENB, CLK  : in  STD_LOGIC ;
           Q         : out STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0) ) ;
end data_reg;

architecture Behavioral of data_reg is
begin
    PROCESS (CLK)
    BEGIN
        IF (CLK'EVENT AND CLK = '0') THEN
            IF ENB = '1' THEN
                Q <= D ;
            END IF;
        END IF;
    END PROCESS;
end Behavioral;
