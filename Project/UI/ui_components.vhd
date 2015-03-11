---------------------------------------------------
-- School:     University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer:   Josh Tombs
-- 
-- Create Date:    SPRING 2015
-- Module Name:    UIComponents
-- Project Name:   UMD_RISC16
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
-- Description:    Package containing components
--     needed for the user interface.
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;

package ui_components is

	component keyboard_controller
		Port ( CLK      : in    STD_LOGIC;
               RST      : in    STD_LOGIC;
               PS2_CLK  : inout STD_LOGIC;
               PS2_DATA : inout STD_LOGIC;
               ASCII_OUT: out   STD_LOGIC_VECTOR (7 downto 0);
               ASCII_RD : out   STD_LOGIC;
               ASCII_WE : out   STD_LOGIC);
	end component;
	
	component debug_controller
		Port( DATA_IN    : in STD_LOGIC_VECTOR (7 downto 0);
              CLK        : in STD_LOGIC;
              RD         : in STD_LOGIC;
              W_ENB      : in STD_LOGIC;
              DATA_OUT   : out STD_LOGIC_VECTOR (15 downto 0));
	end component;

	component vga_toplevel
		Port ( CLK      : in  STD_LOGIC;
               RST      : in  STD_LOGIC;
			   ASCII    : in  STD_LOGIC_VECTOR (7 downto 0);
			   ASCII_RD : in  STD_LOGIC;
			   ASCII_WE : in  STD_LOGIC;
               HSYNC    : out STD_LOGIC;
               VSYNC    : out STD_LOGIC;
               VGARED   : out STD_LOGIC_VECTOR (2 downto 0);
               VGAGRN   : out STD_LOGIC_VECTOR (2 downto 0);
               VGABLU   : out STD_LOGIC_VECTOR (1 downto 0));
	end component;
	
	component seven_seg
		Port ( CLK     : in  STD_LOGIC; -- 50 MHz input
               RST     : in  STD_LOGIC;
               EN      : in  STD_LOGIC;
               SEG_0   : in  STD_LOGIC_VECTOR (3 downto 0);
               SEG_1   : in  STD_LOGIC_VECTOR (3 downto 0);
               SEG_2   : in  STD_LOGIC_VECTOR (3 downto 0);
               SEG_3   : in  STD_LOGIC_VECTOR (3 downto 0);
               DP_CTRL : in  STD_LOGIC_VECTOR (3 downto 0);
               COL_EN  : in  STD_LOGIC;
               SEG_OUT : out STD_LOGIC_VECTOR (6 downto 0);
               DP_OUT  : out STD_LOGIC;
               AN_OUT  : out STD_LOGIC_VECTOR (3 downto 0));
	end component;
end ui_components;