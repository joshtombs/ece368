---------------------------------------------------
-- School:     University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer:   Josh Tombs
-- 
-- Create Date:    SPRING 2015
-- Module Name:    UMD_RISC_TB
-- Project Name:   UMDRISC16
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
-- Description:    Test bench for entire RISC project.
---------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY umd_risc_tb IS
END umd_risc_tb;
 
ARCHITECTURE behavior OF umd_risc_tb IS 
 
    COMPONENT umd_risc
    PORT(
         CLK : IN  std_logic;
         PS2_C : INOUT  std_logic;
         PS2_D : INOUT  std_logic;
         RST : IN  std_logic;
         SW : IN  std_logic_vector(4 downto 0);
         HSYNC : OUT  std_logic;
         VSYNC : OUT  std_logic;
         VGARED : OUT  std_logic_vector(2 downto 0);
         VGAGRN : OUT  std_logic_vector(2 downto 0);
         VGABLU : OUT  std_logic_vector(1 downto 0);
         SEG : OUT  std_logic_vector(6 downto 0);
         DP : OUT  std_logic;
         AN : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';
   signal SW : std_logic_vector(4 downto 0) := (others => '0');

   --BiDirs
   signal PS2_C : std_logic;
   signal PS2_D : std_logic;

   --Outputs
   signal HSYNC : std_logic;
   signal VSYNC : std_logic;
   signal VGARED : std_logic_vector(2 downto 0);
   signal VGAGRN : std_logic_vector(2 downto 0);
   signal VGABLU : std_logic_vector(1 downto 0);
   signal SEG : std_logic_vector(6 downto 0);
   signal DP : std_logic;
   signal AN : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 20 ns;
 
BEGIN
 
    -- Instantiate the Unit Under Test (UUT)
   uut: umd_risc PORT MAP (
          CLK => CLK,
          PS2_C => PS2_C,
          PS2_D => PS2_D,
          RST => RST,
          SW => SW,
          HSYNC => HSYNC,
          VSYNC => VSYNC,
          VGARED => VGARED,
          VGAGRN => VGAGRN,
          VGABLU => VGABLU,
          SEG => SEG,
          DP => DP,
          AN => AN
        );

   -- Clock process definitions
   CLK_process :process
   begin
        CLK <= '0';
        wait for CLK_period/2;
        CLK <= '1';
        wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin        
      -- hold reset state for 100 ns.
      wait for 100 ns;    

      wait for 100 ns;
      RST <= '1';
      wait for CLK_PERIOD;
      RST <= '0';

      wait;
   end process;

END;
