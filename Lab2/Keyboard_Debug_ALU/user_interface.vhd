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
-- Description:    Create user interface to communicate 
--     with RISC16 Machine. Contains controllers for the following:
--     - VGA Display 
--     - PS2 Keyboard
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.all;

entity user_interface is
    Port( CLK    : in    STD_LOGIC;
          PS2_C  : inout STD_LOGIC;
          PS2_D  : inout STD_LOGIC;
          RST    : in    STD_LOGIC;
--        WB     : in    STD_LOGIC_VECTOR ( 7 downto 0);
          HSYNC  : out   STD_LOGIC;
          VSYNC  : out   STD_LOGIC; 
          VGARED : out   STD_LOGIC_VECTOR (2 downto 0);
          VGAGRN : out   STD_LOGIC_VECTOR (2 downto 0);
          VGABLU : out   STD_LOGIC_VECTOR (1 downto 0);
          I_OUT  : out   STD_LOGIC_VECTOR(15 downto 0);
          SEG    : out   STD_LOGIC_VECTOR (6 downto 0);
          DP     : out   STD_LOGIC;
          AN     : out   STD_LOGIC_VECTOR (3 downto 0));
end user_interface;

architecture Structural of user_interface is
    signal reg_a, reg_b, ascii, alu_out : STD_LOGIC_VECTOR (7 downto 0);
    signal instruction : STD_LOGIC_VECTOR (15 downto 0) := (OTHERS => '0');
    signal ascii_rd, ascii_we : STD_LOGIC;
    signal enl : STD_LOGIC := '1';
    signal dpc : STD_LOGIC_VECTOR (3 downto 0) := "1111";
    signal cen : STD_LOGIC := '0';
begin
    U1: entity work.keyboard_controller
    port map( CLK      => CLK,
              RST      => RST,
              PS2_CLK  => PS2_C,
              PS2_DATA => PS2_D,
              ASCII_OUT=> ascii,
              ASCII_RD => ascii_rd,
              ASCII_WE => ascii_we);
    
    U2: entity work.debug_controller
    port map( DATA_IN => ascii,
              CLK => CLK,
              RD => ascii_rd,
              W_ENB => ascii_we,
              DATA_OUT => instruction);
    
    I_OUT <= instruction;
                 
    U3: entity work.vga_toplevel
    port map( CLK      => CLK,
              RST      => RST,
--            SW       => ,
              ASCII    => ascii,
              ASCII_RD => ascii_rd,
              ASCII_WE => ascii_we,
              HSYNC    => HSYNC,
              VSYNC    => VSYNC,
              VGARED   => VGARED,
              VGAGRN   => VGAGRN,
              VGABLU   => VGABLU);
         
    U4: entity work.SSegDriver
    port map( CLK     => CLK,
              RST     => RST,
              EN      => enl,
              SEG_0   => instruction(3 downto 0),
              SEG_1   => instruction(7 downto 4),
              SEG_2   => instruction(11 downto 8),
              SEG_3   => instruction(15 downto 12),
              DP_CTRL => dpc,
              COL_EN  => cen,
              SEG_OUT => SEG,
              DP_OUT  => DP,
              AN_OUT  => AN);

end Structural;

