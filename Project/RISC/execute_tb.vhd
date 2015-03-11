---------------------------------------------------
-- School:     University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer:   Josh Tombs
-- 
-- Create Date:    SPRING 2015
-- Module Name:    Execute Testplan
-- Project Name:   UMD_RISC16
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
-- Description:    Tests for Execute portion of Datapath.
---------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY execute_tb IS
END execute_tb;
 
ARCHITECTURE behavior OF execute_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT execute
    PORT(
         CLK : IN  std_logic;
         OP1_IN : IN  std_logic_vector(15 downto 0);
         OP2_IN : IN  std_logic_vector(15 downto 0);
         OPCODE : IN  std_logic_vector(3 downto 0);
         CCR_OUT : OUT  std_logic_vector(3 downto 0);
         D_OUT : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal OP1_IN : std_logic_vector(15 downto 0) := (others => '0');
   signal OP2_IN : std_logic_vector(15 downto 0) := (others => '0');
   signal OPCODE : std_logic_vector(3 downto 0) := (others => '0');

   --Outputs
   signal CCR_OUT : std_logic_vector(3 downto 0);
   signal D_OUT : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 20 ns;
 
BEGIN
 
   -- Instantiate the Unit Under Test (UUT)
   uut: execute PORT MAP (
          CLK => CLK,
          OP1_IN => OP1_IN,
          OP2_IN => OP2_IN,
          OPCODE => OPCODE,
          CCR_OUT => CCR_OUT,
          D_OUT => D_OUT
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
      OP1_IN <= x"0001";
      OP2_IN <= x"000E";
      OPCODE <= x"0";
      wait for CLK_period;
      OP1_IN <= x"0010";
      OP2_IN <= x"0002";
      OPCODE <= x"1";
      wait for CLK_period/2;
      ASSERT (D_OUT = x"000F")
          REPORT "Output Data for Instruction 1 incorrect."
          SEVERITY WARNING;
      wait for CLK_period;
      ASSERT (D_OUT = x"000E")
          REPORT "Output Data for Instruction 2 incorrect."
          SEVERITY WARNING;
      wait;
   end process;

END;
