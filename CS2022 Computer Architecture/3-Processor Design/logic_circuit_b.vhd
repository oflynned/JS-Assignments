library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity logic_circuit_b is
	Port(
		B : in STD_LOGIC_VECTOR(15 downto 0);
		S_in : in STD_LOGIC_VECTOR(1 downto 0);
		Y_out : out STD_LOGIC_VECTOR(15 downto 0)
	);
end logic_circuit_b;

architecture Behavioral of logic_circuit_b is
	
	--mux 2-1 component
	Component Mux2to1
	Port(
		B_i, S0, S1 : in STD_LOGIC;
		Y_i : out STD_LOGIC
	);
	End Component;

begin
	mux00: Mux2to1 PORT MAP(
		B_i => B(0),
		S0 => S_in(0),
		S1 => S_in(1),
		Y_i => Y_out(0)
	);
	
	mux01: Mux2to1 PORT MAP(
		B_i => B(1),
		S0 => S_in(0),
		S1 => S_in(1),
		Y_i => Y_out(1)
	);
	
	mux02: Mux2to1 PORT MAP(
		B_i => B(2),
		S0 => S_in(0),
		S1 => S_in(1),
		Y_i => Y_out(2)
	);
	
	mux03: Mux2to1 PORT MAP(
		B_i => B(3),
		S0 => S_in(0),
		S1 => S_in(1),
		Y_i => Y_out(3)
	);
	
	mux04: Mux2to1 PORT MAP(
		B_i => B(4),
		S0 => S_in(0),
		S1 => S_in(1),
		Y_i => Y_out(4)
	);
	
	mux05: Mux2to1 PORT MAP(
		B_i => B(5),
		S0 => S_in(0),
		S1 => S_in(1),
		Y_i => Y_out(5)
	);
	
	mux06: Mux2to1 PORT MAP(
		B_i => B(6),
		S0 => S_in(0),
		S1 => S_in(1),
		Y_i => Y_out(6)
	);
	
	mux07: Mux2to1 PORT MAP(
		B_i => B(7),
		S0 => S_in(0),
		S1 => S_in(1),
		Y_i => Y_out(7)
	);
	
	mux08: Mux2to1 PORT MAP(
		B_i => B(8),
		S0 => S_in(0),
		S1 => S_in(1),
		Y_i => Y_out(8)
	);
	
	mux09: Mux2to1 PORT MAP(
		B_i => B(9),
		S0 => S_in(0),
		S1 => S_in(1),
		Y_i => Y_out(9)
	);
	
	mux10: Mux2to1 PORT MAP(
		B_i => B(10),
		S0 => S_in(0),
		S1 => S_in(1),
		Y_i => Y_out(10)
	);

end Behavioral;