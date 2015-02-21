---------------------------------------------------
-- School: University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer: Josh Tombs
-- 
-- Create Date:    SPRING 2015
-- Module Name:    Flip Flop
-- Project Name:   OurALU
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
-- Description:    8 bit Flip Flop Register
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity flip_flop is
    Port ( CLK     : in  STD_LOGIC;
          D_IN    : in  STD_LOGIC_VECTOR (7 downto 0);
          D_OUT   : out STD_LOGIC_VECTOR (7 downto 0));
end flip_flop;

architecture Behavioral of flip_flop is

begin
    Process(CLK)
    begin
        if(CLK'event and CLK='1') then
            D_OUT <= D_IN;
        end if;
    end Process;
end Behavioral;

