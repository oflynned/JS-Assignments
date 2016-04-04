library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Proj2 is
	Port(	Clk, reset : in STD_LOGIC
			);
end Proj2;

architecture Behavioral of Proj2 is
	
	component Datapath
		Port(	data_in, pc_in : in STD_LOGIC_VECTOR(15 downto 0);
				control_word : in STD_LOGIC_VECTOR(17 downto 0);
				clk_sig, TD, TA, TB : in STD_LOGIC;
				data_out, addr_out : out STD_LOGIC_VECTOR(15 downto 0);
				status_out : out STD_LOGIC_VECTOR(3 downto 0)
				);
	end component;
	
	component MicroprogrammeController
		Port(	IR : in STD_LOGIC_VECTOR(15 downto 0);
				status_bits : in STD_LOGIC_VECTOR(3 downto 0);
				reset_mpc : in STD_LOGIC;
				control_word_mpc : out STD_LOGIC_VECTOR(17 downto 0);
				PC_out : out STD_LOGIC_VECTOR(15 downto 0);
				TD_mpc, TA_mpc, TB_mpc, MW_mpc : out STD_LOGIC
				);
	end component;
	
	component Memory
		Port(	address_mem : in STD_LOGIC_VECTOR(15 downto 0);
				write_data : in STD_LOGIC_VECTOR(15 downto 0);
				mem_write : in STD_LOGIC;
				read_data : out STD_LOGIC_VECTOR(15 downto 0)
				);
	end component;
	
	signal mm_read_data, mpc_pc_out, dp_data_out, dp_address_out : STD_LOGIC_VECTOR(15 downto 0);
	signal mpc_control_word : STD_LOGIC_VECTOR(17 downto 0);
	signal dp_status_out : STD_LOGIC_VECTOR(3 downto 0);
	signal mpc_TD, mpc_TA, mpc_TB, mpc_MW : STD_LOGIC;

begin
	data_path : Datapath PORT MAP(
		data_in => mm_read_data,
		pc_in => mpc_pc_out,
		control_word => mpc_control_word,
		clk_sig => Clk,
		TD => mpc_TD,
		TA => mpc_TA,
		TB => mpc_TB,
		data_out => dp_data_out,
		addr_out => dp_address_out,
		status_out => dp_status_out
	);
	
	micro_pc : MicroprogrammeController PORT MAP(
		IR => mm_read_data,
		status_bits => dp_status_out,
		reset_mpc => reset,
		control_word_mpc => mpc_control_word,
		PC_out => mpc_pc_out,
		TD_mpc => mpc_TD,
		TA_mpc => mpc_TA,
		TB_mpc => mpc_TB,
		MW_mpc => mpc_MW
	);
	
	memory_module : Memory PORT MAP(
		address_mem => dp_address_out,
		write_data => dp_data_out,
		mem_write => mpc_MW,
		read_data => mm_read_data
	);

end Behavioral;

