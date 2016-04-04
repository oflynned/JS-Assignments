library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MicroprogrammeController is
	Port(	IR : in STD_LOGIC_VECTOR(15 downto 0);
			status_bits : in STD_LOGIC_VECTOR(3 downto 0);
			reset_mpc : in STD_LOGIC;
			control_word_mpc : out STD_LOGIC_VECTOR(17 downto 0);
			PC_out : out STD_LOGIC_VECTOR(15 downto 0);
			TD_mpc, TA_mpc, TB_mpc, MW_mpc : out STD_LOGIC
			);
end MicroprogrammeController;

architecture Behavioral of MicroprogrammeController is
	component ControlMemory
		Port(	in_car : in STD_LOGIC_VECTOR(7 downto 0);
				MW, MM, RW, MD, MB, TB, TA, TD, PL, PI, IL, MC : out STD_LOGIC;
				FS_cm : out STD_LOGIC_VECTOR(4 downto 0);
				MS_cm : out STD_LOGIC_VECTOR(2 downto 0);
				NA : out STD_LOGIC_VECTOR(7 downto 0)
				);
	end component;
	
	component Mux2to8
		Port(	In0_NA, In1_opcode : in STD_LOGIC_VECTOR(7 downto 0);
				S_mc : in STD_LOGIC;
				out_car : out STD_LOGIC_VECTOR(7 downto 0)
				);
	end component;
	
	component Mux8to1
		Port(	In_zero, In_one, In_n, In_z, In_c, In_v, In_not_c, In_not_z : in STD_LOGIC;
				S_ms : in STD_LOGIC_VECTOR(2 downto 0);
				out_s_car : out STD_LOGIC
				);
	end component;
	
	component ControlAddressRegister
		Port(	car_in : in STD_LOGIC_VECTOR(7 downto 0);
				s_car, reset : in STD_LOGIC;
				car_out : out STD_LOGIC_VECTOR(7 downto 0)
				);
	end component;
	
	component Instructions
		Port(	IR_in : in STD_LOGIC_VECTOR(15 downto 0);
				IL_in : in STD_LOGIC;
				Opcode :  out STD_LOGIC_VECTOR(6 downto 0);
				DR_out, SA_out, SB_out : out STD_LOGIC_VECTOR(2 downto 0)
				);
	end component;
	
	component ProgrammeCounter
		Port(	PC_module_in : in STD_LOGIC_VECTOR(15 downto 0);
				PL_module_in, PI_module_in, reset : in STD_LOGIC;
				PC_module_out : out STD_LOGIC_VECTOR(15 downto 0)
				);
	end component;
	
	component ExtendedProgrammeCounter
		Port(	SR_SB : in STD_LOGIC_VECTOR(5 downto 0);
				ExtendedProgrammeCounter : out STD_LOGIC_VECTOR(15 downto 0)
				);
	end component;
	
	--signalling
	signal control_word_sig : STD_LOGIC_VECTOR(17 downto 0);
	signal opcode_sig, car_out_sig, out_car_sig, na_sig : STD_LOGIC_VECTOR(7 downto 0);
	signal out_s_car_sig, mc_sig, il_sig, pl_sig, pi_sig : STD_LOGIC;
	signal ms_cm_sig, sa_sig, sb_sig, dr_sig : STD_LOGIC_VECTOR(2 downto 0);
	signal extend_in : STD_LOGIC_VECTOR(5 downto 0);
	signal extend_out : STD_LOGIC_VECTOR(15 downto 0);
	
begin
	control_mem_mpc : ControlMemory PORT MAP(
		in_car => car_out_sig,
		MW => mw_mpc,
		MM => control_word_sig(0),
		RW => control_word_sig(1),
		MD => control_word_sig(2),
		MB => control_word_sig(8),
		TB => tb_mpc,
		TA => ta_mpc,
		TD => td_mpc,
		PL => pl_sig,
		PI => pi_sig,
		IL => il_sig,
		MC => mc_sig,
		FS_cm => control_word_sig(7 downto 3),
		MS_cm => ms_cm_sig,
		NA => na_sig
	);
	
	mux2to8_mpc : mux2to8 PORT MAP(
		In0_NA => na_sig,
		In1_opcode => opcode_sig,
		S_mc => mc_sig,
		out_car => out_car_sig
	);
	
	mux8to1_mpc : Mux8to1 PORT MAP(
		In_zero => '0',
		In_one => '1',
		In_z => status_bits(0),
		In_n => status_bits(1),
		In_c => status_bits(2),
		In_v => status_bits(3),
		In_not_z => not status_bits(0),
		In_not_c => not status_bits(2),
		S_ms => ms_cm_sig,
		out_s_car => out_s_car_sig
	);
	
	car_mpc : ControlAddressRegister PORT MAP(
		car_in => out_car_sig,
		s_car => out_s_car_sig,
		reset => reset_mpc,
		car_out => car_out_sig
	);
	
	instructions_mpc : Instructions PORT MAP(
		IR_in => IR,
		IL_in => il_sig,
		Opcode => opcode_sig(6 downto 0),
		DR_out => dr_sig,
		SA_out => sa_sig,
		SB_out => sb_sig
	);
	
	extended_mpc : ExtendedProgrammeCounter PORT MAP(
		SR_SB => extend_in,
		ExtendedProgrammeCounter => extend_out
	);
	
	pc_mpc : ProgrammeCounter PORT MAP(
		PC_module_in => extend_out,
		PL_module_in => pl_sig,
		PI_module_in => pi_sig,
		reset => reset_mpc,
		PC_module_out => pc_out
	);
	
	extend_in(5 downto 3) <= dr_sig;
	extend_in(2 downto 0) <= sb_sig;
	opcode_sig(7) <= '0';
	
	control_word_sig(17 downto 15) <= dr_sig;
	control_word_sig(14 downto 12) <= sa_sig;
	control_word_sig(11 downto 9) <= sb_sig;
	control_word_mpc <= control_word_sig;

end Behavioral;

