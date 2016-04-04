library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ProgrammeCounter is
	Port(	PC_module_in : in STD_LOGIC_VECTOR(15 downto 0);
			PL_module_in, PI_module_in, reset : in STD_LOGIC;
			PC_module_out : out STD_LOGIC_VECTOR(15 downto 0)
			);
end ProgrammeCounter;

architecture Behavioral of ProgrammeCounter is
begin
	process(reset, PL_module_in, PI_module_in)
	variable current_PC : STD_LOGIC_VECTOR(15 downto 0);
	variable temp_curr_PC : integer;
	variable temp_inc_PC : STD_LOGIC_VECTOR(15 downto 0);
	
	begin
		if(reset = '1') then current_PC := x"0000";
		elsif(PL_module_in = '1') then 
			current_PC := current_PC + PC_module_in;
		elsif(PI_module_in = '1') then
			temp_curr_PC := conv_integer(current_PC); -- get current allocation
			temp_curr_PC := temp_curr_PC + conv_integer(1); -- increment
			temp_inc_PC := conv_std_logic_vector(temp_curr_PC, 16); -- cast from int to vector
			current_PC := temp_inc_PC; -- store as current PC
		end if;
		PC_module_out <= current_PC after 2ns;
	end process;

end Behavioral;

