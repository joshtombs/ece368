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
         EXMEM_D_IN  : in STD_LOGIC_VECTOR(15 downto 0);
         EXMEM_WE    : out STD_LOGIC;
         EXMEM_RADDR : out STD_LOGIC_VECTOR(15 downto 0);
         EXMEM_WADDR : out STD_LOGIC_VECTOR(15 downto 0);
         EXMEM_D_OUT : out STD_LOGIC_VECTOR(15 downto 0);
         CCR_OUT : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RESET : std_logic := '0';
    signal EXMEM_D_IN : std_logic_vector(15 downto 0) := x"3333";

   --Outputs
   signal CCR_OUT : std_logic_vector(3 downto 0);
   signal EXMEM_WE : STD_LOGIC;
   signal EXMEM_RADDR : STD_LOGIC_VECTOR(15 downto 0);
   signal EXMEM_WADDR : STD_LOGIC_VECTOR(15 downto 0);
   signal EXMEM_D_OUT : STD_LOGIC_VECTOR(15 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 20 ns;
 
BEGIN
 
    -- Instantiate the Unit Under Test (UUT)
   uut: risc_machine PORT MAP (
          CLK => CLK,
          RESET => RESET,
          EXMEM_D_IN => EXMEM_D_IN,
          EXMEM_WE => EXMEM_WE,
          EXMEM_RADDR => EXMEM_RADDR,
          EXMEM_WADDR => EXMEM_WADDR,
          EXMEM_D_OUT => EXMEM_D_OUT,
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
