---------------------------------------------------
-- School:     University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer:   Josh Tombs
-- 
-- Create Date:    SPRING 2015
-- Module Name:    Stack_TB
-- Project Name:   UMD_RISC16
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
-- Description:    Test bench for FIFO stack.
---------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY stack_tb IS
END stack_tb;
 
ARCHITECTURE behavior OF stack_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT stack
    PORT(
         CLK : IN  std_logic;
         ENB : IN  std_logic;
         PUSH_POP : IN  std_logic;
         DATA_IN : IN  std_logic_vector(4 downto 0);
         S_EMPTY : OUT  std_logic;
         S_FULL : OUT  std_logic;
         DATA_OUT : OUT  std_logic_vector(4 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal ENB : std_logic := '0';
   signal PUSH_POP : std_logic := '0';
   signal DATA_IN : std_logic_vector(4 downto 0) := (others => '0');

   --Outputs
   signal S_EMPTY : std_logic;
   signal S_FULL : std_logic;
   signal DATA_OUT : std_logic_vector(4 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 20 ns;
 
BEGIN
 
    -- Instantiate the Unit Under Test (UUT)
   uut: stack PORT MAP (
          CLK => CLK,
          ENB => ENB,
          PUSH_POP => PUSH_POP,
          DATA_IN => DATA_IN,
          S_EMPTY => S_EMPTY,
          S_FULL => S_FULL,
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
      ENB <= '0';
        wait for 100 ns;    
        DATA_IN <= "01010";
        PUSH_POP <= '0';
        wait for CLK_PERIOD/2;
        ENB <= '1';
        wait for CLK_PERIOD;
        ENB <= '0';
        wait for CLK_PERIOD * 4;
        PUSH_POP <= '1';
        ENB <= '1';
        wait for CLK_PERIOD;
        ENB <= '0';
      wait;
   end process;

END;
