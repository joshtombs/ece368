---------------------------------------------------
-- School: University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer: Daniel Noyes
-- Revised By: Josh Tombs
-- 
-- Create Date:    SPRING 2015
-- Module Name:    ALU_Logic_Unit
-- Project Name:   ALU
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
-- Description: Load/Store Unit
--  Operations - Load/Store to a register
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Load_Store_Unit is
    Port ( A      : in  STD_LOGIC_VECTOR (15 downto 0);
           IMMED  : in  STD_LOGIC_VECTOR (15 downto 0);
           OP     : in  STD_LOGIC_VECTOR (3 downto 0);
           RESULT : out STD_LOGIC_VECTOR  (15 downto 0));

end Load_Store_Unit;

architecture Dataflow of Load_Store_Unit is

begin
    RESULT <= IMMED;

end Dataflow;

