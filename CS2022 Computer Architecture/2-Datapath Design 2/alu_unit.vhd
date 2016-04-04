----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:57:16 03/01/2016 
-- Design Name: 
-- Module Name:    alu_unit - Behavioral 
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

entity alu_unit is
	Port(
		a_in, b_in : in STD_LOGIC_VECTOR(15 downto 0);
		G_select : in STD_LOGIC_VECTOR(3 downto 0);
		V, C : out STD_LOGIC; -- flags
		G : out STD_LOGIC_VECTOR(15 downto 0)
	);

end alu_unit;

architecture Behavioral of alu_unit is

	--components in ALU
	--ripple adder
	Component ripple_adder
		Port(
			A, B : in STD_LOGIC_VECTOR(15 downto 0);
			Cin : in STD_LOGIC;
			Cout, V_out : out STD_LOGIC;
			G_out : out STD_LOGIC_VECTOR(15 downto 0)
		);
	End Component;
	--a b logic for and or xor not
	Component logic_circuit_a_b
		Port(
			a_logic_in, b_logic_in : in STD_LOGIC_VECTOR(15 downto 0);
			select_in : in STD_LOGIC_VECTOR(1 downto 0);
			logic_output_a_b : out STD_LOGIC_VECTOR(15 downto 0)
		);
	End Component;
	--b logic circuit
	Component logic_circuit_b
		Port(
			B : in STD_LOGIC_VECTOR(15 downto 0);
			S_in : in STD_LOGIC_VECTOR(1 downto 0);
			Y_out : out STD_LOGIC_VECTOR(15 downto 0)
		);
	End Component;
	--2-1 mux
	Component mux_2_16
		Port(
			In0, In1 : in STD_LOGIC_VECTOR(15 downto 0);
			s : in STD_LOGIC;
			Z : out STD_LOGIC_VECTOR(15 downto 0)
		);
	End Component;
	
	signal logic_out, logic_output_a_b, ripple_out : STD_LOGIC_VECTOR(15 downto 0);
	
begin
	--instantiation of components
	r_adder: ripple_adder PORT MAP(
			A => a_in,
			B => b_in,
			Cin => G_select(0),
			Cout => C,
			V_out => V,
			G_out => ripple_out
	);
	
	logic_circuit_a_b00: logic_circuit_a_b PORT MAP(
			a_logic_in => a_in,
			b_logic_in => b_in,
			select_in => G_select(2 downto 1),
			logic_output_a_b => logic_output_a_b
	);
	
	logic_circuit_b00 : logic_circuit_b PORT MAP(
			B => b_in,
			S_in => G_select(2 downto 1),
			Y_out => logic_out
	);
	
	mux_2_1600: mux_2_16 PORT MAP(
			In0 => ripple_out,
			In1 => logic_output_a_b,
			s => G_select(3),
			Z => G
	);

end Behavioral;

