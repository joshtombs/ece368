---------------------------------------------------
-- School: University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer: Josh Tombs
-- 
-- Create Date:    SPRING 2015
-- Module Name:    D_Flip_Flop2
-- Project Name:   UMD_RISC16
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
-- Description:    Two bit flip flop with enable
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity flip_flop2 is
    Port ( CLK     : in  STD_LOGIC;
           ENB     : in  STD_LOGIC;
           D       : in  STD_LOGIC_VECTOR(1 downto 0);
           Q       : out STD_LOGIC_VECTOR(1 downto 0));
end flip_flop2;

architecture Behavioral of flip_flop2 is

begin
    Process(CLK)
    begin
        if(CLK'event and CLK='0') then
            if(ENB = '1') then
                Q <= D;
            end if;
        end if;
    end Process;
end Behavioral;

