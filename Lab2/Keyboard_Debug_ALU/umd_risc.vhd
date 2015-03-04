---------------------------------------------------
-- School:     University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer:   Josh Tombs
-- 
-- Create Date:    SPRING 2015
-- Module Name:    UMD RISC
-- Project Name:   Keyboard_Debug_ALU
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
-- Description:    Structural Wrapper for 
--     RISC16 Machine with a user interface. 
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.all;

entity umd_risc is
    Port( CLK    : in    STD_LOGIC;
          PS2_C  : inout STD_LOGIC;
          PS2_D  : inout STD_LOGIC;
          RST    : in    STD_LOGIC;
          HSYNC  : out   STD_LOGIC;
          VSYNC  : out   STD_LOGIC; 
          VGARED : out   STD_LOGIC_VECTOR (2 downto 0);
          VGAGRN : out   STD_LOGIC_VECTOR (2 downto 0);
          VGABLU : out   STD_LOGIC_VECTOR (1 downto 0);
          SEG    : out   STD_LOGIC_VECTOR (6 downto 0);
          DP     : out   STD_LOGIC;
          AN     : out   STD_LOGIC_VECTOR (3 downto 0);
          LED    : out   STD_LOGIC_VECTOR (7 downto 0));
end umd_risc;

architecture Structural of umd_risc is
signal inst : STD_LOGIC_VECTOR (15 downto 0);
--signal wb : STD_LOGIC_VECTOR (7 downto 0);
begin
    UI : entity work.user_interface
    port map( CLK   => CLK,
              PS2_C => PS2_C,
              PS2_D => PS2_D,
              RST   => RST,
              HSYNC => HSYNC,
              VSYNC => VSYNC, 
              VGARED=> VGARED,
              VGAGRN=> VGAGRN,
              VGABLU=> VGABLU,
              I_OUT => inst,
--            WB    => wb,
              DP    => DP,
              SEG   => SEG,
              AN    => AN);
            
    RISC: entity work.risc_machine
    port map( CLK  => CLK,
              I_IN => inst,
              WB   => LED);

end Structural;

