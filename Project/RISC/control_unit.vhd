---------------------------------------------------
-- School:     University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer:   Josh Tombs
-- 
-- Create Date:    SPRING 2015
-- Module Name:    ControlUnit
-- Project Name:   UMD_RISC16
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
-- Description:    Control unit for RISC16.
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control_unit is
    Port( CLK              : in  STD_LOGIC;
          RESET            : in  STD_LOGIC;
          -- Fetch
          PC_MUX_SEL       : out STD_LOGIC_VECTOR(1 downto 0);
          F_STALL_IN       : in  STD_LOGIC;
          INSTR_ENB        : out STD_LOGIC;
          PC_BR            : in  STD_LOGIC;
          -- Decode
          D_NOP_OUT        : out STD_LOGIC;
          -- Operand Access
          STACK_ENB        : out STD_LOGIC;
          STACK_OPERATION  : out STD_LOGIC; -- 0 = PUSH, 1 = POP
          PC_OP            : out STD_LOGIC;
          O_NOP_IN         : in  STD_LOGIC;
          O_NOP_OUT        : out STD_LOGIC;
          O_STALL_IN       : in  STD_LOGIC;
          OPA_OPCODE       : in  STD_LOGIC_VECTOR(3 downto 0);
          OP1_MUX_SEL      : out STD_LOGIC_VECTOR(1 downto 0);
          OP2_MUX_SEL      : out STD_LOGIC_VECTOR(1 downto 0);
          -- Execute
          EX_OPCODE        : in  STD_LOGIC_VECTOR(3 downto 0);
          E_NOP_IN         : in  STD_LOGIC;
          E_NOP_OUT        : out STD_LOGIC;
          RESULT_REG_E     : out STD_LOGIC;
          -- Writeback
          W_NOP_IN         : in  STD_LOGIC;
          W_NOP_OUT        : out STD_LOGIC;
          WB_OPCODE        : in  STD_LOGIC_VECTOR(3 downto 0);
          REG_BANK_WE      : out STD_LOGIC;
          DATA_MEM_MUX_SEL : out STD_LOGIC;
          DATA_MEM_WE      : out STD_LOGIC
          );
end control_unit;

architecture Behavioral of control_unit is
begin
    FETCH: PROCESS(CLK)
    begin
        if(CLK'EVENT and CLK = '1') then
            if(F_STALL_IN = '1') then
                PC_MUX_SEL <= "11";
                INSTR_ENB  <= '0';
            elsif( PC_BR = '1') then
                PC_MUX_SEL <= "10";
                INSTR_ENB  <= '1';
            else
                PC_MUX_SEL <= "00";
                INSTR_ENB  <= '1';
            end if;
        end if;
    end PROCESS;
    
    DECODE: PROCESS(CLK)
        variable BRJMP : STD_LOGIC := '0';
    begin
        if(CLK'EVENT and CLK = '1') then
            if( OPA_OPCODE = "1101" or OPA_OPCODE = "1110") then
                BRJMP := '1';
            elsif ( EX_OPCODE = "1101" or EX_OPCODE = "1110") then
                BRJMP := '1';
            elsif ( WB_OPCODE = "1101" or WB_OPCODE = "1110") then
                BRJMP := '1';
            else
                BRJMP := '0';
            end if;
            if(RESET = '1' or PC_BR = '1' or BRJMP = '1') then
                D_NOP_OUT <= '1';
            else
                D_NOP_OUT <= '0';
            end if;
        end if;
    end PROCESS;
    
    OPA: PROCESS(CLK)
         variable BRJMP : STD_LOGIC := '0';
    begin
        if(CLK'EVENT and CLK = '1') then
            OP1_MUX_SEL <= "00" ;    

            -- Operand MUX Select
            case OPA_OPCODE is
                when "0000" => OP2_MUX_SEL <= "00";
                when "0001" => OP2_MUX_SEL <= "00";
                when "0010" => OP2_MUX_SEL <= "00";
                when "0011" => OP2_MUX_SEL <= "00";
                when "0100" => OP2_MUX_SEL <= "00";
                when "0101" => OP2_MUX_SEL <= "01";
                when "0110" => OP2_MUX_SEL <= "01";
                when "0111" => OP2_MUX_SEL <= "01";
                when "1000" => OP2_MUX_SEL <= "01";
                when "1001" => OP2_MUX_SEL <= "01";
                when "1010" => OP2_MUX_SEL <= "01";
                when others => OP2_MUX_SEL <= "01";
            end case;

            -- Jump & Return
            if(OPA_OPCODE = "1101") then
                STACK_ENB <= '1';
                STACK_OPERATION <= '0';
                BRJMP := '1';
            elsif(OPA_OPCODE = "1110") then
                STACK_ENB <= '1';
                STACK_OPERATION <= '1';
                BRJMP := '1';
            else
                STACK_ENB <= '0';
                BRJMP := '0';
            end if;
            PC_OP <= BRJMP;

            --Determine if NOP
            if( O_NOP_IN = '1' or O_STALL_IN = '1' or RESET = '1' or BRJMP= '1' or PC_BR = '1') then
                O_NOP_OUT <= '1';
            else
                O_NOP_OUT <= '0';
            end if;
          end if;
    end PROCESS;
    
    EXECUTE: PROCESS(CLK)
    begin
        if(CLK'EVENT and CLK = '1') then
            RESULT_REG_E <= '1';
            if (E_NOP_IN = '1' or RESET = '1') then
                E_NOP_OUT <= '1';
            else
                E_NOP_OUT <= '0';
            end if;
        end if;
    end PROCESS;
    
    WB: PROCESS(CLK)
    begin
        if(CLK'EVENT and CLK = '1') then
            if (W_NOP_IN = '1' or RESET = '1') then
                W_NOP_OUT <= '1';
            else
                W_NOP_OUT <= '0';
            end if;
            case WB_OPCODE is
                when "0000"|"0001"|"0010"|"0011"|"0100"|"0101"|"0110"|"0111"|"1000" => 
                    DATA_MEM_MUX_SEL <= '1';
                    DATA_MEM_WE <= '0';
                    if(W_NOP_IN = '0' and RESET = '0') then
                        REG_BANK_WE <= '1';
                    else
                        REG_BANK_WE <= '0';
                    end if;
                when "1001" => 
                    DATA_MEM_MUX_SEL <= '0';
                    DATA_MEM_WE <= '0';
                    if(W_NOP_IN = '0' and RESET = '0') then
                        REG_BANK_WE <= '1';
                    else
                        REG_BANK_WE <= '0';
                    end if;
                when "1010" => 
                    DATA_MEM_MUX_SEL <= '0';
                    if(W_NOP_IN = '0' and RESET = '0') then
                        DATA_MEM_WE <= '1';
                    else
                        DATA_MEM_WE <= '0';
                    end if;
                    REG_BANK_WE <= '0';
                when others => 
                    DATA_MEM_MUX_SEL <= '1';
                    DATA_MEM_WE <= '0';
                    REG_BANK_WE <= '0';
            end case;
        end if;
    end PROCESS;

end Behavioral;

