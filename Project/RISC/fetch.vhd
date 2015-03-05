---------------------------------------------------
-- School: University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer: Brett Southworth
-- 
-- Create Date: SPRING 2015
-- Module Name: Fetch
-- Project Name: UMD_RISC16
-- Target Devices: Spartan-3E
-- Tool versions: Xilinx ISE 14.7
-- Description: Gets data in, sends Instructions out
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.all;

entity Fetch is
Port (
      CLK       : in STD_LOGIC;
      ADD_A     : in STD_LOGIC_VECTOR(4 downto 0);
      D_IN      : in STD_LOGIC_VECTOR(15 downto 0);
      WEA_In    : in STD_LOGIC;
      PCRes     : in STD_LOGIC;
      INST_OUT  : out STD_LOGIC_VECTOR(15 downto 0));
end Fetch;

architecture Structural of Fetch is

signal AddB     : STD_LOGIC_VECTOR(4 downto 0);
signal AddRes   : STD_LOGIC_VECTOR(4 downto 0);
signal One      : STD_LOGIC_VECTOR(4 downto 0) := "00001";

begin

   AddRes <= (AddB + One); 

   U1: entity work.PC_Reg
   port map(
         D      => AddRes,         
         Enable => One(0),
         CLK    => CLK,
         Q      => AddB,
         Res    => PCRes);
         
 
   U2: entity work.Instr_Mem
   port map( 
            CLKB  => CLK,
            ADDRB => AddB, 
            CLKA  => CLK,
            WEA(0)=> WEA_In,
            ADDRA => ADD_A,
            DINA  => D_IN, 
            DOUTB => INST_OUT); 

 end Structural;
