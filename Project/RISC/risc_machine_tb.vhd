---------------------------------------------------
-- School:     University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer:   Josh Tombs
-- 
-- Create Date:    SPRING 2015
-- Module Name:    RISC_TB
-- Project Name:   UMD_RISC16
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
-- Description:    Test bench for RISC Machine.
---------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY risc_machine_tb2 IS
END risc_machine_tb2;
 
ARCHITECTURE behavior OF risc_machine_tb2 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT risc_machine
    PORT(
         CLK : IN  std_logic;
         RESET : IN  std_logic;
         CCR_OUT : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RESET : std_logic := '0';

   --Outputs
   signal CCR_OUT : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 20 ns;
 
BEGIN
 
    -- Instantiate the Unit Under Test (UUT)
   uut: risc_machine PORT MAP (
          CLK => CLK,
          RESET => RESET,
          CCR_OUT => CCR_OUT
        );

   -- Clock process definitions
   CLK_process :process
   begin
        CLK <= '0';
        wait for CLK_period/2;
        CLK <= '1';
        wait for CLK_period/2;
   end process;
 
   TB: process
   begin        
      -- hold reset state for 100 ns.
      wait for 100 ns;
      RESET <= '1';
      wait for CLK_PERIOD;
      RESET <= '0';
      wait for CLK_PERIOD * 10;
      RESET <= '1';
      wait for CLK_PERIOD;
      RESET <= '0';
      wait;
   end process;

END;
