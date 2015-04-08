---------------------------------------------------
-- School:     University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer:   Brett Southworth
-- 
-- Create Date:    SPRING 2015
-- Module Name:    Mux16to1
-- Project Name:   VGA Toplevel
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
-- Description: Multiplexer to select one of 16 signals.
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.all;
use work.UMDRISC_PKG.all;

entity MUX16to1 is
    Port ( SEL  : in  STD_LOGIC_VECTOR (3 downto 0);
           In0  : in  STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           In1  : in  STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           In2  : in  STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           In3  : in  STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           In4  : in  STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           In5  : in  STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           In6  : in  STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           In7  : in  STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           In8  : in  STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           In9  : in  STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           In10 : in  STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           In11 : in  STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           In12 : in  STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           In13 : in  STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           In14 : in  STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           In15 : in  STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           OUTPUT : out  STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0));
end MUX16to1;

architecture Behavioral of MUX16to1 is

    signal SEL1 : STD_LOGIC_VECTOR (3 downto 0);

begin

SEL1<=SEL;

with SEL1 Select
    OUTPUT<= In0   when x"0",
             In1   when x"1",
             In2   when x"2",
             In3   when x"3",
			 In4   when x"4",
             In5   when x"5",
             In6   when x"6",
             In7   when x"7",
             In8   when x"8",
             In9   when x"9",
             In10  when x"A",
             In11  when x"B",
             In12  when x"C",
             In13  when x"D",
             In14  when x"E",
             In15  when x"F",
             x"0000" when others;

end Behavioral;