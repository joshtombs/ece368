---------------------------------------------------
-- School: University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer: Josh Tombs
-- 
-- Create Date:    SPRING 2015
-- Module Name:    D_Flip_Flop_re
-- Project Name:   UMD_RISC16
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
-- Description:    Single bit flip flop with enable
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity flip_flop_re is
    Port ( CLK     : in  STD_LOGIC;
           ENB     : in  STD_LOGIC;
           D       : in  STD_LOGIC;
           Q       : out STD_LOGIC);
end flip_flop_re;

architecture Behavioral of flip_flop_re is

begin
    Process(CLK)
    begin
        if(CLK'event and CLK='1') then
            if(ENB = '1') then
                Q <= D;
            end if;
        end if;
    end Process;
end Behavioral;

