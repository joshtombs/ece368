---------------------------------------------------
-- School: University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer: Brett Southworth
-- Revised By: Josh Tombs
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.UMDRISC_PKG.all;
use work.all;


entity WriteBack is
Port(
      CLK         : in STD_LOGIC;
      D_In        : in STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
      WEA0        : in STD_LOGIC;
      FPU_In      : in STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
      D_OUT_SEL   : in STD_LOGIC_VECTOR(1 downto 0);
      EXMEM_D_IN  : in STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
      D_Out       : out STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
      EXMEM_RADDR : out STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
      EXMEM_WADDR : out STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
      EXMEM_DATA  : out STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0));

end WriteBack;

architecture Structural of WriteBack is

signal D_Out2Mux          : STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
signal High               : STD_LOGIC := '1';
signal Reg_Out, D_Reg_out : STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
signal InvCLK             : STD_LOGIC;
signal zero               : STD_LOGIC_VECTOR(15 downto 0) := x"0000";
begin   

InvCLK <= not CLK; 
EXMEM_RADDR <= FPU_IN;

U1: entity work.MUX4to1
   port map( SEL    => D_OUT_SEL,
             IN0    => D_Out2Mux,
             IN1    => Reg_Out,
             IN2    => EXMEM_D_IN,
             IN3    => zero,
             Output => D_Out);
            
   U2: entity work.Data_Mem
   port map( CLKA     => InvCLK,
             CLKB     => CLK,
             WEA(0)   => WEA0,
             ADDRA    => Reg_Out(7 downto 0),
             ADDRB    => FPU_In(7 downto 0),
             DINA     => D_Reg_Out,
             DOUTB    => D_Out2Mux);

   U3: entity work.data_reg_re
   port map( CLK      => CLK,
             D        => FPU_In,
             Q        => Reg_Out,
             ENB      => High);

    EXMEM_WADDR <= Reg_Out;

    U4: entity work.data_reg_re
    port map( CLK      => CLK,
              D        => D_In,
              Q        => D_Reg_Out,
              ENB      => High);

    U5: entity work.data_reg_re
    port map( CLK      => CLK,
              D        => D_In,
              Q        => EXMEM_DATA,
              ENB      => High);
end Structural;

