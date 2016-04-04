library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ExtendedProgrammeCounter is
	Port(	SR_SB : in STD_LOGIC_VECTOR(5 downto 0);
			ExtendedProgrammeCounter : out STD_LOGIC_VECTOR(15 downto 0)
			);
end ExtendedProgrammeCounter;

architecture Behavioral of ExtendedProgrammeCounter is
	signal extended_signal : STD_LOGIC_VECTOR(15 downto 0);
begin
	extended_signal(5 downto 0) <= SR_SB;
	extended_signal(15 downto 6) <= "0000000000" when SR_SB(5) = '0' else "1111111111";
	ExtendedProgrammeCounter <= extended_signal;

end Behavioral;

