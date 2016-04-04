library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ZeroFill is
	Port(	SB_in : in STD_LOGIC_VECTOR(2 downto 0);
			zero_fill_out : out STD_LOGIC_VECTOR(15 downto 0)
			);
end ZeroFill;

architecture Behavioral of ZeroFill is
	signal ZeroFill : STD_LOGIC_VECTOR(15 downto 0);
begin
	ZeroFill(2 downto 0) <= SB_in;
	ZeroFill(15 downto 3) <= "0000000000000";
end Behavioral;

