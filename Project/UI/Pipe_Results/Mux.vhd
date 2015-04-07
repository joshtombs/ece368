---------------------------------------------------
-- School: University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer: Daniel Noyes
-- 
-- Create Date:    SPRING 2015
-- Module Name:    Mux 8 to 1
-- Project Name:   VGA Toplevel
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
-- Description: Select one bit from a byte
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.all;

entity MUX16to1 is
    Port ( SEL : in  STD_LOGIC_VECTOR (31 downto 0);
           DATA0 : in  STD_LOGIC_VECTOR (15 downto 0);
			  DATA1 : in  STD_LOGIC_VECTOR (15 downto 0);
			  DATA2 : in  STD_LOGIC_VECTOR (15 downto 0);
			  DATA3 : in  STD_LOGIC_VECTOR (15 downto 0);
			  DATA4 : in  STD_LOGIC_VECTOR (15 downto 0);
			  DATA5 : in  STD_LOGIC_VECTOR (15 downto 0);
			  DATA6 : in  STD_LOGIC_VECTOR (15 downto 0);
			  DATA7 : in  STD_LOGIC_VECTOR (15 downto 0);
			  DATA8 : in  STD_LOGIC_VECTOR (15 downto 0);
			  DATA9 : in  STD_LOGIC_VECTOR (15 downto 0);
			  DATA10 : in  STD_LOGIC_VECTOR (15 downto 0);
			  DATA11 : in  STD_LOGIC_VECTOR (15 downto 0);
			  DATA12 : in  STD_LOGIC_VECTOR (15 downto 0);
			  DATA13 : in  STD_LOGIC_VECTOR (15 downto 0);
			  DATA14 : in  STD_LOGIC_VECTOR (15 downto 0);
			  DATA15 : in  STD_LOGIC_VECTOR (15 downto 0);
           OUTPUT : out  STD_LOGIC_VECTOR(15 downto 0));
end MUX16to1;

architecture Behavioral of MUX16to1 is

    signal SEL1 : STD_LOGIC_VECTOR (2 downto 0);

begin

SEL1<=SEL;

with SEL1 Select
    OUTPUT<= Data0   when "0000 0000 0000 0000 0000 0000 0000 0001" ,	
             Data0   when "0000 0000 0000 0000 0000 0000 0000 0010" ,
             Data1   when "0000 0000 0000 0000 0000 0000 0000 0100" ,
             Data1   when "0000 0000 0000 0000 0000 0000 0000 1000" ,
             Data2   when "0000 0000 0000 0000 0000 0000 0001 0000" ,
             Data2   when "0000 0000 0000 0000 0000 0000 0010 0000" ,
             Data3   when "0000 0000 0000 0000 0000 0000 0100 0000" ,
             Data3   when "0000 0000 0000 0000 0000 0000 1000 0000" ,
				 Data4   when "0000 0000 0000 0000 0000 0001 0000 0000" ,
             Data4   when "0000 0000 0000 0000 0000 0010 0000 0000" ,
             Data5   when "0000 0000 0000 0000 0000 0100 0000 0000" ,
             Data5   when "0000 0000 0000 0000 0000 1000 0000 0000" ,
             Data6   when "0000 0000 0000 0000 0001 0000 0000 0000" ,
             Data6   when "0000 0000 0000 0000 0010 0000 0000 0000" ,
             Data7   when "0000 0000 0000 0000 0100 0000 0000 0000" ,
             Data7   when "0000 0000 0000 0000 1000 0000 0000 0000" ,
				 Data8   when "0000 0000 0000 0001 0000 0000 0000 0000" ,
             Data8   when "0000 0000 0000 0010 0000 0000 0000 0000" ,
             Data9   when "0000 0000 0000 0100 0000 0000 0000 0000" ,
             Data9   when "0000 0000 0000 1000 0000 0000 0000 0000" ,
             Data10  when "0000 0000 0001 0000 0000 0000 0000 0000" ,
             Data10  when "0000 0000 0010 0000 0000 0000 0000 0000" ,
             Data11  when "0000 0000 0100 0000 0000 0000 0000 0000" ,
             Data11  when "0000 0000 1000 0000 0000 0000 0000 0000" ,
				 Data12  when "0000 0001 0000 0000 0000 0000 0000 0000" ,
             Data12  when "0000 0010 0000 0000 0000 0000 0000 0000" ,
             Data13  when "0000 0100 0000 0000 0000 0000 0000 0000" ,
             Data13  when "0000 1000 0000 0000 0000 0000 0000 0000" ,
             Data14  when "0001 0000 0000 0000 0000 0000 0000 0000" ,
             Data14  when "0010 0000 0000 0000 0000 0000 0000 0000" ,
             Data15  when "0100 0000 0000 0000 0000 0000 0000 0000" ,
             Data15  when "1000 0000 0000 0000 0000 0000 0000 0000" ,
				 "0000 0000 0000 0000" when others;
				 
end Behavioral;