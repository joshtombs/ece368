---------------------------------------------------
-- School: University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer: Brett Southworth
-- Revised By: Josh Tombs
-- 
-- Create Date: SPRING 2015
-- Module Name: WriteBack Test Bench
-- Project Name: UMD_RISC16
-- Target Devices: Spartan-3E
-- Tool versions: Xilinx ISE 14.7
-- Description: Test Bench code for WriteBack
---------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY writeback_tb IS
END writeback_tb;
 
ARCHITECTURE behavior OF writeback_tb IS 
    COMPONENT WriteBack
    PORT(
      CLK       : IN  std_logic;
      D_In      : IN  std_logic_vector(15 downto 0);
      WEA0      : IN  std_logic;
      FPU_In    : IN  std_logic_vector(15 downto 0);
      D_OUT_SEL : IN  std_logic;
      D_Out     : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK        : std_logic := '0';
   signal D_In       : std_logic_vector(15 downto 0) := (others => '0');
   signal WEA0       : std_logic := '0';
   signal FPU_In     : std_logic_vector(15 downto 0) := (others => '0');
   signal D_OUT_SEL  : std_logic := '0';

    --Outputs
   signal D_Out : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 20 ns;
 
BEGIN
 
   -- Instantiate the Unit Under Test (UUT)
   uut: WriteBack PORT MAP (
      CLK        => CLK,
      D_In       => D_In,
      WEA0       => WEA0,
      FPU_In     => FPU_In,
      D_OUT_SEL  => D_OUT_SEL,
      D_Out      => D_Out
        );

   -- Clock process definitions
   CLK_process :process
   begin
      CLK    <= '0';
      wait for CLK_period/2;
      CLK    <= '1';
      wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin      
      -- hold reset state for 100 ns.
      wait for 100 ns;

      -- Simulating Store to data memory
      -- Note: Make sure this is being run on a falling edge first, the FPU_IN line should change on a falling edge
      FPU_IN    <= x"0002";
      D_IN      <= x"1111";
      wait for CLK_PERIOD/2;
      -- Don't care what D_OUT as it is not writing to register
      WEA0      <= '1';
      wait for CLK_PERIOD/2;
        
        
      -- Simulating a Load right after the store
      FPU_IN    <= x"0002";
      wait for CLK_PERIOD/2;
      WEA0      <= '0';
      D_OUT_SEL <= '0';        
      wait for CLK_PERIOD/2;
      ASSERT(D_OUT = x"1111")
          REPORT("Data out wrong when loading after Store.")
          SEVERITY WARNING;
        
      -- Storing some values into data memory
      FPU_IN    <= x"0001";
      D_IN      <= x"FFFF";
      wait for CLK_PERIOD/2;
      WEA0      <= '1';
      wait for CLK_PERIOD/2;
      FPU_IN    <= x"0000";
      D_IN      <= x"0001";
      wait for CLK_PERIOD/2;
      WEA0      <= '1';
      wait for CLK_PERIOD/2;
      
      -- Simulating Load from data memory to register
      -- Note: Make sure this is being run on a falling edge first, the FPU_IN line should change on a falling edge
      FPU_IN     <= x"0001";
      wait for CLK_PERIOD/2;
      WEA0      <= '0';
      D_OUT_SEL <= '0';        
      wait for CLK_PERIOD/2;
      ASSERT(D_OUT = x"FFFF")
          REPORT("Data out wrong after Load Instruction 1.")
          SEVERITY WARNING;
      FPU_IN    <= x"0000";
      wait for CLK_PERIOD/2;
      WEA0      <= '0';
      D_OUT_SEL <= '0';        
      wait for CLK_PERIOD/2;
      ASSERT(D_OUT = x"0001")
          REPORT("Data out wrong after Load Instruction 2.")
          SEVERITY WARNING;
       
      -- Simulating FPU Data to Register
      -- Note: Make sure this is being run on a falling edge first, the FPU_IN line should change on a falling edge
      FPU_IN     <= x"00FF";
      wait for CLK_PERIOD/2;
      WEA0       <= '0';
      D_OUT_SEL  <= '1';
      wait for CLK_PERIOD/2;
      ASSERT(D_OUT = x"00FF")
          REPORT("Data out wrong after register write from FPU.")
          SEVERITY WARNING;
      FPU_IN     <= x"00CC";
      wait for CLK_PERIOD/2;
      WEA0       <= '0';
      D_OUT_SEL  <= '1';
      wait for CLK_PERIOD/2;
      ASSERT(D_OUT = x"00CC")
          REPORT("Data out wrong after second register write from FPU.")
          SEVERITY WARNING;
            
         
      wait;
   end process;

END;
