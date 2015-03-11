---------------------------------------------------
-- School:     University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer:   Josh Tombs
-- 
-- Create Date:    SPRING 2015
-- Module Name:    RISC Machine
-- Project Name:   Keyboard_Debug_ALU
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
-- Description:    RISC16 Machine
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.UMDRISC_PKG.all;
-- use work.all;

entity risc_machine is
    Port ( CLK  : in  STD_LOGIC;
           I_IN : in  STD_LOGIC_VECTOR (15 downto 0);
           WB   : out STD_LOGIC_VECTOR (7 downto 0));
end risc_machine;

architecture Structural of risc_machine is
signal reg_a, alu_out : STD_LOGIC_VECTOR(7 downto 0);
signal ccr, opcode    : STD_LOGIC_VECTOR(3 downto 0);
begin
    reg_a <= "0000" & I_IN(11 downto 8);
    ALU: entity work.ALU
    port map(CLK   => CLK,
             RA     => reg_a,
             RB     => I_IN(7 downto 0),
             OPCODE  => I_IN(15 downto 12),
             CCR     => ccr,
             ALU_OUT  => WB);  
    
end Structural;

