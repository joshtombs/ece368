---------------------------------------------------
-- School: University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer: Brett Southworth
-- 
-- Create Date: SPRING 2015
-- Module Name: Write_Back
-- Project Name: UMD_RISC16
-- Target Devices: Spartan-3E
-- Tool versions: Xilinx ISE 14.7
-- Description: 5th stage of the pipeline
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library UNISIM;
use UNISIM.VComponents.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.all;
use work.all;


entity WriteBack is
Port(
      W_ADDR    : in STD_LOGIC_VECTOR(15 DOWNTO 0);
      CLK       : in STD_LOGIC;
      ADDR_B    : in STD_LOGIC_VECTOR(15 downto 0);
      D_In      : in STD_LOGIC_VECTOR(15 downto 0);
      WEA0      : in STD_LOGIC;
      FPU_In    : in STD_LOGIC_VECTOR(15 downto 0);
      D_OUT_SEL : in STD_LOGIC;
      D_Out     : out STD_LOGIC_VECTOR(15 downto 0));

end WriteBack;

architecture Structural of WriteBack is

signal D_Out2Mux  : STD_LOGIC_VECTOR(15 downto 0);
signal High       : STD_LOGIC := '1';
signal RegIn      : STD_LOGIC_VECTOR(15 downto 0);
signal InvCLK     : STD_LOGIC;

begin   

InvCLK <= not CLK; 

U1: entity work.MUX2to1
   port map(
            SEL    => D_OUT_SEL,
            IN0    => D_Out2Mux,
            IN1    => FPU_In,
            Output => RegIn
            );
            
U2: entity work.Data_Mem
   port map(
         CLKA     => InvCLK,
         CLKB     => CLK,
         WEA(0)   => WEA0,
         ADDRA    => W_ADDR(7 downto 0),
         ADDRB    => ADDR_B(7 downto 0),
         DINA     => D_In,
         doutb    => D_Out2Mux
            );
U3: entity work.Reg16_RE
   port map(
         CLK      => CLK,
         D        => RegIn,
         Q        => D_Out,
         ENB      => High
            );
end Structural;

