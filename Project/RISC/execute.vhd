---------------------------------------------------
-- School:     University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer:   Josh Tombs
-- 
-- Create Date:    SPRING 2015
-- Module Name:    Execute Block
-- Project Name:   UMD_RISC16
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
-- Description:    Execute portion of Datapath
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.UMDRISC_PKG.all;

entity execute is
    Port( CLK       : in STD_LOGIC;
          NOP       : in STD_LOGIC;
          OP1_IN    : in STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
          OP2_IN    : in STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
          OPCODE    : in STD_LOGIC_VECTOR(3 downto 0);
          REGA_ADDR : in STD_LOGIC_VECTOR(3 downto 0);
          RESULT_E  : in STD_LOGIC;
          NOP_OUT   : out STD_LOGIC;
          OP_OUT    : out STD_LOGIC_VECTOR(3 downto 0);
          CCR_OUT   : out STD_LOGIC_VECTOR(3 downto 0);
          REG_A_OUT : out STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
          W_REG_ADDR: out STD_LOGIC_VECTOR(3 downto 0);
          FWD_OUT   : out STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
          D_OUT     : out STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0));
end execute;

architecture Structural of execute is
    signal ALU_RESULT  : STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
    signal LDST_RESULT : STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
    signal RE_OUT1, RE_OUT2 : STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
    signal HIGH : STD_LOGIC := '1';
begin

    REG_RE_1: entity work.data_reg_re
    PORT MAP( CLK => CLK,
              D   => OP1_IN,
              ENB => HIGH,
              Q   => RE_OUT1);
                
    REG_RE_2: entity work.data_reg_re
    PORT MAP( CLK => CLK,
              D   => OP2_IN,
              ENB => HIGH,
              Q   => RE_OUT2);
                  
    A_VALUE_REG: entity work.data_reg
    PORT MAP(CLK => CLK,
             D   => OP1_IN,
             ENB => HIGH,
             Q   => REG_A_OUT);
     
    OP_REG: entity work.reg4
    PORT MAP( CLK => CLK,
              D   => OPCODE,
              ENB => HIGH,
              Q   => OP_OUT);

    ALU: entity work.ALU
    PORT MAP( RA       => RE_OUT1,
              RB       => RE_OUT2,
              OPCODE   => OPCODE,
              CCR      => CCR_OUT,
              ALU_OUT  => ALU_RESULT,
              LDST_OUT => LDST_RESULT);

    FWD_OUT <= ALU_RESULT;
    
    RESULT_REG: entity work.data_reg
    PORT MAP( CLK  => CLK,
              D    => ALU_RESULT,
              ENB  => RESULT_E,
              Q    => D_OUT);

     ADDR_REG: entity work.reg4
     PORT MAP( CLK  => CLK,
               D    => REGA_ADDR,
               ENB  => HIGH,
               Q    => W_REG_ADDR);
                    
    FF1 : entity work.flip_flop
    PORT MAP( CLK  => CLK,
              ENB  => HIGH,
              D    => NOP,
              Q    => NOP_OUT);
            
end Structural;

