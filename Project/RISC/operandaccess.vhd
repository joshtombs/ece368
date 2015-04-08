---------------------------------------------------
-- School:     University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer:   Josh Tombs
-- 
-- Create Date:    SPRING 2015
-- Module Name:    OperandAcess
-- Project Name:   UMD_RISC16
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
-- Description:    Data path for operand access.
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.UMDRISC_PKG.all;

entity operandaccess is
    Port( CLK          : in  STD_LOGIC;
          NOP          : in  STD_LOGIC;
          E_NOP        : in  STD_LOGIC;
          W_NOP        : in  STD_LOGIC;
          DATA_IN      : in  STD_LOGIC_VECTOR(55 downto 0);
          W_ADDR       : in  STD_LOGIC_VECTOR(3 downto 0);
          BANK_R_W     : in  STD_LOGIC;
          BANK_ENB     : in  STD_LOGIC;
          BANK_RESET   : in  STD_LOGIC;
          BANK_DATA    : in  STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
          SBANK_W_ENB  : in  STD_LOGIC;
          SBANK_DATA   : in  STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
          SBANK_W_ADDR : in  STD_LOGIC_VECTOR(1 downto 0);
          OP1_MUX_SEL  : in  STD_LOGIC_VECTOR(1 downto 0);
          OP2_MUX_SEL  : in  STD_LOGIC_VECTOR(1 downto 0);
          E_FWD_IN     : in  STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
          E_FWD_ADDR   : in  STD_LOGIC_VECTOR(3 downto 0);
          W_FWD_IN     : in  STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
          W_FWD_ADDR   : in  STD_LOGIC_VECTOR(3 downto 0);
          CCR_IN       : in  STD_LOGIC_VECTOR(3 downto 0);
          MASK_MATCH   : out STD_LOGIC;
          NOP_OUT      : out STD_LOGIC;
          REGA_ADDR    : out STD_LOGIC_VECTOR(3 downto 0);
          JMP_OUT      : out STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
          BRANCH_OUT   : out STD_LOGIC_VECTOR(INSTR_MEM_WIDTH-1 downto 0);
          ID_OUT       : out STD_LOGIC_VECTOR(1 downto 0);
          EXMEM_IMM_OUT: out STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
          RA_VALUE     : out STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
          OP1          : out STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
          OP2          : out STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
          OPCODE       : out STD_LOGIC_VECTOR(3 downto 0));
end operandaccess;

architecture Mixed of operandaccess is
    signal REGA_OUT, REGB_OUT, OP1_MUX_OUT, OP2_MUX_OUT, REGS_OUT, operand2, REGA_MUX_OUT
                       : STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
    signal LOW : STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0) := x"0000";
    signal HIGH: STD_LOGIC := '1';
    signal write_address, E_FWDADDR_REG, W_FWDADDR_REG, MASK_BITS : STD_LOGIC_VECTOR(3 downto 0);
    signal DETECT_SEL1, DETECT_SEL2, ID_REG_OUT, DETECT_SEL3 : STD_LOGIC_VECTOR(1 downto 0);
begin
    BANK: entity work.register_bank
    PORT MAP( CLK     => CLK,
              ADDR_A  => DATA_IN(39 downto 36),
              ADDR_B  => DATA_IN(35 downto 32),
              W_ADDR  => write_address,
              R_W     => BANK_R_W,
              ENB     => BANK_ENB,
              RESET   => BANK_RESET,
              DATA_IN => BANK_DATA,
              REG_A   => REGA_OUT,
              REG_B   => REGB_OUT);

    SHDW_BANK: entity work.shadow_register_bank
    PORT MAP( CLK    => CLK,
              RESET  => BANK_RESET,
              ENB    => BANK_ENB,
              S_ADDR => DATA_IN(35 downto 34),
              W_ADDR => SBANK_W_ADDR,
              W_ENB  => SBANK_W_ENB,
              W_DATA => SBANK_DATA,
              S_DATA => REGS_OUT);

    FWD_DETECT1: entity work.fwd_detection_unit
    PORT MAP( OPA_REG   => DATA_IN(39 downto 36),
              E_FWD_REG => E_FWDADDR_REG,
              W_FWD_REG => W_FWDADDR_REG,
              E_NOP     => E_NOP,
              W_NOP     => W_NOP,
              CTRL_SEL  => OP1_MUX_SEL,
              MUX_SEL   => DETECT_SEL1);
    
    OP1_MUX: entity work.MUX4to1
    PORT MAP( SEL => DETECT_SEL1,
              IN0 => REGA_OUT,
              IN1 => REGS_OUT,
              IN2 => W_FWD_IN,
              IN3 => E_FWD_IN,
              OUTPUT => OP1_MUX_OUT);

    REG1 : entity work.data_reg
    PORT MAP( CLK   => CLK,
              D     => OP1_MUX_OUT,
              ENB   => HIGH,
              Q     => OP1);

    FWD_DETECT2: entity work.fwd_detection_unit
    PORT MAP( OPA_REG   => DATA_IN(35 downto 32),
              E_FWD_REG => E_FWDADDR_REG,
              W_FWD_REG => W_FWDADDR_REG,
              E_NOP     => E_NOP,
              W_NOP     => W_NOP,
              CTRL_SEL  => OP2_MUX_SEL,
              MUX_SEL   => DETECT_SEL2);

    OP2_MUX: entity work.MUX4to1
    PORT MAP( SEL    => DETECT_SEL2,
              IN0    => REGB_OUT,
              IN1    => DATA_IN(31 downto 16),
              IN2    => W_FWD_IN,
              IN3    => E_FWD_IN,
              OUTPUT => OP2_MUX_OUT);

    REG2 : entity work.data_reg
    PORT MAP( CLK   => CLK,
              D     => OP2_MUX_OUT,
              ENB   => HIGH,
              Q     => operand2);

    OP2 <= operand2;

    REG3 : entity work.reg4
    PORT MAP( CLK   => CLK,
              D     => DATA_IN(43 downto 40),
              ENB   => HIGH,
              Q     => OPCODE);

    REG4 : entity work.reg4
    PORT MAP ( CLK  => CLK,
               D    => DATA_IN(39 downto 36),
               ENB  => HIGH,
               Q    => REGA_ADDR);

    REG5 : entity work.reg4_re
    PORT MAP ( CLK  => CLK,
               D    => W_ADDR,
               ENB  => HIGH,
               Q    => write_address);

    REG6 : entity work.reg4_re
    PORT MAP ( CLK  => CLK,
               D    => E_FWD_ADDR,
               ENB  => HIGH,
               Q    => E_FWDADDR_REG);
    
    REG7 : entity work.reg4_re
    PORT MAP( CLK  => CLK,
              D    => W_FWD_ADDR,
              ENB  => HIGH,
              Q    => W_FWDADDR_REG);
                  
    REG8 : entity work.flip_flop
    PORT MAP( CLK  => CLK,
              ENB  => HIGH,
              D    => NOP,
              Q    => NOP_OUT);

    REG9 : entity work.data_reg
    PORT MAP( CLK  => CLK,
              ENB  => HIGH,
              D    => DATA_IN(15 downto 0),
              Q    => JMP_OUT);

    BR_ADDR : entity work.branch_adder
    PORT MAP(PC_ADDR   => DATA_IN(55 downto 44),
             IMMEDIATE => DATA_IN(31 downto 16),
             RESULT    => BRANCH_OUT);

    ID_REG : entity work.flip_flop2
    PORT MAP( CLK  => CLK,
              ENB  => HIGH,
              D    => DATA_IN(33 downto 32),
              Q    => ID_REG_OUT);

    ID_OUT <= ID_REG_OUT;

    FWD_DETECT3: entity work.fwd_detection_unit
    PORT MAP( OPA_REG   => DATA_IN(35 downto 32),
              E_FWD_REG => E_FWDADDR_REG,
              W_FWD_REG => W_FWDADDR_REG,
              E_NOP     => E_NOP,
              W_NOP     => W_NOP,
              CTRL_SEL  => LOW(1 downto 0),
              MUX_SEL   => DETECT_SEL3);

     REGA_MUX: entity work.MUX4to1
    PORT MAP( SEL    => DETECT_SEL3,
              IN0    => REGA_OUT,
              IN1    => LOW,
              IN2    => W_FWD_IN,
              IN3    => E_FWD_IN,
              OUTPUT => REGA_MUX_OUT);

     REG10 : entity work.data_reg
    PORT MAP( CLK  => CLK,
              ENB  => HIGH,
              D    => REGA_MUX_OUT,
              Q    => RA_VALUE);

    MASK_BITS(0) <= (CCR_IN(0) XNOR DATA_IN(36));
    MASK_BITS(1) <= (CCR_IN(1) XNOR DATA_IN(37));
    MASK_BITS(2) <= (CCR_IN(2) XNOR DATA_IN(38));
    MASK_BITS(3) <= (CCR_IN(3) XNOR DATA_IN(39));

    MASK_MATCH <=  MASK_BITS(3) AND MASK_BITS(2) AND MASK_BITS(1) AND MASK_BITS(0);

end Mixed;

