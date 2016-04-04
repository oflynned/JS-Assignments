library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Datapath is
	Port(	data_in, pc_in : in STD_LOGIC_VECTOR(15 downto 0);
			control_word : in STD_LOGIC_VECTOR(17 downto 0);
			clk_sig, TD, TA, TB : in STD_LOGIC;
			data_out, addr_out : out STD_LOGIC_VECTOR(15 downto 0);
			status_out : out STD_LOGIC_VECTOR(3 downto 0)
			);
end Datapath;

architecture Behavioral of Datapath is

	component RegFile
		Port(	des_d, add_a, add_b : in STD_LOGIC_VECTOR(3 downto 0);
				Clk, load_in : in STD_LOGIC;
				data : in STD_LOGIC_VECTOR(15 downto 0);
				out_data_a, out_data_b : out STD_LOGIC_VECTOR(15 downto 0)
				);
	end component;
	
	component Mux2to16
		Port(	In0, In1 : in STD_LOGIC_VECTOR(15 downto 0);
				s : in STD_LOGIC;
				Z : out STD_LOGIC_VECTOR(15 downto 0)
				);
	end component;
	
	component ZeroFill
		Port(	SB_in : in STD_LOGIC_VECTOR(2 downto 0);
				zero_fill_out : out STD_LOGIC_VECTOR(15 downto 0)
				);
	end component;
	
	component FunctionUnit
		Port(	FunctionSelect : in STD_LOGIC_VECTOR(4 downto 0);
				a_in, b_in : in STD_LOGIC_VECTOR(15 downto 0);
				N_fu, Z_fu, V_fu, C_fu : out STD_LOGIC;
				F : out STD_LOGIC_VECTOR(15 downto 0)
				);
	end component;
	
	signal mux_b_out, mux_d_out, mux_m_out, reg_file_out_a, reg_file_out_b, func_unit_out, zero_fill_out, pc_sig : STD_LOGIC_VECTOR(15 downto 0);
	signal dest_d, addr_a, addr_b, status_bits : STD_LOGIC_VECTOR(3 downto 0);

begin
	
	mux_b : Mux2to16 PORT MAP(
		In0 => reg_file_out_b,
		In1 => zero_fill_out,
		s => control_word(8),
		Z => mux_b_out
	);
	
	mux_d : Mux2to16 PORT MAP(
		In0 => func_unit_out,
		In1 => data_in,
		s => control_word(2),
		Z => mux_d_out
	);
	
	pc_sig <= pc_in;
	
	mux_m : Mux2to16 PORT MAP(
		In0 => reg_file_out_a,
		In1 => pc_sig,
		s => control_word(0),
		Z => mux_m_out
	);
	
	dest_d <= TD & control_word(17 downto 15);
	addr_a <= TA & control_word(14 downto 12);
	addr_b <= TB & control_word(11 downto 9);
	
	zero_fill : ZeroFill PORT MAP(
		SB_in => control_word(11 downto 9),
		zero_fill_out => zero_fill_out
	);
	
	reg_file : RegFile PORT MAP(
		des_d => dest_d,
		add_a => addr_a,
		add_b => addr_b,
		Clk => clk_sig,
		load_in => control_word(1),
		data => mux_d_out,
		out_data_a => reg_file_out_a,
		out_data_b => reg_file_out_b
	);
	
	data_out <= mux_b_out;
	addr_out <= mux_m_out;
	
	func_unit : FunctionUnit PORT MAP(
		FunctionSelect => control_word(7 downto 3),
		a_in => reg_file_out_a,
		b_in => mux_b_out,
		N_fu => status_bits(1),
		Z_fu => status_bits(0),
		V_fu => status_bits(3),
		C_fu => status_bits(2),
		F => func_unit_out
	);
	
	status_out <= status_bits;

end Behavioral;

