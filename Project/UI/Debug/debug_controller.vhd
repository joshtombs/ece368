---------------------------------------------------
-- School:     University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer:   Josh Tombs
-- 
-- Create Date:    SPRING 2015
-- Module Name:    Debug Unit
-- Project Name:   DebugUnit
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
-- Description:    Take ASCII character data in
--     and convert them to hex characters to
--     construct a 16 bit instruction code. 
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity debug_controller is
    Port( 	DATA_IN      : in STD_LOGIC_VECTOR (7 downto 0);
            CLK        : in STD_LOGIC;
            RD         : in STD_LOGIC;
            W_ENB      : in STD_LOGIC;
            DATA_OUT   : out STD_LOGIC_VECTOR (15 downto 0));
end debug_controller;

architecture Behavioral of debug_controller is
    type StateType is (init, idle, special_key, normal_key, flush, delete);
    signal STATE : StateType := init;
    signal HEX_CHAR: STD_LOGIC_VECTOR (3 downto 0);
    type ram_type is array (0 to 3) of std_logic_vector (3 downto 0);
    signal ram: ram_type;
    signal ram_addr: integer range 0 to 3;
    signal instruction: STD_LOGIC_VECTOR (15 downto 0) := (OTHERS => '0');
begin
    with DATA_IN select
        HEX_CHAR <= 
            x"f" when x"46", --F
            x"f" when x"66", --f
            x"e" when x"45", --E
            x"e" when x"65", --e
            x"d" when x"44", --D
            x"d" when x"64", --d
            x"c" when x"43", --C
            x"c" when x"63", --c
            x"b" when x"42", --B
            x"b" when x"62", --b
            x"a" when x"41", --A
            x"a" when x"61", --a
            x"9" when x"39", --9
            x"8" when x"38", --8
            x"7" when x"37", --7
            x"6" when x"36", --6
            x"5" when x"35", --5
            x"4" when x"34", --4
            x"3" when x"33", --3
            x"2" when x"32", --2
            x"1" when x"31", --1
            x"0" when x"30", --0
            x"0" when OTHERS; --unknown input

    PROCESS (CLK)
        variable instruction : STD_LOGIC_VECTOR(15 downto 0) := x"0000";
    begin
        if( CLK'event and CLK = '1') then
            case STATE is
                when init =>
                    ram_addr <= 0;
                    ram(0) <= (OTHERS => '0');
                    ram(1) <= (OTHERS => '0');
                    ram(2) <= (OTHERS => '0');
                    ram(3) <= (OTHERS => '0');
                    STATE <= idle;
                
                when idle =>
                    if( RD = '1' and W_ENB = '1') then
                        STATE <= normal_key;
                    elsif (RD= '1' and W_ENB = '0') then
                        STATE <= special_key;
                    end if;
                
                when special_key =>
                    if( DATA_IN = x"0D") then     --enter
                        STATE <= flush;
                    elsif ( DATA_IN = x"08") then --backspace
                        STATE <= delete;
                    else                          -- unknown special character
                        STATE <= idle;
                    end if;
                
                when normal_key =>
                    ram(ram_addr) <= HEX_CHAR;
                    if(ram_addr < 3) then
                        ram_addr <= ram_addr + 1;
                    end if;
                    STATE <= idle;
                
                when flush =>
                    instruction := (((ram(0) & ram(1)) & ram(2)) & ram(3));
                        STATE <= init;
                
                when delete =>
                    if(ram_addr > 0 and ram_addr < 3) then
                        ram_addr <= ram_addr - 1;
                    end if;
                    ram(ram_addr) <= x"0";
                    state <= idle;
                
                when OTHERS =>
                    STATE <= idle;
                    
            end case;
				DATA_OUT <= instruction;
        end if;
    end PROCESS;
end Behavioral;
