---------------------------------------------------
-- School:     University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer:   Josh Tombs
-- 
-- Create Date:    SPRING 2015
-- Module Name:    FWD_DETECTION_UNIT_tb
-- Project Name:   UMD_RISC16
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
-- Description:    Test bench for FWD detection unit.
---------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY fwd_detection_unit_tb IS
END fwd_detection_unit_tb;
 
ARCHITECTURE behavior OF fwd_detection_unit_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT fwd_detection_unit
    PORT(
         OPA_REG   : in  STD_LOGIC_VECTOR(3 downto 0);
         E_FWD_REG : in  STD_LOGIC_VECTOR(3 downto 0);
         W_FWD_REG : in  STD_LOGIC_VECTOR(3 downto 0);
         CTRL_SEL  : in  STD_LOGIC_VECTOR(1 downto 0);
         MUX_SEL   : out STD_LOGIC_VECTOR(1 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal OPA_REG  : std_logic_vector(3 downto 0) := (others => '0');
   signal E_FWD_REG  : std_logic_vector(3 downto 0) := (others => '0');
   signal W_FWD_REG  : std_logic_vector(3 downto 0) := (others => '0');
   signal CTRL_SEL : std_logic_vector(1 downto 0) := (others => '0');

   --Outputs
   signal MUX_SEL : std_logic_vector(1 downto 0);
   
   --Clock
   signal CLK : std_logic;    
 
   constant CLK_period : time := 20 ns;
 
BEGIN
 
    -- Instantiate the Unit Under Test (UUT)
   uut: fwd_detection_unit PORT MAP (
          OPA_REG => OPA_REG,
          E_FWD_REG => E_FWD_REG,
          W_FWD_REG => W_FWD_REG,
          CTRL_SEL => CTRL_SEL,
          MUX_SEL => MUX_SEL
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
      
        -- Mux sel "00"
       OPA_REG <= "0000";
       E_FWD_REG <= "0001";
       W_FWD_REG <= "0010";
       CTRL_SEL <= "00";
       wait for CLK_PERIOD/2;
       ASSERT(MUX_SEL = "00")
           REPORT("Mux select incorrect.")
           SEVERITY warning;
       wait for CLK_PERIOD/2;
       OPA_REG <= "0100";
       E_FWD_REG <= "0011";
       W_FWD_REG <= "0100";
       CTRL_SEL <= "00";
       wait for CLK_PERIOD/2;
       ASSERT(MUX_SEL = "10")
           REPORT("Mux select incorrect.")
           SEVERITY warning;
       wait for CLK_PERIOD/2;
       OPA_REG <= "0011";
       E_FWD_REG <= "0011";
       W_FWD_REG <= "1000";
       CTRL_SEL <= "00";
       wait for CLK_PERIOD/2;
       ASSERT(MUX_SEL = "11")
           REPORT("Mux select incorrect.")
           SEVERITY warning;
       wait for CLK_PERIOD/2;
       OPA_REG <= "0100";
       E_FWD_REG <= "0100";
       W_FWD_REG <= "0100";
       CTRL_SEL <= "00";
       wait for CLK_PERIOD/2;
       ASSERT(MUX_SEL = "11")
           REPORT("Mux select incorrect.")
           SEVERITY warning;
       wait for CLK_PERIOD/2;
       
       -- Mux sel "01"
       OPA_REG <= "0000";
       E_FWD_REG <= "0001";
       W_FWD_REG <= "0010";
       CTRL_SEL <= "01";
       wait for CLK_PERIOD/2;
       ASSERT(MUX_SEL = "01")
           REPORT("Mux select incorrect.")
           SEVERITY warning;
       wait for CLK_PERIOD/2;
       OPA_REG <= "0010";
       E_FWD_REG <= "0010";
       W_FWD_REG <= "0100";
       CTRL_SEL <= "01";
       wait for CLK_PERIOD/2;
       ASSERT(MUX_SEL = "01")
           REPORT("Mux select incorrect.")
           SEVERITY warning;

       wait;
   end process;

END;
