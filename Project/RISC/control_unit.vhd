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
          PC_MUX_SEL       : out STD_LOGIC_VECTOR(1 downto 0);
          OP1_MUX_SEL      : out STD_LOGIC_VECTOR(1 downto 0);
          OP2_MUX_SEL      : out STD_LOGIC_VECTOR(1 downto 0);
          RESULT_REG_E     : out STD_LOGIC;
          REG_BANK_WE      : out STD_LOGIC;
          REGBANK_D_SEL    : out STD_LOGIC_VECTOR(1 downto 0);
          DATA_MEM_MUX_SEL : out STD_LOGIC;
          DATA_MEM_WE      : out STD_LOGIC
          );
end control_unit;

architecture Behavioral of control_unit is
begin
    FETCH: PROCESS(CLK)
    begin
        if(CLK'EVENT and CLK = '1') then
            PC_MUX_SEL <= "00";
        end if;
    end PROCESS;
    
    DECODE: PROCESS(CLK)
    begin
        if(CLK'EVENT and CLK = '1') then
        end if;
    end PROCESS;
    
    OPA: PROCESS(CLK)
    begin
        if(CLK'EVENT and CLK = '1') then
        
        end if;
    end PROCESS;
    
    EXECUTE: PROCESS(CLK)
    begin
        if(CLK'EVENT and CLK = '1') then
            RESULT_REG_E <= '1';
        end if;
    end PROCESS;
    
    WB: PROCESS(CLK)
    begin
        if(CLK'EVENT and CLK = '1') then
            REG_BANK_WE <= '0';
            REGBANK_D_SEL <= "01";
            DATA_MEM_MUX_SEL <= '0';
            DATA_MEM_WE <= '0';
        end if;
    end PROCESS;

end Behavioral;

