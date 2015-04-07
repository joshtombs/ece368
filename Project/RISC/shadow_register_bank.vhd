---------------------------------------------------
-- School:     University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer:   Josh Tombs
-- 
-- Create Date: SPRING 2015
-- Module Name: shadow_register_bank
-- Project Name: UMD_RISC16
-- Target Devices: Spartan-3E
-- Tool versions: Xilinx ISE 14.7
-- Description: Create register bank with four registers
--     with the same width as DATA_WIDTH defined by UMDRISC16.
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.UMDRISC_PKG.all;

entity shadow_register_bank is
    Port( CLK    : in  STD_LOGIC;
          RESET  : in  STD_LOGIC;
          ENB    : in  STD_LOGIC;
          S_ADDR : in  STD_LOGIC_VECTOR(1 downto 0);
          W_ADDR : in  STD_LOGIC_VECTOR(1 downto 0);
          W_ENB  : in  STD_LOGIC;
          W_DATA : in  STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
          S_DATA : out STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0));
end shadow_register_bank;

architecture Behavioral of shadow_register_bank is
    type   bank_type is array (0 to 3) of std_logic_vector (DATA_WIDTH-1 downto 0);
    signal bank: bank_type := (others=> (others=>'0'));  -- initialize all registers to "0000"
begin
     PROCESS(CLK, RESET, ENB)
    begin
        if (CLK'EVENT and CLK = '1') then        --rising edge event (read)
            if(ENB = '1') then    --enabled and read
                S_DATA <= bank(to_integer(unsigned(S_ADDR)));
            end if;
        end if;
    end PROCESS;

    PROCESS(CLK, RESET, ENB, W_ENB)
    begin
        if (CLK'EVENT and CLK = '0') then    --falling edge event (write)
            if(RESET = '1') then
                bank(0) <= x"0000";
                bank(1) <= x"0000";
                bank(2) <= x"0000";
                bank(3) <= x"0000";
            elsif(ENB = '1' and W_ENB = '1') then    --enabled and write
                bank(to_integer(unsigned(W_ADDR))) <= W_DATA;
            end if;
        end if;
    end PROCESS;
end Behavioral;

