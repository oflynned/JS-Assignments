library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RegFile is
	Port(	des_d, add_a, add_b : in STD_LOGIC_VECTOR(3 downto 0);
			Clk, load_in : in STD_LOGIC;
			data : in STD_LOGIC_VECTOR(15 downto 0);
			out_data_a, out_data_b : out STD_LOGIC_VECTOR(15 downto 0)
			);
end RegFile;

architecture Behavioral of RegFile is
	component Reg16
		Port(	D : in STD_LOGIC_VECTOR(15 downto 0);
				load0, load1, Clk : in STD_LOGIC;
				Q : out STD_LOGIC_VECTOR(15 downto 0)
				);
	end component;
	
	component Decoder4to9
		Port(	A0, A1, A2, A3 : in STD_LOGIC;
				Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8 : out STD_LOGIC
				);
	end component;
	
	component Mux2to16
		Port(	In0, In1 : in STD_LOGIC_VECTOR(15 downto 0);
				s : in STD_LOGIC;
				Z : out STD_LOGIC_VECTOR(15 downto 0)
				);
	end component;
	
	component Mux9to16
		Port(	In0, In1, In2, In3, In4, In5, In6, In7, In8 : in STD_LOGIC_VECTOR(15 downto 0);
				S0, S1, S2 : in STD_LOGIC;
				Z : out STD_LOGIC_VECTOR(15 downto 0)
				);
	end component;
	
	signal load_reg0, load_reg1, load_reg2, load_reg3, load_reg4, load_reg5, load_reg6, load_reg7, load_reg8 : STD_LOGIC;
	signal reg0_q, reg1_q, reg2_q, reg3_q, reg4_q, reg5_q, reg6_q, reg7_q, reg8_q, out_sig_a, out_sig_b : STD_LOGIC_VECTOR(15 downto 0);

begin
	--reg0
	reg0: Reg16 PORT MAP(
		D => data,
		load0 => load_reg0,
		load1 => load_in,
		Clk => Clk,
		Q => reg0_q
	);
	
	--reg1
	reg1: Reg16 PORT MAP(
		D => data,
		load0 => load_reg1,
		load1 => load_in,
		Clk => Clk,
		Q => reg1_q
	);
	
	--reg2
	reg2: Reg16 PORT MAP(
		D => data,
		load0 => load_reg2,
		load1 => load_in,
		Clk => Clk,
		Q => reg2_q
	);
	
	--reg3
	reg3: Reg16 PORT MAP(
		D => data,
		load0 => load_reg3,
		load1 => load_in,
		Clk => Clk,
		Q => reg3_q
	);
	
	--reg4
	reg4: Reg16 PORT MAP(
		D => data,
		load0 => load_reg4,
		load1 => load_in,
		Clk => Clk,
		Q => reg4_q
	);
	
	--reg5
	reg5: Reg16 PORT MAP(
		D => data,
		load0 => load_reg5,
		load1 => load_in,
		Clk => Clk,
		Q => reg5_q
	);
	
	--reg6
	reg6: Reg16 PORT MAP(
		D => data,
		load0 => load_reg6,
		load1 => load_in,
		Clk => Clk,
		Q => reg6_q
	);
	
	--reg7
	reg7: Reg16 PORT MAP(
		D => data,
		load0 => load_reg7,
		load1 => load_in,
		Clk => Clk,
		Q => reg7_q
	);
	
	--reg8
	reg8: Reg16 PORT MAP(
		D => data,
		load0 => load_reg8,
		load1 => load_in,
		Clk => Clk,
		Q => reg8_q
	);

	DesDecoder4to9 : Decoder4to9 PORT MAP(
		A0 => des_d(0),
		A1 => des_d(1),
		A2 => des_d(2),
		A3 => des_d(3),
		Q0 => load_reg0,
		Q1 => load_reg1,
		Q2 => load_reg2,
		Q3 => load_reg3,
		Q4 => load_reg4,
		Q5 => load_reg5,
		Q6 => load_reg6,
		Q7 => load_reg7,
		Q8 => load_reg8
	);
	
	Mux9to16A : Mux9to16 PORT MAP(
		In0 => reg0_q,
		In1 => reg1_q,
		In2 => reg2_q,
		In3 => reg3_q,
		In4 => reg4_q,
		In5 => reg5_q,
		In6 => reg6_q,
		In7 => reg7_q,
		In8 => reg8_q,
		S0 => add_b(0),
		S1 => add_b(1),
		S2 => add_b(2),
		Z => out_sig_a
	);
	
	Mux9to16B : Mux9to16 PORT MAP(
		In0 => reg0_q,
		In1 => reg1_q,
		In2 => reg2_q,
		In3 => reg3_q,
		In4 => reg4_q,
		In5 => reg5_q,
		In6 => reg6_q,
		In7 => reg7_q,
		In8 => reg8_q,
		S0 => add_b(0),
		S1 => add_b(1),
		S2 => add_b(2),
		Z => out_sig_b
	);
	
	out_data_a <= out_sig_a;
	out_data_b <= out_sig_b;

end Behavioral;

