---------------------------------------------------
-- School:     University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer:   Josh Tombs
-- 
-- Create Date:    SPRING 2015
-- Module Name:    FWD_DETECTION_UNIT
-- Project Name:   UMD_RISC16
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
-- Description:    Unit to determine whether or not
--     the forwarded value is to be used.
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fwd_detection_unit is
    Port( OPA_REG  : in  STD_LOGIC_VECTOR(3 downto 0);
          FWD_REG  : in  STD_LOGIC_VECTOR(3 downto 0);
          CTRL_SEL : in  STD_LOGIC_VECTOR(1 downto 0);
          MUX_SEL  : out STD_LOGIC_VECTOR(1 downto 0));
end fwd_detection_unit;

architecture Dataflow of fwd_detection_unit is
begin

    MUX_SEL <= "01" when CTRL_SEL = "01" ELSE
               "10" when CTRL_SEL = "10" ELSE
               "00" when CTRL_SEL = "00" AND OPA_REG /= FWD_REG ELSE
               "11" when CTRL_SEL = "00" AND OPA_REG = FWD_REG ELSE
               "00";

end Dataflow;

