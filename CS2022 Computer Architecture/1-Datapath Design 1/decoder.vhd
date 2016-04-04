----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:29:26 02/06/2016 
-- Design Name: 
-- Module Name:    decoder - Behavioral 
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

entity decoder is
	Port(
			a0, a1, a2 : in STD_LOGIC;
			q0, q1, q2, q3, q4, q5, q6, q7 : out STD_LOGIC
		);
end decoder;

architecture Behavioral of decoder is

begin
	q0 <= ((not a0) and (not a1) and (not a2)) after 5ns; --000
	q1 <= ((not a0) and (not a1) and (a2)) after 5ns;		--001
	q2 <= ((not a0) and (a1) and (not a2)) after 5ns;		--010
	q3 <= ((not a0) and (a1) and (a2)) after 5ns;			--011
	q4 <= ((a0) and (not a1) and (not a2)) after 5ns;		--100
	q5 <= ((a0) and (not a1) and (a2)) after 5ns;			--101
	q6 <= ((a0) and (a1) and (not a2)) after 5ns;			--110
	q7 <= ((a0) and (a1) and (a2)) after 5ns;					--111

end Behavioral;

