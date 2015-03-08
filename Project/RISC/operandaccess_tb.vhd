---------------------------------------------------
-- School:     University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer:   Josh Tombs
-- 
-- Create Date:    SPRING 2015
-- Module Name:    OperandAcess Test Bench
-- Project Name:   UMD_RISC16
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
-- Description:    Test bench for operand access block.
---------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY operandaccess_tb IS
END operandaccess_tb;
 
ARCHITECTURE behavior OF operandaccess_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)

    COMPONENT operandacess
    PORT(
         CLK : IN  std_logic;
         DATA_IN : IN  std_logic_vector(43 downto 0);
         W_ADDR : IN  std_logic_vector(3 downto 0);
         BANK_R_W : IN  std_logic;
         BANK_ENB : IN  std_logic;
         BANK_DATA : IN  std_logic_vector(15 downto 0);
         OP1_MUX_SEL : IN  std_logic_vector(1 downto 0);
         OP2_MUX_SEL : IN  std_logic_vector(1 downto 0);
         OP1 : OUT  std_logic_vector(15 downto 0);
         OP2 : OUT  std_logic_vector(15 downto 0);
         OPCODE : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal DATA_IN : std_logic_vector(43 downto 0) := (others => '0');
   signal W_ADDR : std_logic_vector(3 downto 0) := (others => '0');
   signal BANK_R_W : std_logic := '0';
   signal BANK_ENB : std_logic := '0';
   signal BANK_DATA : std_logic_vector(15 downto 0) := (others => '0');
   signal OP1_MUX_SEL : std_logic_vector(1 downto 0) := (others => '0');
   signal OP2_MUX_SEL : std_logic_vector(1 downto 0) := (others => '0');

   --Outputs
   signal OP1 : std_logic_vector(15 downto 0);
   signal OP2 : std_logic_vector(15 downto 0);
   signal OPCODE : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 20 ns;
 
BEGIN
 
    -- Instantiate the Unit Under Test (UUT)
   uut: operandacess PORT MAP (
          CLK => CLK,
          DATA_IN => DATA_IN,
          W_ADDR => W_ADDR,
          BANK_R_W => BANK_R_W,
          BANK_ENB => BANK_ENB,
          BANK_DATA => BANK_DATA,
          OP1_MUX_SEL => OP1_MUX_SEL,
          OP2_MUX_SEL => OP2_MUX_SEL,
          OP1 => OP1,
          OP2 => OP2,
          OPCODE => OPCODE
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
        wait for 100 ns;    
        REPORT "Beginning Operand Access Tests." SEVERITY NOTE;
        -- Initialize Bank with some Data (Also test bank write)
        BANK_ENB <= '1';
        W_ADDR <= x"0";
        BANK_R_W <= '1';
        BANK_DATA <= x"1111";
        wait for CLK_period;
        W_ADDR <= x"1";
        BANK_R_W <= '1';
        BANK_DATA <= x"1234";
        wait for CLK_period;
        W_ADDR <= x"2";
        BANK_R_W <= '1';
        BANK_DATA <= x"5678";
        wait for CLK_period;
        W_ADDR <= x"3";
        BANK_R_W <= '1';
        BANK_DATA <= x"8888";
        wait for CLK_period;
        
        --Instruction 1 (Reg A and Reg B)
        DATA_IN <= "00110001001000000000001000000000000000000010";
        OP1_MUX_SEL <= "00";
        OP2_MUX_SEL <= "00";
        BANK_R_W <= '0';
        wait for CLK_period;
        ASSERT (OP1 = x"1234")
          REPORT "Operand 1 incorrect."
          SEVERITY WARNING;
        ASSERT (OP2 = x"5678")
          REPORT "Operand 2 incorrect."
          SEVERITY WARNING;
        ASSERT (OPCODE = "0011")
          REPORT "Opcode incorrect."
          SEVERITY WARNING;
          
        --Instruction 2 (Reg A and Immediate)
        DATA_IN <= "10010011000100000000000111110000000000000001";
        OP1_MUX_SEL <= "00";
        OP2_MUX_SEL <= "01";
        BANK_R_W <= '0';
        wait for CLK_period;
        ASSERT (OP1 = x"8888")
          REPORT "Operand 1 incorrect."
          SEVERITY WARNING;
        ASSERT (OP2 = x"001F")
          REPORT "Operand 2 incorrect."
          SEVERITY WARNING;
        ASSERT (OPCODE = "1001")
          REPORT "Opcode incorrect."
          SEVERITY WARNING;
        wait for CLK_period;
        
      wait;
   end process;

END;
