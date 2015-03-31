---------------------------------------------------
-- School: University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer: Brett Southworth
-- 
-- Create Date: SPRING 2015
-- Module Name: PC_Register
-- Project Name: UMD_RISC16
-- Target Devices: Spartan-3E
-- Tool versions: Xilinx ISE 14.7
-- Description: Program counter register
---------------------------------------------------

LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
use work.UMDRISC_PKG.all;
use work.all;

ENTITY PC_Reg IS
	PORT (	D       : IN	 	STD_LOGIC_VECTOR(INSTR_MEM_WIDTH-1 DOWNTO 0);
		Res     : IN		STD_LOGIC;	
		Enable  : IN 		STD_LOGIC;
		CLK     : IN 		STD_LOGIC ;
		Q       : OUT 		STD_LOGIC_VECTOR(INSTR_MEM_WIDTH-1 DOWNTO 0) ) ;
END PC_Reg ;

ARCHITECTURE Behavior OF PC_Reg IS	

signal Temp : STD_LOGIC_VECTOR(INSTR_MEM_WIDTH-1 DOWNTO 0);

BEGIN
	PROCESS (CLK, Res)
	BEGIN
                IF (Res = '1') THEN
			Q <= "000000000000";	-- Need to change if N changes
                ELSIF (CLK'EVENT AND CLK = '0' ) THEN
			IF (Enable = '1') THEN
				Q <= D ;
			END IF ;
		END IF;
	END PROCESS ;
END Behavior ;
