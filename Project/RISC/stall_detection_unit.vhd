---------------------------------------------------
-- School:     University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer:   Josh Tombs
-- 
-- Create Date:    SPRING 2015
-- Module Name:    Stall_Detection_Unit
-- Project Name:   UMD_RISC16
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
-- Description:    Unit to determine whether or not
--     a stall is to be inserted into pipeline.
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity stall_detection_unit is
    Port( CLK      : in  STD_LOGIC;
          INSTR_IN : in  STD_LOGIC_VECTOR(15 downto 0);
          F_STALL  : out STD_LOGIC;
			 D_STALL  : out STD_LOGIC;
			 O_STALL  : out STD_LOGIC;
			 E_STALL  : out STD_LOGIC;
			 W_STALL  : out STD_LOGIC);
end stall_detection_unit;

architecture Mixed of stall_detection_unit is
     signal high : STD_LOGIC := '1';
     signal reg0to1, reg1to2, reg2to3, reg3to4, reg4 : STD_LOGIC_VECTOR(15 downto 0);
     signal load, loadeqlA, loadeqlB, inst_LT_five, regB_problem, reg_problem, STALL, ff1_stall, ff2_stall
        :STD_LOGIC := '0';
begin
    R0: entity work.reg16
    PORT MAP( CLK => CLK,
              D   => INSTR_IN,
              ENB => HIGH,
              Q   => reg0to1);
                 
    R1: entity work.reg16
    PORT MAP( CLK => CLK,
              D   => reg0to1,
              ENB => HIGH,
              Q   => reg1to2);
    
    R2: entity work.reg16
    PORT MAP( CLK => CLK,
              D   => reg1to2,
              ENB => HIGH,
              Q   => reg2to3);
    
    R3: entity work.reg16
    PORT MAP( CLK => CLK,
              D   => reg2to3,
              ENB => HIGH,
              Q   => reg3to4);
    
    R4: entity work.reg16
    PORT MAP( CLK => CLK,
              D   => reg3to4,
              ENB => HIGH,
              Q   => reg4);

    load <= '1' when reg2to3(15 downto 12) = "1001" else
            '0';
                
    loadeqlA <= '1' when reg2to3(11 downto 8) = reg1to2(11 downto 8) else
                '0';
    
    loadeqlB <= '1' when reg2to3(11 downto 8) = reg1to2(7 downto 4) else
                '0';
                
    inst_LT_five <= '1' when reg1to2(15 downto 12) < "0101" else
                    '0';
    
    regB_problem <= loadeqlB and inst_LT_five;
    
    reg_problem <= loadeqlA or regB_problem;
    
    STALL<= load and reg_problem;
	 
	 F_STALL <= STALL;
	 
	 D_STALL <= STALL;
	 
	 O_STALL <= STALL;
	 
	 FF1: entity work.flip_flop
	 PORT MAP( CLK  => CLK,
				  ENB  => HIGH,
				  D    => STALL,
				  Q    => ff1_stall);
	
	 E_STALL <= ff1_stall;
	 
	 FF2: entity work.flip_flop
	 PORT MAP( CLK  => CLK,
				  ENB  => HIGH,
				  D    => ff1_stall,
				  Q    => ff2_stall);
	
	 W_STALL <= ff2_stall;
end Mixed;