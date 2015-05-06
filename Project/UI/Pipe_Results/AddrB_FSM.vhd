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
-- Description:    Finite State Machine for the Address B/CLKB of pipelineviewer
---------------------------------------------------
library IEEE;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_1164.ALL;
use work.ALL;

entity AddrB_FSM is
   Port(
			CLK : in STD_LOGIC;
			RST : in STD_LOGIC;
			Addr_Out : out STD_LOGIC_VECTOR(4 downto 0); 
			CLKB_Out : out STD_LOGIC;
			I_Out : out STD_LOGIC_VECTOR(2 downto 0);
			D_Out : out STD_LOGIC_VECTOR(1 downto 0)
	     );
end AddrB_FSM;

architecture Behavioral of AddrB_FSM is
         type StateType is (init,Delay, Add,Done);
		   signal STATE : StateType := init;
			signal Clock : STD_LOGIC;
begin
	Process(CLK,RST)
	variable instruction : STD_LOGIC_VECTOR(4 downto 0) := "00000";	-- incriments to 29 then stops (only every 20 clock cycles)
	variable counter : STD_LOGIC_VECTOR(4 downto 0) := "00000";   -- counts to 29 then stops
	variable I_Sel : STD_LOGIC_VECTOR(2 downto 0) := "000";	
	variable D_Sel : STD_LOGIC_VECTOR(1 downto 0) := "00";
		begin 
			if(RST = '1') then
			STATE <= init;
			elsif( CLK'event and CLK = '1') then
            case STATE is
				
				when init =>
				instruction := "00000";
				counter := "00000";
				I_Sel := "000";
				D_Sel := "00";
				State <= Delay;
				
				
				when Delay =>
					if(counter = "11110")then		-- counter=30
					counter := "00000";
					STATE <= Add;
					else
					if(counter = "00100" or counter = "01000" or counter = "01100" or counter = "10100") then			--if counter == 4
					if(I_Sel = "100") then				--Checks to see if I_select is 5
							I_Sel := "000";				--reset if so
						else
							I_Sel := std_logic_vector(to_unsigned(to_integer(unsigned( I_Sel )) + 1, 3));		--else add 1 to I_Sel
						end if;
					end if;
						
						if(D_Sel = x"04") then			--Checks to see if D_select is 
							D_Sel := "00";				--reset if so
						else
							D_Sel := std_logic_vector(to_unsigned(to_integer(unsigned( D_Sel )) + 1, 2));		--else add 1 to I_Sel
						end if;
					
					counter := std_logic_vector(to_unsigned(to_integer(unsigned( counter )) + 1, 5));		
					STATE <= Delay;
					end if;

				when Add => 
					if(instruction = "11110") then 
					STATE <= Done;
					else
					instruction := std_logic_vector(to_unsigned(to_integer(unsigned( instruction )) + 1, 5));
					STATE <= Delay;
					end if;

				when Done =>
					-- Do nothing
					
					State <= Done;
				
				When others =>
				State <= init;
				
				end case;
				Addr_Out <= instruction;
				Clock <= CLK;
				CLKB_Out <= Clock;
				I_Out <= I_Sel;
				D_Out <= D_Sel;
			end if;
	end process;

end Behavioral;

