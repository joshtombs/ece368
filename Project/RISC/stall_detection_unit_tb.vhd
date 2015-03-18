---------------------------------------------------
-- School:     University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer:   Josh Tombs
-- 
-- Create Date:    SPRING 2015
-- Module Name:    Stall_Detection_Unit_TB
-- Project Name:   UMD_RISC16
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
-- Description:    Tests for stall detection unit
---------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY stall_detection_unit_tb IS
END stall_detection_unit_tb;
 
ARCHITECTURE behavior OF stall_detection_unit_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT stall_detection_unit
    PORT(
         CLK      : IN  std_logic;
         INSTR_IN : IN  std_logic_vector(15 downto 0);
         STALL    : OUT std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal INSTR_IN : std_logic_vector(15 downto 0) := (others => '0');

   --Outputs
   signal STALL : std_logic; --:= '0';
    
   -- Clock period definitions
   constant CLK_period : time := 20 ns;
 
BEGIN
 
   -- Instantiate the Unit Under Test (UUT)
   uut: stall_detection_unit PORT MAP (
          CLK => CLK,
          INSTR_IN => INSTR_IN,
             STALL => STALL
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
   TB: process
   begin        
      -- hold reset state for 100 ns.
      wait for 100 ns;    
      INSTR_IN <= x"5002";
      wait for CLK_PERIOD/2;
      ASSERT( STALL = '0')
          REPORT( "Stall triggered incorrectly.")
          SEVERITY warning;
      wait for CLK_PERIOD/2;
      INSTR_IN <= x"5101";
      wait for CLK_PERIOD/2;
      ASSERT( STALL = '0')
          REPORT( "Stall triggered incorrectly.")
          SEVERITY warning;
      wait for CLK_PERIOD/2;
      INSTR_IN <= x"A10F";
      wait for CLK_PERIOD/2;
      ASSERT( STALL = '0')
          REPORT( "Stall triggered incorrectly.")
          SEVERITY warning;
      wait for CLK_PERIOD/2;
      
      -- Test to make sure it triggers when register A is used
      INSTR_IN <= x"950F";
      wait for CLK_PERIOD/2;
      ASSERT( STALL = '0')
          REPORT( "Stall triggered incorrectly.")
          SEVERITY warning;
      wait for CLK_PERIOD/2;
      INSTR_IN <= x"1500";
      wait for CLK_PERIOD/2;
      ASSERT( STALL = '0')
          REPORT( "Stall triggered incorrectly.")
          SEVERITY warning;
      wait for CLK_PERIOD/2;
      INSTR_IN <= x"2010";
      wait for CLK_PERIOD/2;
      ASSERT( STALL = '1')
          REPORT( "Stall not triggered properly.")
          SEVERITY warning;
      wait for CLK_PERIOD/2;
      INSTR_IN <= x"3010";
      wait for CLK_PERIOD/2;
      ASSERT( STALL = '0')
          REPORT( "Stall triggered incorrectly.")
          SEVERITY warning;
      wait for CLK_PERIOD/2;
      INSTR_IN <= x"0010";
      wait for CLK_PERIOD/2;
      ASSERT( STALL = '0')
          REPORT( "Stall triggered incorrectly.")
          SEVERITY warning;
      wait for CLK_PERIOD/2;
      INSTR_IN <= x"4A10";
      wait for CLK_PERIOD/2;
      ASSERT( STALL = '0')
          REPORT( "Stall triggered incorrectly.")
          SEVERITY warning;
      wait for CLK_PERIOD/2;
      INSTR_IN <= x"7A03";
      wait for CLK_PERIOD/2;
      ASSERT( STALL = '0')
          REPORT( "Stall triggered incorrectly.")
          SEVERITY warning;
      wait for CLK_PERIOD/2;
      INSTR_IN <= x"8A01";
      wait for CLK_PERIOD/2;
      ASSERT( STALL = '0')
          REPORT( "Stall triggered incorrectly.")
          SEVERITY warning;
      wait for CLK_PERIOD/2;
      
      -- Test to ensure it doesn't trigger after load with different registers
      INSTR_IN <= x"9201";
      wait for CLK_PERIOD/2;
      ASSERT( STALL = '0')
          REPORT( "Stall triggered incorrectly.")
          SEVERITY warning;
      wait for CLK_PERIOD/2;
      INSTR_IN <= x"0130";
      wait for CLK_PERIOD/2;
      ASSERT( STALL = '0')
          REPORT( "Stall triggered incorrectly.")
          SEVERITY warning;
      wait for CLK_PERIOD/2;
      INSTR_IN <= x"1120";
      wait for CLK_PERIOD/2;
      ASSERT( STALL = '0')
          REPORT( "Stall triggered incorrectly.")
          SEVERITY warning;
      wait for CLK_PERIOD/2;
      
      -- Test to make sure it triggers when register B is used
      INSTR_IN <= x"97FF";
      wait for CLK_PERIOD/2;
      ASSERT( STALL = '0')
          REPORT( "Stall triggered incorrectly.")
          SEVERITY warning;
      wait for CLK_PERIOD/2;
      INSTR_IN <= x"0070";
      wait for CLK_PERIOD/2;
      ASSERT( STALL = '0')
          REPORT( "Stall triggered incorrectly.")
          SEVERITY warning;
      wait for CLK_PERIOD/2;
      INSTR_IN <= x"1234";
      wait for CLK_PERIOD/2;
      ASSERT( STALL = '1')
          REPORT( "Stall not triggered properly.")
          SEVERITY warning;
      wait for CLK_PERIOD/2;
       
      -- Test to make sure it doesn't trigger when B isn't used (immediate)
      INSTR_IN <= x"9914";
      wait for CLK_PERIOD/2;
      ASSERT( STALL = '0')
          REPORT( "Stall triggered incorrectly.")
          SEVERITY warning;
      wait for CLK_PERIOD/2;
      INSTR_IN <= x"6391";
      wait for CLK_PERIOD/2;
      ASSERT( STALL = '0')
          REPORT( "Stall triggered incorrectly.")
          SEVERITY warning;
      wait for CLK_PERIOD/2;
      INSTR_IN <= x"1120";
      wait for CLK_PERIOD/2;
      ASSERT( STALL = '0')
          REPORT( "Stall triggered incorrectly.")
          SEVERITY warning;
      wait for CLK_PERIOD/2;
      wait;
   end process;

END;
