---------------------------------------------------
-- School:     University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer:   Josh Tombs
-- 
-- Create Date:    SPRING 2015
-- Module Name:    Register Bank
-- Project Name:   UMD_RISC16
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
-- Description:    Create a register bank to hold m
--     registers of size n bits.
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity register_bank is
    GENERIC ( M : INTEGER := 16; --Number of registers
              N : INTEGER := 16; --Size of registers
              A : INTEGER := 4); --Size of Addresses
                  
    Port( CLK     : in  STD_LOGIC;
          ADDR_A  : in  STD_LOGIC_VECTOR (A-1 downto 0);
          ADDR_B  : in  STD_LOGIC_VECTOR (A-1 downto 0);
          W_ADDR  : in  STD_LOGIC_VECTOR (A-1 downto 0);
          R_W     : in  STD_LOGIC;        -- 0 = read, 1 = write
          ENB     : in  STD_LOGIC;
          RESET   : in  STD_LOGIC;
          DATA_IN : in  STD_LOGIC_VECTOR (N-1 downto 0);
          REG_A   : out STD_LOGIC_VECTOR (N-1 downto 0);
          REG_B   : out STD_LOGIC_VECTOR (N-1 downto 0));
end register_bank;

architecture Behavioral of register_bank is
    type   bank_type is array (0 to M-1) of std_logic_vector (N-1 downto 0);
    signal bank: bank_type := (others=> (others=>'0'));  -- initialize all registers to "0000"
begin
    PROCESS(CLK, RESET, ENB, R_W)
    begin
          if (CLK'EVENT and CLK = '1') then        --rising edge event (read)
                if(ENB = '1') then    --enabled and read
                REG_A <= bank(to_integer(unsigned(ADDR_A)));
                REG_B <= bank(to_integer(unsigned(ADDR_B)));
            end if;
        end if;
    end PROCESS;

    PROCESS(CLK, RESET, ENB, R_W)
    begin
        if (CLK'EVENT and CLK = '0') then    --falling edge event (write)
            if(RESET = '1') then
                bank(0) <= x"0000";
                bank(1) <= x"0000";
                bank(2) <= x"0000";
                bank(3) <= x"0000";
                bank(4) <= x"0000";
                bank(5) <= x"0000";
                bank(6) <= x"0000";
                bank(7) <= x"0000";
                bank(8) <= x"0000";
                bank(9) <= x"0000";
                bank(10) <= x"0000";
                bank(11) <= x"0000";
                bank(12) <= x"0000";
                bank(13) <= x"0000";
                bank(14) <= x"0000";
                bank(15) <= x"0000";
            elsif(ENB = '1' and R_W = '1') then    --enabled and write
                bank(to_integer(unsigned(W_ADDR))) <= DATA_IN;
            end if;
        end if;
    end PROCESS;

end Behavioral;
