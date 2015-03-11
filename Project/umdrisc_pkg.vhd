---------------------------------------------------
-- School:     University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer:   Josh Tombs
-- 
-- Create Date:    SPRING 2015
-- Module Name:    UMDRISC_pkg
-- Project Name:   UMD_RISC16
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
-- Description:    Package containing UMD_RISC16
--     constants and components.
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;

package UMDRISC_PKG is
	CONSTANT DATA_WIDTH        : INTEGER := 16;
	CONSTANT NUMBER_REGISTERS  : INTEGER := 16;
	CONSTANT REG_ADDRESS_WIDTH : INTEGER := 4;
	CONSTANT INSTR_MEM_WIDTH   : INTEGER := 5;
	CONSTANT DATA_MEM_WIDTH    : INTEGER := 8;
end UMDRISC_PKG;

package body UMDRISC_PKG is

end UMDRISC_PKG