library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux2to8 is
	Port(	In0_NA, In1_opcode : in STD_LOGIC_VECTOR(7 downto 0);
			S_mc : in STD_LOGIC;
			out_car : out STD_LOGIC_VECTOR(7 downto 0)
			);
end Mux2to8;

architecture Behavioral of Mux2to8 is

begin
	out_car <= 	In0_NA after 1ns when S_mc='0' else
					In1_opcode after 1ns when S_mc='1' else
					x"00" after 20ns;

end Behavioral;

