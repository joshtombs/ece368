---------------------------------------------------
-- School:     University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer:   Josh Tombs
-- 
-- Create Date:    SPRING 2015
-- Module Name:    DEBUG_CONTROLLER_TB
-- Project Name:   DebugUnit
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
-- Description:      DEBUG_CONTROLLER Test Bench
---------------------------------------------------
LIBRARY ieee;
USE ieee.STD_LOGIC_1164.ALL;
USE ieee.STD_LOGIC_unsigned.all;
USE ieee.numeric_std.ALL;

ENTITY debug_controller_tb IS
END debug_controller_tb;
 
ARCHITECTURE behavior OF debug_controller_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT debug_controller
    PORT(
         DATA_IN : IN  std_logic_vector(7 downto 0);
         CLK     : IN  std_logic;
         RD      : IN  std_logic;
         W_ENB   : IN  std_logic;
         DATA_OUT: OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal DATA_IN  : std_logic_vector(7 downto 0) := (others => '0');
   signal clk      : std_logic := '0';
   signal ASCII_RD : std_logic := '0';
   signal ASCII_WE : std_logic := '0';

   --Outputs
   signal DATA_OUT : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant D_CLK_period : time := 20 ns;
 
BEGIN
 
   -- Instantiate the Unit Under Test (UUT)
   uut: debug_controller PORT MAP (
          DATA_IN  => DATA_IN,
          CLK      => CLK,
          RD       => ASCII_RD,
          W_ENB    => ASCII_WE,
          DATA_OUT => DATA_OUT
        );

   -- Clock process definitions
   clk_process :process
   begin
        clk <= '0';
        wait for D_CLK_period/2;
        clk <= '1';
        wait for D_CLK_period/2;
   end process;
 

   tb: process
   begin    
        wait for 100ns;
        report "Start Debug Test Bench!" severity NOTE;    
        -- 0 pressed
        DATA_IN <= x"30";
        ASCII_WE <= '1';
        wait for D_CLK_PERIOD;
        ASCII_RD <= '1';
        wait for D_CLK_PERIOD;
        ASCII_RD <= '0';
        wait for D_CLK_PERIOD;
        
        -- F pressed
        DATA_IN <= x"66";
        ASCII_WE <= '1';
        wait for D_CLK_PERIOD;
        ASCII_RD <= '1';
        wait for D_CLK_PERIOD;
        ASCII_RD <= '0';
        wait for D_CLK_PERIOD;
        
        -- C pressed
        DATA_IN <= x"63";
        ASCII_WE <= '1';
        wait for D_CLK_PERIOD;
        ASCII_RD <= '1';
        wait for D_CLK_PERIOD;
        ASCII_RD <= '0';
        wait for D_CLK_PERIOD;
        
        -- 0 pressed
        DATA_IN <= x"30";
        ASCII_WE <= '1';
        wait for D_CLK_PERIOD;
        ASCII_RD <= '1';
        wait for D_CLK_PERIOD;
        ASCII_RD <= '0';
        wait for D_CLK_PERIOD;
        
        -- ENTER pressed
        DATA_IN <= x"0D";
        ASCII_WE <= '0';
        wait for D_CLK_PERIOD;
        ASCII_RD <= '1';
        wait for D_CLK_PERIOD;
        ASCII_RD <= '0';
        wait for D_CLK_PERIOD;
        
        wait for 100 ns;
        
        -- BKSP pressed
        DATA_IN <= x"08";
        ASCII_WE <= '0';
        wait for D_CLK_PERIOD;
        ASCII_RD <= '1';
        wait for D_CLK_PERIOD;
        ASCII_RD <= '0';
        wait for D_CLK_PERIOD;
		  
		  -- 1 pressed
        DATA_IN <= x"31";
        ASCII_WE <= '1';
        wait for D_CLK_PERIOD;
        ASCII_RD <= '1';
        wait for D_CLK_PERIOD;
        ASCII_RD <= '0';
        wait for D_CLK_PERIOD;
        
        -- E pressed
        DATA_IN <= x"65";
        ASCII_WE <= '1';
        wait for D_CLK_PERIOD;
        ASCII_RD <= '1';
        wait for D_CLK_PERIOD;
        ASCII_RD <= '0';
        wait for D_CLK_PERIOD;
        
        -- BKSP pressed
        DATA_IN <= x"08";
        ASCII_WE <= '0';
        wait for D_CLK_PERIOD;
        ASCII_RD <= '1';
        wait for D_CLK_PERIOD;
        ASCII_RD <= '0';
        wait for D_CLK_PERIOD;
        
        -- f pressed
        DATA_IN <= x"66";
        ASCII_WE <= '1';
        wait for D_CLK_PERIOD;
        ASCII_RD <= '1';
        wait for D_CLK_PERIOD;
        ASCII_RD <= '0';
        wait for D_CLK_PERIOD;
        
        -- A pressed
        DATA_IN <= x"61";
        ASCII_WE <= '1';
        wait for D_CLK_PERIOD;
        ASCII_RD <= '1';
        wait for D_CLK_PERIOD;
        ASCII_RD <= '0';
        wait for D_CLK_PERIOD;
        
        -- 0 pressed
        DATA_IN <= x"30";
        ASCII_WE <= '1';
        wait for D_CLK_PERIOD;
        ASCII_RD <= '1';
        wait for D_CLK_PERIOD;
        ASCII_RD <= '0';
        wait for D_CLK_PERIOD;
		  
		  -- BKSP pressed
        DATA_IN <= x"08";
        ASCII_WE <= '0';
        wait for D_CLK_PERIOD;
        ASCII_RD <= '1';
        wait for D_CLK_PERIOD;
        ASCII_RD <= '0';
        wait for D_CLK_PERIOD;
		  
		  -- 1 pressed
        DATA_IN <= x"31";
        ASCII_WE <= '1';
        wait for D_CLK_PERIOD;
        ASCII_RD <= '1';
        wait for D_CLK_PERIOD;
        ASCII_RD <= '0';
        wait for D_CLK_PERIOD;
        
        -- ENTER pressed
        DATA_IN <= x"0D";
        ASCII_WE <= '0';
        wait for D_CLK_PERIOD;
        ASCII_RD <= '1';
        wait for D_CLK_PERIOD;
        ASCII_RD <= '0';
        wait for D_CLK_PERIOD;
        
        wait for 100ns;
      wait;
   end process;

END;
