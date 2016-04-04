----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:08:15 03/03/2016 
-- Design Name: 
-- Module Name:    logic_circuit_a_b - Behavioral 
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

entity logic_circuit_a_b is
	Port(
		a_logic_in, b_logic_in : in STD_LOGIC_VECTOR(15 downto 0);
		select_in : in STD_LOGIC_VECTOR(1 downto 0);
		logic_output_a_b : out STD_LOGIC_VECTOR(15 downto 0)
	);
end logic_circuit_a_b;

architecture Behavioral of logic_circuit_a_b is

begin
	logic_output_a_b <= 	(a_logic_in and b_logic_in) after 1ns when select_in = "00" else
								(a_logic_in or b_logic_in) after 1ns when select_in = "01" else
								(a_logic_in xor b_logic_in) after 1ns when select_in = "10" else
								(not (a_logic_in)) after 1ns;

end Behavioral;

