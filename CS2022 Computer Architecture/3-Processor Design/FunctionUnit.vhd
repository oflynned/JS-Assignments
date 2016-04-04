library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FunctionUnit is
	Port(
		FunctionSelect : in STD_LOGIC_VECTOR(4 downto 0); -- 5 input
		a_in, b_in : in STD_LOGIC_VECTOR(15 downto 0);
		N_fu, Z_fu, V_fu, C_fu : out STD_LOGIC;
		F : out STD_LOGIC_VECTOR(15 downto 0)
	);
end FunctionUnit;

architecture Behavioral of FunctionUnit is

	--2 to 1 mux
	Component Mux2to16
		Port(
			In0, In1 : in STD_LOGIC_VECTOR(15 downto 0);
			s : in STD_LOGIC;
			Z : out STD_LOGIC_VECTOR(15 downto 0)
		);
	End Component;
	--shifter
	Component shifter
		Port(
			B : in STD_LOGIC_VECTOR(15 downto 0);
			S : in STD_LOGIC_VECTOR(1 downto 0);
			IL, IR : in STD_LOGIC;
			H : out STD_LOGIC_VECTOR(15 downto 0)
		);
	End Component;
	--alu
	Component alu_unit
		Port(
			a_in, b_in : in STD_LOGIC_VECTOR(15 downto 0);
			G_select : in STD_LOGIC_VECTOR(3 downto 0);
			V, C : out STD_LOGIC; -- flags
			G : out STD_LOGIC_VECTOR(15 downto 0)
		);
	End Component;
	
	signal H_out, ALU_out, mux_out : STD_LOGIC_VECTOR(15 downto 0);

begin
	shifter00: shifter PORT MAP(
		B => b_in,
		S => FunctionSelect(3 downto 2),
		IL => '0',
		IR => '0',
		H => H_out
	);
	
	mux_2_1600: Mux2to16 PORT MAP(
		In0 => ALU_out,
		In1 => H_out,
		s => FunctionSelect(4),
		z => mux_out
	);
	
	alu: alu_unit PORT MAP(
		a_in => a_in,
		b_in => b_in,
		G_select => FunctionSelect(3 downto 0),
		V => V_fu,
		C => C_fu,
		G => ALU_out
	);
	
	F <= mux_out;
	N_fu <= mux_out(15);
	Z_fu <= (mux_out(15) or mux_out(14) or mux_out(13) or mux_out(12) or mux_out(11) 
				or mux_out(10) or mux_out(9) or mux_out(8) or mux_out(7) or mux_out(6) 
				or mux_out(5) or mux_out(4) or mux_out(3) or mux_out(2) or mux_out(1) or mux_out(0));

end Behavioral;