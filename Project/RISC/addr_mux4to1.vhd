---------------------------------------------------
-- School:     University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer:   Josh Tombs
-- 
-- Create Date:    SPRING 2015
-- Module Name:    4to1Mux
-- Project Name:   UMD_RISC16
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
-- Description:    Select one of four inputs.
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.UMDRISC_PKG.all;

entity addr_MUX4to1 is
    Port( SEL    : in  STD_LOGIC_VECTOR (1 downto 0);
          IN0    : in  STD_LOGIC_VECTOR (INSTR_MEM_WIDTH-1 downto 0);
          IN1    : in  STD_LOGIC_VECTOR (INSTR_MEM_WIDTH-1 downto 0);
          IN2    : in  STD_LOGIC_VECTOR (INSTR_MEM_WIDTH-1 downto 0);
          IN3    : in  STD_LOGIC_VECTOR (INSTR_MEM_WIDTH-1 downto 0);
          OUTPUT : out  STD_LOGIC_VECTOR(INSTR_MEM_WIDTH-1 downto 0));
end addr_MUX4to1;

architecture Behavioral of addr_MUX4to1 is
    constant zero : integer := 0;
begin
    with SEL select
        OUTPUT<= IN0 when "00",
                 IN1 when "01",
                 IN2 when "10",
                 IN3 when "11",
                 std_logic_vector(to_unsigned(zero, INSTR_MEM_WIDTH)) when others;

end Behavioral;

