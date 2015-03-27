---------------------------------------------------
-- School:     University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer:   Josh Tombs
-- 
-- Create Date:    SPRING 2015
-- Module Name:    Decode Block
-- Project Name:   UMD_RISC16
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
-- Description:    Decode portion of Datapath
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decode is
    Port( CLK     : in  STD_LOGIC;
          INST_IN : in  STD_LOGIC_VECTOR (15 downto 0);
          MUX_SEL : in  STD_LOGIC;
          NOP     : out STD_LOGIC;
          DATA_OUT: out STD_LOGIC_VECTOR (43 downto 0));
end decode;

architecture Mixed of decode is
    signal tmp : STD_LOGIC_VECTOR (43 downto 0) := (OTHERS => '0');
    signal instruction, re_out, fe_out : STD_LOGIC_VECTOR(15 downto 0) := (OTHERS => '0');
    signal high : STD_LOGIC := '1';
begin
    tmp(43 downto 40) <= instruction(15 downto 12);
    tmp(39 downto 36) <= instruction(11 downto 8);
    tmp(35 downto 32) <= instruction(7 downto 4);
    tmp(31 downto 24) <= x"00";
    tmp(23 downto 16) <= instruction(7 downto 0);
    tmp(15 downto 0)  <= x"0000";
    PROCESS(CLK)
    BEGIN
        IF(CLK'EVENT AND CLK = '0') THEN
            DATA_OUT <= tmp;
            if(INST_IN = x"0000") then
                NOP <= '1';
            else
                NOP <= '0';
            end if;
        END IF;
    END PROCESS;

    reg1: entity work.reg16_re
    port map( CLK  => CLK,
              ENB  => HIGH,
              D    => INST_IN,
              Q    => re_out);

    reg2: entity work.reg16
    port map( CLK  => CLK,
              ENB  => HIGH,
              D    => re_out,
              Q    => fe_out);

    MUX: entity work.MUX2to1
    port map(SEL     => MUX_SEL,
             IN0     => INST_IN,
             IN1     => fe_out,
             OUTPUT  => instruction);
end Mixed;

