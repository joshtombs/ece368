---------------------------------------------------
-- School:     University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer:   Brett Southworth
-- 
-- Create Date:    SPRING 2015
-- Module Name:    UMD RISC
-- Project Name:   AddrA_FSM
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
-- Description:    Finite State Machine for the Address A/CLKA of pipelineviewer
---------------------------------------------------
library IEEE;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_1164.ALL;
use work.ALL;

entity AddrA_FSM is
   Port(
			CLK : in STD_LOGIC;
			RST : in STD_LOGIC;
			Addr_Out : out STD_LOGIC_VECTOR(4 downto 0); 
			CLKA_Out : out STD_LOGIC
	     );
end AddrA_FSM;

architecture Behavioral of AddrA_FSM is
         type StateType is (init, Add,Done);
		   signal STATE : StateType := init;
			signal Clock : STD_LOGIC;

begin
	Process(CLK,RST) is
	variable instruction : STD_LOGIC_VECTOR(4 downto 0) := "00000";
		begin 
			if(RST = '1') then
			STATE <= init;
			elsif( CLK'event and CLK = '1') then
            case STATE is
				
				when init =>
				instruction := "00000";
				State <= Add;
				
				when Add =>
					if(instruction = x"11110")then
					STATE <= Done;
					else
					instruction := std_logic_vector(to_unsigned(to_integer(unsigned( instruction )) + 1, 5));
					STATE <= Add;
					end if;

				when Done =>
					-- Do nothing
					State <= Done;
				
				when others =>
				State <= init;
				
				end case;
				Addr_Out <= instruction;
				Clock <= CLK;
				CLKA_Out <= Clock;
			end if;
	end process;

end Behavioral;

