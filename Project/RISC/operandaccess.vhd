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

entity operandaccess is
    Port( CLK          : in  STD_LOGIC;
          DATA_IN      : in  STD_LOGIC_VECTOR(43 downto 0);
          W_ADDR       : in  STD_LOGIC_VECTOR(3 downto 0);
          BANK_R_W     : in  STD_LOGIC;
          BANK_ENB     : in  STD_LOGIC;
          BANK_DATA    : in  STD_LOGIC_VECTOR(15 downto 0);
          OP1_MUX_SEL  : in  STD_LOGIC_VECTOR(1 downto 0);
          OP2_MUX_SEL  : in  STD_LOGIC_VECTOR(1 downto 0);
          E_FWD_IN     : in  STD_LOGIC_VECTOR(15 downto 0);
          E_FWD_ADDR   : in  STD_LOGIC_VECTOR(3 downto 0);
          W_FWD_IN     : in  STD_LOGIC_VECTOR(15 downto 0);
          W_FWD_ADDR   : in  STD_LOGIC_VECTOR(3 downto 0);
          REGA_ADDR    : out STD_LOGIC_VECTOR(3 downto 0);
          OP1          : out STD_LOGIC_VECTOR(15 downto 0);
          OP2          : out STD_LOGIC_VECTOR(15 downto 0);
          OPCODE       : out STD_LOGIC_VECTOR(3 downto 0));
end operandaccess;

architecture Structural of operandaccess is
    signal REGA_OUT, REGB_OUT, OP1_MUX_OUT, OP2_MUX_OUT
                       : STD_LOGIC_VECTOR(15 downto 0);
    signal LOW : STD_LOGIC_VECTOR(15 downto 0) := x"0000";
    signal HIGH: STD_LOGIC := '1';
    signal write_address, E_FWDADDR_REG, W_FWDADDR_REG : STD_LOGIC_VECTOR(3 downto 0);
    signal DETECT_SEL1, DETECT_SEL2 : STD_LOGIC_VECTOR(1 downto 0);
begin
    BANK: entity work.register_bank
    PORT MAP( CLK     => CLK,
              ADDR_A  => DATA_IN(39 downto 36),
              ADDR_B  => DATA_IN(35 downto 32),
              W_ADDR  => write_address,
              R_W     => BANK_R_W,
              ENB     => BANK_ENB,
              DATA_IN => BANK_DATA,
              REG_A   => REGA_OUT,
              REG_B   => REGB_OUT);

    FWD_DETECT1: entity work.fwd_detection_unit
    PORT MAP( OPA_REG   => DATA_IN(39 downto 36),
              E_FWD_REG => E_FWDADDR_REG,
              W_FWD_REG => W_FWDADDR_REG,
              CTRL_SEL  => OP1_MUX_SEL,
              MUX_SEL   => DETECT_SEL1);
    
    OP1_MUX: entity work.MUX4to1
    PORT MAP( SEL => DETECT_SEL1,
              IN0 => REGA_OUT,
              IN1 => LOW,
              IN2 => W_FWD_IN,
              IN3 => E_FWD_IN,
              OUTPUT => OP1_MUX_OUT);
                 
    REG1 : entity work.reg16
    PORT MAP( CLK   => CLK,
              D     => OP1_MUX_OUT,
              ENB   => HIGH,
              Q     => OP1);

    FWD_DETECT2: entity work.fwd_detection_unit
    PORT MAP( OPA_REG   => DATA_IN(35 downto 32),
              E_FWD_REG => E_FWDADDR_REG,
              W_FWD_REG => W_FWDADDR_REG,
              CTRL_SEL  => OP2_MUX_SEL,
              MUX_SEL   => DETECT_SEL2);

    OP2_MUX: entity work.MUX4to1
    PORT MAP( SEL    => DETECT_SEL2,
              IN0    => REGB_OUT,
              IN1    => DATA_IN(31 downto 16),
              IN2    => W_FWD_IN,
              IN3    => E_FWD_IN,
              OUTPUT => OP2_MUX_OUT);

    REG2 : entity work.reg16
     PORT MAP( CLK   => CLK,
               D     => OP2_MUX_OUT,
               ENB   => HIGH,
               Q     => OP2);

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

end Structural;

