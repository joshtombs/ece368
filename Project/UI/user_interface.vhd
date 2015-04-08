---------------------------------------------------
-- School:     University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer:   Josh Tombs
-- Revised By: Brett Southworth
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
          SW_IN  : in STD_LOGIC_VECTOR(4 downto 0);
          B_Data0 : in STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
          B_Data1 : in STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
          B_Data2 : in STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
          B_Data3 : in STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
          B_Data4 : in STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
          B_Data5 : in STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
          B_Data6 : in STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
          B_Data7 : in STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
          B_Data8 : in STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
          B_Data9 : in STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
          B_Data10 : in STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
          B_Data11 : in STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
          B_Data12 : in STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
          B_Data13 : in STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
          B_Data14 : in STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
          B_Data15 : in STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
          INSTR_IN : in STD_LOGIC_VECTOR(INSTR_LENGTH-1 downto 0);
          WB_In    : in STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
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
    signal instruction : STD_LOGIC_VECTOR (INSTR_LENGTH-1 downto 0) := (OTHERS => '0');
    signal ascii_rd, ascii_we : STD_LOGIC;
    signal enl : STD_LOGIC := '1';
    signal dpc : STD_LOGIC_VECTOR (3 downto 0) := "1111";
    signal cen : STD_LOGIC := '0';
    signal Mux_Out, Mux_Out2: STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
     
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
    
    I_OUT <= Mux_Out2;
                 
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
              SEG_0   => Mux_Out2(15 downto 12),
              SEG_1   => Mux_Out2(11 downto 8),
              SEG_2   => Mux_Out2(7 downto 4),
              SEG_3   => Mux_Out2(3 downto 0),
              DP_CTRL => dpc,
              COL_EN  => cen,
              SEG_OUT => SEG,
              DP_OUT  => DP,
              AN_OUT  => AN);
        
    U5: entity MUX16to1
    port map(
            SEL(0) => SW_IN(0),
            SEL(1) => SW_IN(1),
            SEL(2) => SW_IN(2),
            SEL(3) => SW_IN(3),
            In0 => B_Data0,
            In1 => B_Data1,
            In2 => B_Data2,
            In3 => B_Data3,
            In4 => B_Data4,
            In5 => B_Data5,
            In6 => B_Data6,
            In7 => B_Data7,
            In8 => B_Data8,
            In9 => B_Data9,
            In10 => B_Data10,
            In11 => B_Data11,
            In12 => B_Data12,
            In13 => B_Data13,
            In14 => B_Data14,
            In15 => B_Data15, 
            OUTPUT => Mux_Out);

    U6: entity MUX2to1
    port map(
            In1 => Mux_Out,
            In0 => instruction,
            SEL => SW_IN(4),
            Output => Mux_Out2);

end Structural;

