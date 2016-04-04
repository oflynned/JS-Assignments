library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux9to16 is
	Port(	In0, In1, In2, In3, In4, In5, In6, In7, In8 : in STD_LOGIC_VECTOR(15 downto 0);
			S0, S1, S2, S3 : in STD_LOGIC;
			Z : out STD_LOGIC_VECTOR(15 downto 0)
			);
end Mux9to16;

architecture Behavioral of Mux9to16 is

begin
	Z <= 	In0 after 5ns when S0='0' and S1='0' and S2='0' and S3='0' else
			In1 after 5ns when S0='1' and S1='0' and S2='0' and S3='0' else
			In2 after 5ns when S0='0' and S1='1' and S2='0' and S3='0' else
			In3 after 5ns when S0='1' and S1='1' and S2='0' and S3='0' else
			In4 after 5ns when S0='0' and S1='0' and S2='1' and S3='0' else
			In5 after 5ns when S0='1' and S1='0' and S2='1' and S3='0' else
			In6 after 5ns when S0='0' and S1='1' and S2='1' and S3='0' else
			In7 after 5ns when S0='1' and S1='1' and S2='1' and S3='0' else
			In8 after 5ns when S0='0' and S1='0' and S2='0' and S3='1' else
			x"0000" after 5ns;
end Behavioral;

