---------------------------------------------------
-- School:     University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer:   Josh Tombs
-- 
-- Create Date:    SPRING 2015
-- Module Name:    Register Bank Test Bench
-- Project Name:   UMD_RISC16
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
-- Description:    Test for simple read write operations,
--     test enable, and the ability for register bank to
--     read on rising edge and write on falling edge.
---------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY register_bank_tb IS
END register_bank_tb;
 
ARCHITECTURE behavior OF register_bank_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT register_bank
    PORT(CLK     : IN   std_logic;
         ADDR_A  : IN   std_logic_vector(3 downto 0);
         ADDR_B  : IN   std_logic_vector(3 downto 0);
         W_ADDR  : IN   std_logic_vector(3 downto 0);
         R_W     : IN   std_logic;
         ENB     : IN   std_logic;
         DATA_IN : IN   std_logic_vector(15 downto 0);
         REG_A   : OUT  std_logic_vector(15 downto 0);
         REG_B   : OUT  std_logic_vector(15 downto 0));
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal ADDR_A : std_logic_vector(3 downto 0) := (others => '0');
   signal ADDR_B : std_logic_vector(3 downto 0) := (others => '0');
   signal W_ADDR : std_logic_vector(3 downto 0) := (others => '0');
   signal R_W : std_logic := '0';
   signal ENB : std_logic := '0';
   signal DATA_IN : std_logic_vector(15 downto 0) := (others => '0');

   --Outputs
   signal REG_A : std_logic_vector(15 downto 0);
   signal REG_B : std_logic_vector(15 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant CLK_period : time := 20 ns;
 
BEGIN
 
    -- Instantiate the Unit Under Test (UUT)
   uut: register_bank PORT MAP (
          CLK => CLK,
          ADDR_A => ADDR_A,
          ADDR_B => ADDR_B,
          W_ADDR => W_ADDR, 
          R_W => R_W,
          ENB => ENB,
          DATA_IN => DATA_IN,
          REG_A => REG_A,
          REG_B => REG_B
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
   tb: process
   begin        
      -- hold reset state for 100 ns.
      wait for 100 ns;    
      REPORT "Beginning Register Bank Tests." SEVERITY NOTE;
      wait for CLK_period*10;
      ADDR_A  <= x"0";
      ADDR_B  <= x"1";
      W_ADDR  <= x"1";
      R_W     <= '1';
      DATA_IN <= x"1234";
      ENB     <= '1';
      wait for CLK_period;
      W_ADDR  <= x"0";
      R_W     <= '1';
      DATA_IN <= x"5678";
      wait for CLK_period;
      R_W     <= '0';
      wait for CLK_period;
      ASSERT (REG_A = x"5678")
        REPORT "Register A output not correct."
        SEVERITY WARNING;
      ASSERT (REG_B = x"1234")
        REPORT "Register B output not correct."
        SEVERITY WARNING;
      wait for CLK_period;
      ADDR_B   <= x"2";
      wait for CLK_period;
      ASSERT (REG_B = x"0000")
        REPORT "Register B output not correct."
        SEVERITY WARNING;
     
      -- Test Enable
      ENB      <= '0';
      wait for CLK_period;
      W_ADDR   <= x"2";
      R_W      <= '1';
      DATA_IN  <= x"1010";
      wait for CLK_period;
      ASSERT (REG_B = x"0000")
        REPORT "Register B output not correct."
        SEVERITY WARNING;
      wait for CLK_period;
      
      -- Test read/write edges
      ENB      <= '1';
      R_W      <= '0';
      wait for CLK_period;
      W_ADDR   <= x"0";
      R_W      <= '1';
      DATA_IN  <= x"3333";
      wait for CLK_period/2;
      ASSERT (REG_A = x"5678")
        REPORT "Register A output at read edge not correct."
        SEVERITY WARNING;
      R_W      <= '0';
      wait for CLK_period/2;
      ASSERT (REG_A = x"3333")
        REPORT "Register A output after write edge not correct."
        SEVERITY WARNING;
      wait;
   end process;

END;
