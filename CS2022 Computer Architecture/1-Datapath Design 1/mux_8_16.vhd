----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:29:37 02/06/2016 
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
			s0, s1, s2 : in STD_LOGIC;
			in0, in1, in2, in3, in4, in5, in6, in7 : in STD_LOGIC_VECTOR(15 downto 0);
			z : out STD_LOGIC_VECTOR(15 downto 0)
		);
end mux_8_16;

architecture Behavioral of mux_8_16 is

begin
	z <= 	in0 after 5ns when s0 = '0' and s1 = '0' and s2 = '0' else	--000
			in1 after 5ns when s0 = '0' and s1 = '0' and s2 = '1' else	--001
			in2 after 5ns when s0 = '0' and s1 = '1' and s2 = '0' else	--010
			in3 after 5ns when s0 = '0' and s1 = '1' and s2 = '1' else	--011
			in4 after 5ns when s0 = '1' and s1 = '0' and s2 = '0' else	--100
			in5 after 5ns when s0 = '1' and s1 = '0' and s2 = '1' else	--101
			in6 after 5ns when s0 = '1' and s1 = '1' and s2 = '0' else	--110
			in7 after 5ns when s0 = '1' and s1 = '1' and s2 = '1' else	--111
			x"0000" after 5ns;

end Behavioral;

