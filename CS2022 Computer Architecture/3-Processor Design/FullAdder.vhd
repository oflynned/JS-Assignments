library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FullAdder is
	Port(
			X, Y, Cin : in STD_LOGIC;
			Cout, S : out STD_LOGIC
		);
end FullAdder;

architecture Behavioral of FullAdder is
	signal S0, S1, S2 : STD_LOGIC;
begin
	S0 <= (X xor Y) after 1ns;
	S1 <= (Cin and S0) after 1ns;
	S2 <= (X and Y) after 1ns;
	S <= (S0 xor Cin) after 1ns;
	Cout <= (S1 or S2) after 1ns;

end Behavioral;