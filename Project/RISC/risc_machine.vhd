---------------------------------------------------
-- School:     University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer:   Josh Tombs
-- 
-- Create Date:    SPRING 2015
-- Module Name:    RISC Machine
-- Project Name:   UMD_RISC16
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
-- Description:    RISC16 Machine
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.all;

entity risc_machine is
    Port ( CLK       : in  STD_LOGIC;
           RESET  : in  STD_LOGIC;
           CCR_OUT   : out STD_LOGIC_VECTOR(3 downto 0));
end risc_machine;

architecture Structural of risc_machine is
-- Specific signals
signal high : STD_LOGIC := '1';
signal low  : STD_LOGIC := '0';
signal INST_W_ADR : STD_LOGIC_VECTOR(4 downto 0) := "00000";
signal INST_W_DATA : STD_LOGIC_VECTOR(15 downto 0) := x"0000";

-- Connections
signal word : STD_LOGIC_VECTOR(43 downto 0);
signal SEL_1, SEL_2, p_counter_mux_sel : STD_LOGIC_VECTOR(1 downto 0);
signal OP_OUT, WB_CNTRL_OPCODE, reg_a_address, bank_w_addr
              : STD_LOGIC_VECTOR(3 downto 0);
signal OP1_TO_ALU, OP2_TO_ALU, instruction, FPU_OUT, BANKD, REG_A_VAL, forward_data
              : STD_LOGIC_VECTOR(15 downto 0);
signal DATA_MEM_WE, WB_MUX_SEL, BANK_RW, RESULT_REG_ENB, F_STALL_OUT, D_STALL_OUT, O_STALL_OUT, f_instr_enb, D_NOP_IN, D_NOP_OUT, O_NOP_IN, O_NOP_OUT, E_NOP_IN, E_NOP_OUT, W_NOP_IN
              : STD_LOGIC;
begin
      U0: entity work.fetch
      PORT MAP( CLK       => CLK,
                MUX_SEL   => p_counter_mux_sel,
                ADD_A     => INST_W_ADR,
                D_IN      => INST_W_DATA,
                WEA_In    => low,
                PCRes     => RESET,
                INST_ENB  => f_instr_enb,
                INST_OUT  => instruction);

     U1: entity work.decode
     PORT MAP( CLK      => CLK,
               INST_IN  => instruction,
               NOP      => D_NOP_IN,
               MUX_SEL  => D_STALL_OUT,
               NOP_OUT  => D_NOP_OUT,
               DATA_OUT => word);
                  
     U2: entity work.operandaccess
     PORT MAP( CLK         => CLK,
               NOP         => O_NOP_IN,
               E_NOP       => E_NOP_IN,
               W_NOP       => W_NOP_IN,
               NOP_OUT     => O_NOP_OUT,
               DATA_IN     => word,
               W_ADDR      => bank_w_addr,
               BANK_R_W    => BANK_RW,
               BANK_ENB    => high,
               BANK_RESET  => RESET,
               BANK_DATA   => BANKD,
               OP1_MUX_SEL => SEL_1,
               OP2_MUX_SEL => SEL_2,
               E_FWD_IN    => forward_data,
               E_FWD_ADDR  => reg_a_address,
               W_FWD_IN    => BANKD,
               W_FWD_ADDR  => bank_w_addr,
               REGA_ADDR   => reg_a_address,
               OP1         => OP1_TO_ALU,
               OP2         => OP2_TO_ALU,
               OPCODE      => OP_OUT);
     
     U3: entity work.execute
     PORT MAP( CLK        => CLK,
               NOP        => E_NOP_IN,
               NOP_OUT    => E_NOP_OUT,
               OP1_IN     => OP1_TO_ALU,
               OP2_IN     => OP2_TO_ALU,
               OPCODE     => OP_OUT,
               REGA_ADDR  => reg_a_address,
               RESULT_E   => RESULT_REG_ENB,
               OP_OUT     => WB_CNTRL_OPCODE,
               CCR_OUT    => CCR_OUT,
               REG_A_OUT  => REG_A_VAL,
               W_REG_ADDR => bank_w_addr,
               FWD_OUT    => forward_data,
               D_OUT      => FPU_OUT);
     
     U4: entity work.writeback
     PORT MAP( CLK       => CLK,
               D_In      => REG_A_VAL,
               WEA0      => DATA_MEM_WE,
               FPU_In    => FPU_OUT,
               D_OUT_SEL => WB_MUX_SEL,
               D_Out     => BANKD);

     U5: entity work.control_unit
     PORT MAP( CLK        => CLK,
          RESET            => RESET,
          -- Fetch
          PC_MUX_SEL       => p_counter_mux_sel,
          F_STALL_IN       => F_STALL_OUT,
          INSTR_ENB        => f_instr_enb,
          -- Decode
          D_NOP_OUT        => D_NOP_IN,
          -- Operand Access
          O_NOP_IN         => D_NOP_OUT,
          O_NOP_OUT        => O_NOP_IN,
          O_STALL_IN       => O_STALL_OUT,
          OPA_OPCODE       => word(43 downto 40),
          OP1_MUX_SEL      => SEL_1,
          OP2_MUX_SEL      => SEL_2,
          REG_BANK_WE      => BANK_RW,
          -- Execute
          E_NOP_IN         => O_NOP_OUT,
          E_NOP_OUT        => E_NOP_IN,
          RESULT_REG_E     => RESULT_REG_ENB,
          -- Writeback
          W_NOP_IN         => E_NOP_OUT,
          W_NOP_OUT        => W_NOP_IN,
          WB_OPCODE        => WB_CNTRL_OPCODE,
          DATA_MEM_MUX_SEL => WB_MUX_SEL,
          DATA_MEM_WE      => DATA_MEM_WE);

     U6: entity work.stall_detection_unit
     PORT MAP( CLK      => CLK,
               INSTR_IN => instruction,
               F_STALL  => F_STALL_OUT,
               D_STALL  => D_STALL_OUT,
               O_STALL  => O_STALL_OUT);

end Structural;

