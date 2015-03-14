---------------------------------------------------
-- School: University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer: Brett Southworth
-- 
-- Create Date: SPRING 2015
-- Module Name: Fetch_TB
-- Project Name: UMD_RISC16
-- Target Devices: Spartan-3E
-- Tool versions: Xilinx ISE 14.7
-- Description: Testbench for working Fetch
---------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY Fetch_TB IS
END Fetch_TB;
 
ARCHITECTURE behavior OF Fetch_TB IS 
 
    COMPONENT Fetch
    PORT(
         CLK 	  : IN  std_logic;
         ADD_A    : IN  std_logic_vector(4 downto 0);
         D_IN 	  : IN  std_logic_vector(15 downto 0);
         WEA_In   : IN  std_logic;
         PCRes 	  : IN  std_logic;
         INST_ENB : IN  std_logic;
         INST_OUT : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK 		: std_logic := '0';
   signal ADD_A 	: std_logic_vector(4 downto 0) := (others => '0');
   signal D_IN 		: std_logic_vector(15 downto 0) := (others => '0');
   signal WEA_In 	: std_logic := '0';
   signal PCRes 	: std_logic := '0';
   signal INST_ENB      : std_logic := '0';

   --Outputs
   signal INST_OUT 	: std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Fetch PORT MAP (
          CLK => CLK,
          ADD_A => ADD_A,
          D_IN => D_IN,
          WEA_In => WEA_In,
          PCRes => PCRes,
          INST_ENB => INST_ENB,
          INST_OUT => INST_OUT
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

      wait for CLK_period*10;
		  
		  PCRes <= '1';
		  INST_ENB <= '1';
		  wait for CLK_PERIOD;
		  PCRes <= '0';
		  wait for CLK_PERIOD * 6;
		  PCRes <= '1';
		  wait for CLK_PERIOD;
		  PCRes <= '0';
		  
      -- insert stimulus here 

      wait;
   end process;

END;
