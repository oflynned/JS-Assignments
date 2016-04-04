----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:50:32 03/01/2016 
-- Design Name: 
-- Module Name:    reg - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity reg is
	Port(
			des_D, add_a, add_b : in STD_LOGIC_VECTOR(2 downto 0);
			Clk, load_in : in STD_LOGIC;
			data : in STD_LOGIC_VECTOR(15 downto 0);
			out_data_a, out_data_b : out STD_LOGIC_VECTOR(15 downto 0)
		);
end reg;

architecture Behavioral of reg is

	--reg16
	Component reg16
		Port(
			D : in STD_LOGIC_VECTOR(15 downto 0); 
			load0, load1, Clk : in STD_LOGIC;
			Q : out STD_LOGIC_VECTOR(15 downto 0)
		);
	end Component;
	--decoder 3-8
	Component decoder_3_8
		Port(
			A0, A1, A2 : in STD_LOGIC;
			Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7 : out STD_LOGIC
		);
	End Component;
	--mux 2-1
	Component mux_2_16
		Port(
			In0, In1 : STD_LOGIC_VECTOR(15 downto 0);
			s : STD_LOGIC;
			Z : out STD_LOGIC_VECTOR(15 downto 0)
		);
	End Component;
	--mux 8-16
	Component mux_8_16
		Port(
			In0, In1, In2, In3, In4, In5, In6, In7 : in STD_LOGIC_VECTOR(15 downto 0);
			S0, S1, S2 : in STD_LOGIC;
			Z : out STD_LOGIC_VECTOR(15 downto 0)
		);
	End Component;
	
	--internal signals
	signal load_reg0, load_reg1, load_reg2, load_reg3, load_reg4, load_reg5, load_reg6, load_reg7 : STD_LOGIC;
	signal reg0_q, reg1_q, reg2_q, reg3_q, reg4_q, reg5_q, reg6_q, reg7_q, data_src_mux_out, src_reg, out_sig_a, out_sig_b : STD_LOGIC_VECTOR(15 downto 0);

begin
	--reg0
	Reg00: reg16 PORT MAP(
			D => data,
			load0 => load_reg0,
			load1 => load_in,
			Clk => Clk,
			Q => reg0_q
		);
	--reg1
	Reg01: reg16 PORT MAP(
			D => data,
			load0 => load_reg1,
			load1 => load_in,
			Clk => Clk,
			Q => reg1_q
		);
	--reg2
	Reg02: reg16 PORT MAP(
			D => data,
			load0 => load_reg2,
			load1 => load_in,
			Clk => Clk,
			Q => reg2_q
		);
	--reg3
	Reg03: reg16 PORT MAP(
			D => data,
			load0 => load_reg3,
			load1 => load_in,
			Clk => Clk,
			Q => reg3_q
		);
	--reg4
	Reg04: reg16 PORT MAP(
			D => data,
			load0 => load_reg4,
			load1 => load_in,
			Clk => Clk,
			Q => reg4_q
		);
	--reg5
	Reg05: reg16 PORT MAP(
			D => data,
			load0 => load_reg5,
			load1 => load_in,
			Clk => Clk,
			Q => reg5_q
		);
	--reg6
	Reg06: reg16 PORT MAP(
			D => data,
			load0 => load_reg6,
			load1 => load_in,
			Clk => Clk,
			Q => reg6_q
		);
	--reg7
	Reg07: reg16 PORT MAP(
			D => data,
			load0 => load_reg7,
			load1 => load_in,
			Clk => Clk,
			Q => reg7_q
		);	
	--decoder for destination registers
	des_decoder_3_8: decoder_3_8 PORT MAP(
			A0 => des_D(0),
			A1 => des_D(1),
			A2 => des_D(2),
			Q0 => load_reg0,
			Q1 => load_reg1,
			Q2 => load_reg2,
			Q3 => load_reg3,
			Q4 => load_reg4,
			Q5 => load_reg5,
			Q6 => load_reg6,
			Q7 => load_reg7
		);
	--8 to 1 mux for A
	A_8_1_mux: mux_8_16 PORT MAP(
			In0 => reg0_q,
			In1 => reg1_q,
			In2 => reg2_q,
			In3 => reg3_q,
			In4 => reg4_q,
			In5 => reg5_q,
			In6 => reg6_q,
			In7 => reg7_q,
			S0 => add_a(0),
			S1 => add_a(1),
			S2 => add_a(2),
			Z => out_sig_a
		);
	--8 to 1 mux for B
	B_8_1_mux: mux_8_16 PORT MAP(
			In0 => reg0_q,
			In1 => reg1_q,
			In2 => reg2_q,
			In3 => reg3_q,
			In4 => reg4_q,
			In5 => reg5_q,
			In6 => reg6_q,
			In7 => reg7_q,
			S0 => add_b(0),
			S1 => add_b(1),
			S2 => add_b(2),
			Z => out_sig_b
		);
		
		out_data_a <= out_sig_a;
		out_data_b <= out_sig_b;

end Behavioral;

