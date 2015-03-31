---------------------------------------------------
-- School:     University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer:   Josh Tombs
-- 
-- Create Date:    SPRING 2015
-- Module Name:    Stack
-- Project Name:   UMD_RISC16
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
-- Description:    FIFO Stack to maintain return 
--     addresses for program counter.
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use work.UMDRISC_PKG.all;

entity stack is
    Generic( A : integer := 4;   -- Number of Address bits
             N : integer := 16); -- Number of stack locations
    Port( CLK      : in  STD_LOGIC;
          ENB      : in  STD_LOGIC;
          PUSH_POP : in  STD_LOGIC; -- 0 = push, 1 = pop
          DATA_IN  : in  STD_LOGIC_VECTOR(INSTR_MEM_WIDTH-1 downto 0);
          S_EMPTY  : out STD_LOGIC;
          S_FULL   : out STD_LOGIC;
          DATA_OUT : out STD_LOGIC_VECTOR(INSTR_MEM_WIDTH-1 downto 0));
end stack;

architecture Behavioral of stack is
    type   stack_type is array (0 to N-1) of std_logic_vector (INSTR_MEM_WIDTH-1 downto 0);
    signal stack: stack_type := (others=> (others=>'0'));  -- initialize all registers to "00000"
    signal stack_ptr : integer := 0;
    signal full, empty : STD_LOGIC := '0';
begin
    S_FULL <= full;
    S_EMPTY <= empty;
     
    PROCESS(CLK)
    begin
        if(CLK'EVENT and CLK = '0') then
            if( stack_ptr = N ) then
                full <= '1';
                empty <= '0';
            elsif( stack_ptr = 0) then
                full <= '0';
                empty <= '1';
            else
                full <= '0';
                empty <= '0';
            end if;
            -- PUSH
            if(ENB = '1' AND PUSH_POP = '0' AND FULL = '0') then
                stack(stack_ptr) <= DATA_IN;
                if( stack_ptr < N ) then
                    stack_ptr <= stack_ptr + 1;
                end if;
            end if;
            -- POP
            if(ENB = '1' AND PUSH_POP = '1' AND EMPTY = '0') then
                DATA_OUT <= stack(stack_ptr - 1);
                if(stack_ptr > 0) then
                    stack_ptr <= stack_ptr - 1;
                end if;
            end if;
        end if;
    end PROCESS;

end Behavioral;

