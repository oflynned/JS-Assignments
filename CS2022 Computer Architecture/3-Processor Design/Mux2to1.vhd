library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux2to1 is
	Port(
			B_i, S0, S1 : in STD_LOGIC;
			Y_i : out STD_LOGIC
		);
end Mux2to1;

architecture Behavioral of Mux2to1 is

begin
	Y_i <= 	S0 after 1ns when B_i = '1' else
				S1 after 1ns when B_i = '0' else
				'0' after 1ns;

end Behavioral;