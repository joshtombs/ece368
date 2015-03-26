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
    Port( OPA_REG   : in  STD_LOGIC_VECTOR(3 downto 0);
          E_FWD_REG : in  STD_LOGIC_VECTOR(3 downto 0);
          W_FWD_REG : in  STD_LOGIC_VECTOR(3 downto 0);
          E_STALL   : in  STD_LOGIC;
          W_STALL   : in  STD_LOGIC;
          CTRL_SEL  : in  STD_LOGIC_VECTOR(1 downto 0);
          MUX_SEL   : out STD_LOGIC_VECTOR(1 downto 0));
end fwd_detection_unit;

architecture Dataflow of fwd_detection_unit is
    signal first_sel : STD_LOGIC_VECTOR(1 downto 0);
begin

    first_sel <= "10" when ((CTRL_SEL = "00" AND OPA_REG = W_FWD_REG) AND W_STALL = '0') ELSE
                 "00";

     MUX_SEL <= "01" when CTRL_SEL = "01" ELSE
                "10" when first_sel = "10" AND OPA_REG /= E_FWD_REG ELSE
                "11" when OPA_REG = E_FWD_REG AND E_STALL = '0' ELSE
                "00";

end Dataflow;

