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
use work.UMDRISC_PKG.all;

entity umd_risc is
    Port( CLK    : in    STD_LOGIC;
          PS2_C  : inout STD_LOGIC;
          PS2_D  : inout STD_LOGIC;
          RST    : in    STD_LOGIC;
          SW     : in    STD_LOGIC_VECTOR(4 downto 0);            --Switches 0 - 3 for checking memory values                --Switch 4 for enabling the viewing
          HSYNC  : out   STD_LOGIC;
          VSYNC  : out   STD_LOGIC; 
          VGARED : out   STD_LOGIC_VECTOR (2 downto 0);
          VGAGRN : out   STD_LOGIC_VECTOR (2 downto 0);
          VGABLU : out   STD_LOGIC_VECTOR (1 downto 0);
          SEG    : out   STD_LOGIC_VECTOR (6 downto 0);
          DP     : out   STD_LOGIC;
          AN     : out   STD_LOGIC_VECTOR (3 downto 0));
          --LED    : out   STD_LOGIC_VECTOR (7 downto 0));
end umd_risc;

architecture Structural of umd_risc is
signal inst : STD_LOGIC_VECTOR (15 downto 0);
signal B_Data0, B_Data1, B_Data2, B_Data3, B_Data4, B_Data5, B_Data6, B_Data7, 
B_Data8, B_Data9, B_Data10, B_Data11, B_Data12, B_Data13, B_Data14, B_Data15,
external_din, external_dout, external_raddr, external_waddr : STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
signal external_we, notCLK : STD_LOGIC;
signal zero : STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0) := x"0000";
begin
    notCLK <= not CLK;

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
              DP    => DP,
              SEG   => SEG,
              AN    => AN,
              SW_In => SW,
              INSTR_IN => inst,
              B_Data0  => B_Data0,
              B_Data1  => B_Data1,
              B_Data2  => B_Data2,
              B_Data3  => B_Data3,
              B_Data4  => B_Data4,
              B_Data5  => B_Data5,
              B_Data6  => B_Data6,
              B_Data7  => B_Data7,
              B_Data8  => B_Data8,
              B_Data9  => B_Data9,
              B_Data10 => B_Data10,
              B_Data11 => B_Data11,
              B_Data12 => B_Data12,
              B_Data13  => B_Data13,
              B_Data14  => B_Data14,
              B_Data15  => B_Data15);
            
    RISC: entity work.risc_machine
    port map( CLK  => CLK,
              RESET => RST,
              EXMEM_D_IN  => external_din,
              EXMEM_RADDR => external_raddr,
              EXMEM_WE    => external_we,
              EXMEM_WADDR => external_waddr,
              EXMEM_D_OUT => external_dout,
              B_Data0     => B_Data0,
              B_Data1     => B_Data1,
              B_Data2     => B_Data2,
              B_Data3     => B_Data3,
              B_Data4     => B_Data4,
              B_Data5     => B_Data5,
              B_Data6     => B_Data6,
              B_Data7     => B_Data7,
              B_Data8     => B_Data8,
              B_Data9     => B_Data9,
              B_Data10    => B_Data10,
              B_Data11    => B_Data11,
              B_Data12    => B_Data12,
              B_Data13    => B_Data13,
              B_Data14    => B_Data14,
              B_Data15    => B_Data15);

    EXTERNAL_MEMORY: entity work.external_mem
    port map( CLKB  => CLK,
              ADDRB => external_raddr(EX_MEM_USED-1 downto 0),
              CLKA  => notCLK,
              WEA(0)=> external_we,
              ADDRA => external_waddr(EX_MEM_USED-1 downto 0),
              DINA  => external_dout,
              DOUTB => external_din);
end Structural;

