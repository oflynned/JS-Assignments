library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux8to1 is
	Port(	In_zero, In_one, In_n, In_z, In_c, In_v, In_not_c, In_not_z : in STD_LOGIC;
			S_ms : in STD_LOGIC_VECTOR(2 downto 0);
			out_s_car : out STD_LOGIC
			);
end Mux8to1;

architecture Behavioral of Mux8to1 is

begin
	out_s_car <= 	In_zero after 1ns when S_ms = "000" else
						In_one after 1ns when S_ms = "001" else
						In_c after 1ns when S_ms = "010" else
						In_v after 1ns when S_ms = "011" else
						In_z after 1ns when S_ms = "100" else
						In_n after 1ns when S_ms = "101" else
						In_not_c after 1ns when S_ms = "110" else
						In_not_z after 1ns when S_ms = "111";

end Behavioral;

