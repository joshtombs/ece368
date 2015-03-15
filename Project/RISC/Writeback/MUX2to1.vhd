---------------------------------------------------
-- School: University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer: Brett Southworth
-- 
-- Create Date: SPRING 2015
-- Module Name: Mux_2to1
-- Project Name: UMD_RISC16
-- Target Devices: Spartan-3E
-- Tool versions: Xilinx ISE 14.7
-- Description: Register Bank Data Selector
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MUX2to1 is
    Port( SEL    : in  STD_LOGIC;
          IN0    : in  STD_LOGIC_VECTOR (15 downto 0);
          IN1    : in  STD_LOGIC_VECTOR (15 downto 0);
          OUTPUT : out  STD_LOGIC_VECTOR(15 downto 0));
end MUX2to1;

architecture Dataflow of MUX2to1 is

begin

with SEL select
    OUTPUT<= IN0 when '0',
             IN1 when '1',
             x"0000" when others;

end Dataflow;

