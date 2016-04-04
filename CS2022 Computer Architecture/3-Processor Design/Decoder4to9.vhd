library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Decoder4to9 is
	Port(	A0, A1, A2, A3 : in STD_LOGIC;
			Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8 : out STD_LOGIC
			);
end Decoder4to9;

architecture Behavioral of Decoder4to9 is

begin
	Q0 <= ((not A0) and (not A1) and (not A2) and (not A3)) after 1ns; --0000
	Q1 <= ((A0) and (not A1) and (not A2) and (not A3)) after 1ns; --1000
	Q2 <= ((not A0) and (A1) and (not A2) and (not A3)) after 1ns; --0100
	Q3 <= ((A0) and (A1) and (not A2) and (not A3)) after 1ns; --1100
	Q4 <= ((not A0) and (not A1) and (A2) and (not A3)) after 1ns; --0010
	Q5 <= ((A0) and (not A1) and (A2) and (not A3)) after 1ns; --1010
	Q6 <= ((not A0) and (A1) and (A2) and (not A3)) after 1ns; --0110
	Q7 <= ((A0) and (A1) and (A2) and (not A3)) after 1ns; --1110
	Q8 <= ((not A0) and (not A1) and (not A2) and (A3)) after 1ns; --0001

end Behavioral;

