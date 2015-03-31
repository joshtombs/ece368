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
      CLK           : in  STD_LOGIC;
      MUX_SEL       : in  STD_LOGIC_VECTOR(1 downto 0);
      ADD_A         : in  STD_LOGIC_VECTOR(4 downto 0);
      D_IN          : in  STD_LOGIC_VECTOR(15 downto 0);
      WEA_In        : in  STD_LOGIC;
      PCRes         : in  STD_LOGIC;
      INST_ENB      : in  STD_LOGIC;
      STACK_ENB     : in  STD_LOGIC;
      STACK_PUSHPOP : in  STD_LOGIC;
      STACK_E       : out STD_LOGIC;
      STACK_F       : out STD_LOGIC;
      INST_OUT      : out STD_LOGIC_VECTOR(15 downto 0));
end Fetch;

architecture Structural of Fetch is

signal AddB        : STD_LOGIC_VECTOR(4 downto 0);
signal AddRes      : STD_LOGIC_VECTOR(4 downto 0);
signal Mux_out     : STD_LOGIC_VECTOR(4 downto 0);
signal stack_res   : STD_LOGIC_VECTOR(4 downto 0);
signal One         : STD_LOGIC_VECTOR(4 downto 0) := "00001";
signal instruction : STD_LOGIC_VECTOR(15 downto 0);
begin

   AddRes <= (AddB + One); 

   U1: entity work.PC_Reg
   port map(
         D      => Mux_out,
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
            DOUTB => instruction); 

    U3: entity work.reg16
    port map(
            CLK   => CLK,
            D     => instruction,
            ENB   => INST_ENB,
            Q     => INST_OUT);

     U4: entity work.addr_mux4to1
     port map(SEL    => MUX_SEL,
          IN0    => AddRes,
          IN1    => STACK_res,
          IN2    => one,
          IN3    => AddB,
          OUTPUT => Mux_out
     );

    Stack: entity work.stack
    port map( CLK      => CLK,
              ENB      => STACK_ENB,
              PUSH_POP => STACK_PUSHPOP,
              DATA_IN  => AddRes,
              S_FULL   => STACK_F,
              S_EMPTY  => STACK_E,
              DATA_OUT => stack_res);
 end Structural;
