---------------------------------------------------
-- School: University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer: Brett Southworth
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
      W_ADDR  : IN  std_logic_vector(15 downto 0);
      CLK     : IN  std_logic;
      ADDR_B  : IN  std_logic_vector(15 downto 0);
      D_In    : IN  std_logic_vector(15 downto 0);
      WEA0    : IN  std_logic;
      FPU_In  : IN  std_logic_vector(15 downto 0);
      D_OUT_SEL     : IN  std_logic;
      D_Out : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal W_ADDR  : std_logic_vector(15 downto 0) := (others => '0');
   signal CLK     : std_logic := '0';
   signal ADDR_B  : std_logic_vector(15 downto 0) := (others => '0');
   signal D_In    : std_logic_vector(15 downto 0) := (others => '0');
   signal WEA0    : std_logic := '0';
   signal FPU_In  : std_logic_vector(15 downto 0) := (others => '0');
   signal D_OUT_SEL     : std_logic := '0';

    --Outputs
   signal D_Out : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 20 ns;
 
BEGIN
 
   -- Instantiate the Unit Under Test (UUT)
   uut: WriteBack PORT MAP (
      W_ADDR  => W_ADDR,
      CLK     => CLK,
      ADDR_B  => ADDR_B,
      D_In    => D_In,
      WEA0    => WEA0,
      FPU_In  => FPU_In,
      D_OUT_SEL     => D_OUT_SEL,
      D_Out => D_Out
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

      wait for CLK_period*10;

      -- Simulating Data to Register
      FPU_IN  <= x"00FF";
      D_IN    <= x"01FF";
      WEA0    <= '0';
      ADDR_B  <= x"0000";
      D_OUT_SEL     <= '1';
      
      wait for CLK_PERIOD;
      
      -- Simulating Storing Results
      W_ADDR  <= x"0000";
      D_IN    <= x"00FA";
      WEA0    <= '1';
      
      wait for CLK_PERIOD;
      W_ADDR  <= x"0001";
      D_IN    <= x"06FA";
      
      wait for CLK_PERIOD;
		ADDR_B <= x"0000";
		D_OUT_SEL <= '0';
      wait;
   end process;

END;
