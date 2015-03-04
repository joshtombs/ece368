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
        DATA_OUT : OUT  std_logic_vector(43 downto 0)
       );
   END COMPONENT;
    

   --Inputs
   signal INST_IN : std_logic_vector(15 downto 0) := (others => '0');
   signal CLK : std_logic;

   --Outputs
   signal DATA_OUT : std_logic_vector(43 downto 0);
    
    --Clock
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
      REPORT "Beginning Decode Unit Tests." SEVERITY NOTE;
      -- Instruction 1
      INST_IN <= x"0FC0";
      wait for CLK_period;
      ASSERT (DATA_OUT(43 downto 40) = x"0")
        REPORT "Opcode not correct."
        SEVERITY WARNING;
      ASSERT (DATA_OUT(39 downto 36) = x"F")
        REPORT "Reg A Address not correct."
        SEVERITY WARNING;
      ASSERT (DATA_OUT(35 downto 32) = x"C")
        REPORT "Reg B Address not correct."
        SEVERITY WARNING;
      ASSERT (DATA_OUT(31 downto 16) = x"00C0")
        REPORT "Immediate value not correct."
        SEVERITY WARNING;
      ASSERT (DATA_OUT(15 downto 0) = x"000C")
        REPORT "Shift Immediate value not correct."
        SEVERITY WARNING;
      
      -- Instruction 2
      INST_IN <= x"4321";
      wait for CLK_period;
      ASSERT (DATA_OUT(43 downto 40) = x"4")
          REPORT "Opcode not correct."
          SEVERITY WARNING;
      ASSERT (DATA_OUT(39 downto 36) = x"3")
          REPORT "Reg A Address not correct."
          SEVERITY WARNING;
      ASSERT (DATA_OUT(35 downto 32) = x"2")
          REPORT "Reg B Address not correct."
          SEVERITY WARNING;
      ASSERT (DATA_OUT(31 downto 16) = x"0021")
          REPORT "Immediate value not correct."
          SEVERITY WARNING;
      ASSERT (DATA_OUT(15 downto 0) = x"0002")
          REPORT "Shift Immediate value not correct."
          SEVERITY WARNING;
            
      wait;
   end process;

END;
