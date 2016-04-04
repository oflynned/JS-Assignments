----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:52:04 03/01/2016 
-- Design Name: 
-- Module Name:    mux_8_16 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux_8_16 is
	Port(
		In0, In1, In2, In3, In4, In5, In6, In7 : in STD_LOGIC_VECTOR(15 downto 0);
		S0, S1, S2 : in STD_LOGIC;
		Z : out STD_LOGIC_VECTOR(15 downto 0)
		);
end mux_8_16;

architecture Behavioral of mux_8_16 is

begin
	Z <=	In0 after 1ns when S0='0' and S1='0' and S2='1' else
			In1 after 1ns when S0='1' and S1='0' and S2='0' else
			In2 after 1ns when S0='0' and S1='1' and S2='0' else
			In3 after 1ns when S0='1' and S1='1' and S2='0' else
			In4 after 1ns when S0='0' and S1='0' and S2='1' else
			In5 after 1ns when S0='1' and S1='0' and S2='1' else
			In6 after 1ns when S0='0' and S1='1' and S2='1' else
			In7 after 1ns when S0='1' and S1='1' and S2='1' else
			x"0000" after 1ns;
			
end Behavioral;

