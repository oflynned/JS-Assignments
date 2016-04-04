----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:51:53 03/01/2016 
-- Design Name: 
-- Module Name:    decoder_3_8 - Behavioral 
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

entity decoder_3_8 is
	Port(
		A0, A1, A2 : in STD_LOGIC;
		Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7 : out STD_LOGIC
		);
end decoder_3_8;

architecture Behavioral of decoder_3_8 is
begin
		Q0 <= ((not A0) and (not A1) and (not A2)) after 1ns; --000
		Q1 <= ((A0) and (not A1) and (not A2)) after 1ns; --001
		Q2 <= ((not A0) and (A1) and (not A2)) after 1ns; --010
		Q3 <= ((A0) and (A1) and (not A2)) after 1ns; --011
		Q4 <= ((not A0) and (not A1) and (A2)) after 1ns; --100
		Q5 <= ((A0) and (not A1) and (A2)) after 1ns; --101
		Q6 <= ((not A0) and (A1) and (A2)) after 1ns; --110
		Q7 <= ((A0) and (A1) and (A2)) after 1ns; --111
end Behavioral;

