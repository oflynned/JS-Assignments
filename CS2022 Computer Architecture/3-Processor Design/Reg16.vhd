library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Reg16 is
	Port(	D : in STD_LOGIC_VECTOR(15 downto 0);
			load0, load1, Clk : in STD_LOGIC;
			Q : out STD_LOGIC_VECTOR(15 downto 0)
		);
end Reg16;

architecture Behavioral of Reg16 is

begin 
	process (Clk)
		begin
			if(rising_edge(Clk)) then
				if((load0 =  '1') and (load1 = '1')) then
					Q <= D after 5ns;
				end if;
			end if;
	end process;

end Behavioral;