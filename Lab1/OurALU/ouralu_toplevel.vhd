---------------------------------------------------
-- School: University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer: Josh Tombs
-- 
-- Create Date:    SPRING 2015
-- Module Name:    OURALU
-- Project Name:   OurALU
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
-- Description: Control Unit for Lab 1
--  Maintain input from the eight switches,
--  and using three buttons, store switch data
--  to registers in ALU and perform operations.
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.all;

entity ourALU is
    Port (  CLK     : in  STD_LOGIC;
            SW        : in  STD_LOGIC_VECTOR (7 downto 0);
            BTN        : in  STD_LOGIC_VECTOR (3 downto 0);
            SEG     : out STD_LOGIC_VECTOR (6 downto 0);
            LED     : out STD_LOGIC_VECTOR (7 downto 4);
            DP      : out STD_LOGIC;
            AN      : out STD_LOGIC_VECTOR (3 downto 0));
end ourALU;

architecture Structural of ourALU is

    signal TO_SEG, FF1_OUT, FF2_OUT, FF3_OUT : STD_LOGIC_VECTOR (7 downto 0);
    signal cen                                 : STD_LOGIC := '0';
    signal enl                                  : STD_LOGIC := '1';
    signal dpc, BC_OUTPUT                      : STD_LOGIC_VECTOR (3 downto 0) := "1111";

begin

    ----- Structural Components: -----
    BTN_CONTROLLER: entity work.buttoncontrol    -- Controller to handle debounce on each push button
     port map( CLK => CLK,
               BTN => BTN,
               OUTPUT => BC_OUTPUT);

    -- Create three flip-flops to store switch data
    FF1: entity work.flip_flop
    port map(   CLK   => BC_OUTPUT(3),            -- Use push buttons for trigger edge
                D_IN  => SW(7 downto 0),
                D_OUT => FF1_OUT);
     
    FF2: entity work.flip_flop
     port map(  CLK   => BC_OUTPUT(2),
                D_IN  => SW(7 downto 0),
                D_OUT => FF2_OUT);
     
    FF3: entity work.flip_flop
    port map(   CLK   => BC_OUTPUT(1),
                D_IN  => SW(7 downto 0),
                D_OUT => FF3_OUT);
     
    ALU: entity work.ALU
    port map(   CLK       => CLK,
                RA       => FF1_OUT,
                RB       => FF2_OUT,
                OPCODE   => FF3_OUT(3 downto 0),
                ALU_OUT  => TO_SEG,
                CCR      => LED(7 downto 4));
              
    -- Driver to control 4 Seven Segment displays
    SSeg: entity work.SSegDriver
    port map( CLK     => CLK,
              RST     => '0',
              EN      => enl,
              SEG_0   => "0000",
              SEG_1   => "0000",
              SEG_2   => TO_SEG(7 downto 4),
              SEG_3   => TO_SEG(3 downto 0),
              DP_CTRL => dpc,
              COL_EN  => cen,
              SEG_OUT => SEG,
              DP_OUT  => DP,
              AN_OUT  => AN);
          
    ----- End Structural Components -----

end Structural;
