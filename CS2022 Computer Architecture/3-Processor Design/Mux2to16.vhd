library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux2to16 is
	Port(	In0, In1 : in STD_LOGIC_VECTOR(15 downto 0);
			s : in STD_LOGIC;
			Z : out STD_LOGIC_VECTOR(15 downto 0)
		);
end Mux2to16;

architecture Behavioral of Mux2to16 is

begin
	Z <= 	In0 after 1ns when s='0' else
			In1 after 1ns when s='1' else
			x"0000" after 1ns;

end Behavioral;