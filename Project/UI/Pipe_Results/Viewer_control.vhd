---------------------------------------------------
-- School:     University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer:   Brett Southworth
-- 
-- Create Date:    SPRING 2015
-- Module Name:    UMD RISC
-- Project Name:   Viewer_Control
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
-- Description:    Structural Wrapper for 
--     Viewer controller. Controls the storing and 
--     writing of the pipeline viewer
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.ALL;

entity Viewer_control is
PORT (
		CLK     : in STD_LOGIC;
		RST     : in STD_LOGIC;
		IMUX    : out STD_LOGIC_VECTOR(2 downto 0);
		DMUX    : out STD_LOGIC_VECTOR(1 downto 0);
		--ASCII_SEND : out STD_LOGIC;
		--ENA : out STD_LOGIC;
		ADDRA   : out STD_LOGIC_VECTOR(4 downto 0); 
		ADDRB   : out STD_LOGIC_VECTOR(4 downto 0);
		CLKB    : out STD_LOGIC;
		CLKA    : out STD_LOGIC
		);
end Viewer_control;

architecture structural of Viewer_control is

begin

--ASCII_SEND <= CLK;

U1: entity work.ADDRA_FSM
port map(
			CLK => CLK,
			RST => RST,
			ADDR_OUT => ADDRA,			
			CLKA_Out => CLKA
			);
U2: entity work.ADDRB_FSM
port map(
			CLK => CLK,
			RST => RST,
			ADDR_OUT => ADDRB,			
			CLKB_Out => CLKB,
			I_Out => IMUX,
			D_Out => DMUX
			);
			

end structural;

