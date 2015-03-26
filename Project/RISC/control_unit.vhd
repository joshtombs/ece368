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
          -- Fetch
          PC_MUX_SEL       : out STD_LOGIC_VECTOR(1 downto 0);
          F_STALL_IN       : in  STD_LOGIC;
          INSTR_ENB        : out STD_LOGIC;
          -- Operand Access
          O_STALL_IN       : in  STD_LOGIC;
          OPA_OPCODE       : in  STD_LOGIC_VECTOR(3 downto 0);
          OP1_MUX_SEL      : out STD_LOGIC_VECTOR(1 downto 0);
          OP2_MUX_SEL      : out STD_LOGIC_VECTOR(1 downto 0);
          -- Execute
          RESULT_REG_E     : out STD_LOGIC;
          E_STALL_IN       : in  STD_LOGIC;
          -- Writeback
          W_STALL_IN       : in  STD_LOGIC;
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
            else
                PC_MUX_SEL <= "00";
                INSTR_ENB <= '1';
            end if;
        end if;
    end PROCESS;
    
--    DECODE: PROCESS(CLK)
--    begin
--        if(CLK'EVENT and CLK = '1') then
--        end if;
--    end PROCESS;
    
    OPA: PROCESS(CLK)
    begin
        if(CLK'EVENT and CLK = '1') then
            OP1_MUX_SEL <= "00" ;    
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
        end if;
    end PROCESS;
    
    EXECUTE: PROCESS(CLK)
    begin
        if(CLK'EVENT and CLK = '1') then
            RESULT_REG_E <= '1';
        end if;
    end PROCESS;
    
    WB: PROCESS(CLK, W_STALL_IN)
    begin
        if(CLK'EVENT and CLK = '1') then
            case WB_OPCODE is
                when "0000"|"0001"|"0010"|"0011"|"0100"|"0101"|"0110"|"0111"|"1000" => 
                    DATA_MEM_MUX_SEL <= '1';
                    DATA_MEM_WE <= '0';
                    if(W_STALL_IN = '0') then
                        REG_BANK_WE <= '1';
                    else
                        REG_BANK_WE <= '0';
                    end if;
                when "1001" => 
                    DATA_MEM_MUX_SEL <= '0';
                    DATA_MEM_WE <= '0';
                    if(W_STALL_IN = '0') then
                        REG_BANK_WE <= '1';
                    else
                        REG_BANK_WE <= '0';
                    end if;
                when "1010" => 
                    DATA_MEM_MUX_SEL <= '0';
                    if(W_STALL_IN = '0') then
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

