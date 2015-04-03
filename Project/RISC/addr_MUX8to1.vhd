---------------------------------------------------
-- School:     University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer:   Josh Tombs
-- 
-- Create Date:    SPRING 2015
-- Module Name:    ADDR_MUX8to1
-- Project Name:   UMD_RISC16
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
-- Description:    Select one of eight inputs.
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.UMDRISC_PKG.all;

entity addr_MUX8to1 is
    Port( SEL    : in  STD_LOGIC_VECTOR (2 downto 0);
          IN0    : in  STD_LOGIC_VECTOR (INSTR_MEM_WIDTH-1 downto 0);
          IN1    : in  STD_LOGIC_VECTOR (INSTR_MEM_WIDTH-1 downto 0);
          IN2    : in  STD_LOGIC_VECTOR (INSTR_MEM_WIDTH-1 downto 0);
          IN3    : in  STD_LOGIC_VECTOR (INSTR_MEM_WIDTH-1 downto 0);
          IN4    : in  STD_LOGIC_VECTOR (INSTR_MEM_WIDTH-1 downto 0);
          IN5    : in  STD_LOGIC_VECTOR (INSTR_MEM_WIDTH-1 downto 0);
          IN6    : in  STD_LOGIC_VECTOR (INSTR_MEM_WIDTH-1 downto 0);
          IN7    : in  STD_LOGIC_VECTOR (INSTR_MEM_WIDTH-1 downto 0);
          OUTPUT : out  STD_LOGIC_VECTOR(INSTR_MEM_WIDTH-1 downto 0));
end addr_MUX8to1;

architecture Behavioral of addr_MUX8to1 is
    constant zero : integer := 0;
begin
    with SEL select
        OUTPUT<= IN0 when "000",
                 IN1 when "001",
                 IN2 when "010",
                 IN3 when "011",
                 IN4 when "100",
                 IN5 when "101",
                 IN6 when "110",
                 IN7 when "111",
                 std_logic_vector(to_unsigned(zero, INSTR_MEM_WIDTH)) when others;

end Behavioral;

