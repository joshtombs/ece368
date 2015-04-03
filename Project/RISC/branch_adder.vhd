---------------------------------------------------
-- School:     University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer:   Josh Tombs
-- 
-- Create Date:    SPRING 2015
-- Module Name:    BRANCH_ADDER
-- Project Name:   UMD_RISC16
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
-- Description:    Take in PC Address and immediate value,
--     and add together to get branch offset. First bit is
--     used as a signed bit. (0 = positive, 1 = negative)
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use work.UMDRISC_PKG.all;

entity branch_adder is
    Port( PC_ADDR   : in  STD_LOGIC_VECTOR(INSTR_MEM_WIDTH-1 downto 0);
          IMMEDIATE : in  STD_LOGIC_VECTOR(15 downto 0);
          RESULT    : out STD_LOGIC_VECTOR(INSTR_MEM_WIDTH-1 downto 0));
end branch_adder;

architecture Dataflow of branch_adder is
    signal ADDED, SUBED : STD_LOGIC_VECTOR(INSTR_MEM_WIDTH-1 downto 0);
    constant zero : integer := 0;
begin
     ADDED <= std_logic_vector(unsigned(PC_ADDR) + unsigned(IMMEDIATE(6 downto 0)));
     SUBED <= std_logic_vector(unsigned(PC_ADDR) - unsigned(IMMEDIATE(6 downto 0)));
     RESULT <= ADDED when (IMMEDIATE(7) = '0') else
               SUBED when (IMMEDIATE(7) = '1') else
               std_logic_vector(to_unsigned(zero, INSTR_MEM_WIDTH));
end Dataflow;