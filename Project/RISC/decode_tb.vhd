---------------------------------------------------
-- School:     University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer:   Josh Tombs
-- 
-- Create Date:    SPRING 2015
-- Module Name:    Decode Block Test Bench
-- Project Name:   UMD_RISC16
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
-- Description:    Tests for Decode portion of Datapath
---------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY decode_tb IS
END decode_tb;
 
ARCHITECTURE behavior OF decode_tb IS 
 
   -- Component Declaration for the Unit Under Test (UUT)
   COMPONENT decode
   PORT(
        INST_IN :  IN   std_logic_vector(15 downto 0);
        DATA_OUT : OUT  std_logic_vector(39 downto 0)
       );
   END COMPONENT;
    

   --Inputs
   signal INST_IN : std_logic_vector(15 downto 0) := (others => '0');
   signal CLK : std_logic;

   --Outputs
   signal DATA_OUT : std_logic_vector(39 downto 0);
   -- No clocks detected in port list. Replace CLK below with 
   -- appropriate port name 
 
   constant CLK_period : time := 20 ns;
 
BEGIN
 
    -- Instantiate the Unit Under Test (UUT)
   uut: decode PORT MAP (
          INST_IN => INST_IN,
          DATA_OUT => DATA_OUT
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

      -- insert stimulus here
      INST_IN <= x"0FC0";
      wait for CLK_period*10;
        
      INST_IN <= x"1234";

      wait;
   end process;

END;
