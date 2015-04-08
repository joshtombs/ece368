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
                  
    Port(  CLK     : in  STD_LOGIC;
           ADDR_A  : in  STD_LOGIC_VECTOR (A-1 downto 0);
           ADDR_B  : in  STD_LOGIC_VECTOR (A-1 downto 0);
           W_ADDR  : in  STD_LOGIC_VECTOR (A-1 downto 0);
           R_W     : in  STD_LOGIC;        -- 0 = read, 1 = write
           ENB     : in  STD_LOGIC;
           RESET   : in  STD_LOGIC;
           DATA_IN : in  STD_LOGIC_VECTOR(N-1 downto 0);
           REG_A   : out STD_LOGIC_VECTOR(N-1 downto 0);
           REG_B   : out STD_LOGIC_VECTOR(N-1 downto 0);
           B_Data0 : out STD_LOGIC_VECTOR(N-1 downto 0);
           B_Data1 : out STD_LOGIC_VECTOR(N-1 downto 0);
           B_Data2 : out STD_LOGIC_VECTOR(N-1 downto 0);
           B_Data3 : out STD_LOGIC_VECTOR(N-1 downto 0);
           B_Data4 : out STD_LOGIC_VECTOR(N-1 downto 0);
           B_Data5 : out STD_LOGIC_VECTOR(N-1 downto 0);
           B_Data6 : out STD_LOGIC_VECTOR(N-1 downto 0);
           B_Data7 : out STD_LOGIC_VECTOR(N-1 downto 0);
           B_Data8 : out STD_LOGIC_VECTOR(N-1 downto 0);
           B_Data9 : out STD_LOGIC_VECTOR(N-1 downto 0);
           B_Data10: out STD_LOGIC_VECTOR(N-1 downto 0);
           B_Data11: out STD_LOGIC_VECTOR(N-1 downto 0);
           B_Data12: out STD_LOGIC_VECTOR(N-1 downto 0);
           B_Data13: out STD_LOGIC_VECTOR(N-1 downto 0);
           B_Data14: out STD_LOGIC_VECTOR(N-1 downto 0);
           B_Data15: out STD_LOGIC_VECTOR(N-1 downto 0));
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
    B_Data0    <= bank(0);
    B_Data1    <= bank(1);
    B_Data2    <= bank(2);
    B_Data3    <= bank(3);
    B_Data4    <= bank(4);
    B_Data5    <= bank(5);
    B_Data6    <= bank(6);
    B_Data7    <= bank(7);
    B_Data8    <= bank(8);
    B_Data9    <= bank(9);
    B_Data10    <= bank(10);
    B_Data11    <= bank(11);
    B_Data12    <= bank(12);
    B_Data13    <= bank(13);
    B_Data14    <= bank(14);
    B_Data15    <= bank(15);

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
