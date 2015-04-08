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
use work.UMDRISC_PKG.all;

entity risc_machine is
    Port ( CLK         : in  STD_LOGIC;
           RESET       : in  STD_LOGIC;
           EXMEM_D_IN  : in  STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
           EXMEM_RADDR : out STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
           EXMEM_WE    : out STD_LOGIC;
           EXMEM_WADDR : out STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
           EXMEM_D_OUT : out STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
           CCR_OUT     : out STD_LOGIC_VECTOR(3 downto 0);
           B_Data0     : out STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
           B_Data1     : out STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
           B_Data2     : out STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
           B_Data3     : out STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
           B_Data4     : out STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
           B_Data5     : out STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
           B_Data6     : out STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
           B_Data7     : out STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
           B_Data8     : out STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
           B_Data9     : out STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
           B_Data10    : out STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
           B_Data11    : out STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
           B_Data12    : out STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
           B_Data13    : out STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
           B_Data14    : out STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
           B_Data15    : out STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0));
end risc_machine;

architecture Structural of risc_machine is
-- Specific signals
signal high : STD_LOGIC := '1';
signal low  : STD_LOGIC := '0';
signal INST_W_ADR : STD_LOGIC_VECTOR(INSTR_MEM_WIDTH-1 downto 0) := "000000000000";
signal INST_W_DATA : STD_LOGIC_VECTOR(INSTR_LENGTH-1 downto 0) := x"0000";

-- Connections
signal word : STD_LOGIC_VECTOR(55 downto 0);

signal pc_address, br_addr : STD_LOGIC_VECTOR(INSTR_MEM_WIDTH-1 downto 0);
signal SEL_1, SEL_2, prg_cntr_op, BR_JUMP_OP, instruction_id, instruction_id2wb,
       WB_MUX_SEL
              : STD_LOGIC_VECTOR(1 downto 0);
signal p_counter_mux_sel : STD_LOGIC_VECTOR(2 downto 0);
signal OP_OUT, WB_CNTRL_OPCODE, reg_a_address, bank_w_addr, ex_ccr_out
              : STD_LOGIC_VECTOR(3 downto 0);
signal OP1_TO_ALU, OP2_TO_ALU, instruction, FPU_OUT, BANKD, REG_A_VAL, forward_data, jump_addr,
       exmem_immediate, register_a_value
              : STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
signal DATA_MEM_WE, BANK_RW, RESULT_REG_ENB, F_STALL_OUT, D_STALL_OUT, O_STALL_OUT, 
       f_instr_enb, D_NOP_IN, D_NOP_OUT, O_NOP_IN, O_NOP_OUT, E_NOP_IN, E_NOP_OUT, W_NOP_IN,
       stack_enable, stack_op, br_mask_match, SBANK_W_ENABLE
              : STD_LOGIC;
begin
      U0: entity work.fetch
      PORT MAP( CLK           => CLK,
                MUX_SEL       => p_counter_mux_sel,
                ADD_A         => INST_W_ADR,
                D_IN          => INST_W_DATA,
                WEA_In        => low,
                PCRes         => RESET,
                INST_ENB      => f_instr_enb,
                JMP_IN        => jump_addr(INSTR_MEM_WIDTH-1 downto 0),
                BR_IN         => br_addr,
                STACK_ENB     => stack_enable,
                STACK_PUSHPOP => stack_op,
                BRJMP         => prg_cntr_op,
                BRJMP_OUT     => BR_JUMP_OP,
                PC_ADDR       => pc_address,
--              STACK_E       => ,
--              STACK_F       => ,
                INST_OUT      => instruction);

    U1: entity work.decode
    PORT MAP( CLK      => CLK,
              INST_IN  => instruction,
              PC_ADDR  => pc_address,
              NOP      => D_NOP_IN,
              MUX_SEL  => D_STALL_OUT,
              NOP_OUT  => D_NOP_OUT,
              DATA_OUT => word);

    U2: entity work.operandaccess
    PORT MAP( CLK           => CLK,
              NOP           => O_NOP_IN,
              E_NOP         => E_NOP_IN,
              W_NOP         => W_NOP_IN,
              NOP_OUT       => O_NOP_OUT,
              DATA_IN       => word,
              W_ADDR        => bank_w_addr,
              BANK_R_W      => BANK_RW,
              BANK_ENB      => high,
              BANK_RESET    => RESET,
              BANK_DATA     => BANKD,
              SBANK_W_ENB   => SBANK_W_ENABLE,
              SBANK_DATA    => BANKD,
              SBANK_W_ADDR  => "00",
              OP1_MUX_SEL   => SEL_1,
              OP2_MUX_SEL   => SEL_2,
              E_FWD_IN      => forward_data,
              E_FWD_ADDR    => reg_a_address,
              W_FWD_IN      => BANKD,
              W_FWD_ADDR    => bank_w_addr,
              CCR_IN        => ex_ccr_out,
              MASK_MATCH    => br_mask_match,
              REGA_ADDR     => reg_a_address,
              JMP_OUT       => jump_addr,
              BRANCH_OUT    => br_addr,
              ID_OUT        => instruction_id,
              EXMEM_IMM_OUT => exmem_immediate,
              RA_VALUE      => register_a_value,
              OP1           => OP1_TO_ALU,
              OP2           => OP2_TO_ALU,
              OPCODE        => OP_OUT,
              B_Data0      => B_Data0,
              B_Data1      => B_Data1,
              B_Data2      => B_Data2,
              B_Data3      => B_Data3,
              B_Data4      => B_Data4,
              B_Data5      => B_Data5,
              B_Data6      => B_Data6,
              B_Data7      => B_Data7,
              B_Data8      => B_Data8,
              B_Data9      => B_Data9,
              B_Data10      => B_Data10,
              B_Data11      => B_Data11,
              B_Data12      => B_Data12,
              B_Data13      => B_Data13,
              B_Data14      => B_Data14,
              B_Data15      => B_Data15);

    U3: entity work.execute
    PORT MAP( CLK        => CLK,
              NOP        => E_NOP_IN,
              NOP_OUT    => E_NOP_OUT,
              OP1_IN     => OP1_TO_ALU,
              OP2_IN     => OP2_TO_ALU,
              OPCODE     => OP_OUT,
              ID_IN      => instruction_id,
              ID_OUT     => instruction_id2wb,
              REGA_ADDR  => reg_a_address,
              REGA_VAL   => register_a_value,
              RESULT_E   => RESULT_REG_ENB,
              OP_OUT     => WB_CNTRL_OPCODE,
              CCR_OUT    => ex_ccr_out,
              REG_A_OUT  => REG_A_VAL,
              W_REG_ADDR => bank_w_addr,
              FWD_OUT    => forward_data,
              D_OUT      => FPU_OUT);

    CCR_OUT <= ex_ccr_out;

    U4: entity work.writeback
    PORT MAP( CLK         => CLK,
              D_In        => REG_A_VAL,
              WEA0        => DATA_MEM_WE,
              FPU_In      => FPU_OUT,
              D_OUT_SEL   => WB_MUX_SEL,
              EXMEM_RADDR => EXMEM_RADDR,
              EXMEM_WADDR => EXMEM_WADDR,
              EXMEM_DATA  => EXMEM_D_OUT,
              EXMEM_D_IN  => EXMEM_D_IN,
              D_Out       => BANKD);

    U5: entity work.control_unit
    PORT MAP(  CLK        => CLK,
         RESET            => RESET,
         -- Fetch
         PC_MUX_SEL       => p_counter_mux_sel,
         F_STALL_IN       => F_STALL_OUT,
         INSTR_ENB        => f_instr_enb,
         PC_BR            => BR_JUMP_OP,
         -- Decode
         D_NOP_OUT        => D_NOP_IN,
         -- Operand Access
         BRANCH_MATCH     => br_mask_match,
         STACK_ENB        => stack_enable,
         STACK_OPERATION  => stack_op,
         PC_OP            => prg_cntr_op,
         O_NOP_IN         => D_NOP_OUT,
         O_NOP_OUT        => O_NOP_IN,
         O_STALL_IN       => O_STALL_OUT,
         OPA_OPCODE       => word(43 downto 40),
         OP1_MUX_SEL      => SEL_1,
         OP2_MUX_SEL      => SEL_2,
         REG_BANK_WE      => BANK_RW,
         SBANK_WE         => SBANK_W_ENABLE,
         -- Execute
         EX_OPCODE        => OP_OUT,
         E_NOP_IN         => O_NOP_OUT,
         E_NOP_OUT        => E_NOP_IN,
         RESULT_REG_E     => RESULT_REG_ENB,
         -- Writeback
         W_NOP_IN         => E_NOP_OUT,
         W_NOP_OUT        => W_NOP_IN,
         WB_OPCODE        => WB_CNTRL_OPCODE,
         WB_ID            => instruction_id2wb,
         DATA_MEM_MUX_SEL => WB_MUX_SEL,
         EX_MEM_WE        => EXMEM_WE,
         DATA_MEM_WE      => DATA_MEM_WE);

    U6: entity work.stall_detection_unit
    PORT MAP( CLK      => CLK,
              INSTR_IN => instruction,
              F_STALL  => F_STALL_OUT,
              D_STALL  => D_STALL_OUT,
              O_STALL  => O_STALL_OUT);

end Structural;

