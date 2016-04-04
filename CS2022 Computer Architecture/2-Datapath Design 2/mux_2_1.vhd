----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:17:36 03/01/2016 
-- Design Name: 
-- Module Name:    mux_2_1 - Behavioral 
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

entity mux_2_1 is
	Port(
			B_i, S0, S1 : in STD_LOGIC;
			Y_i : out STD_LOGIC
		);
end mux_2_1;

architecture Behavioral of mux_2_1 is

begin
	Y_i <= 	S0 after 1ns when B_i = '1' else
				S1 after 1ns when B_i = '0' else
				'0' after 1ns;

end Behavioral;

