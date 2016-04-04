--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:45:04 03/08/2016
-- Design Name:   
-- Module Name:   C:/Users/Ed/CS2022/Proj1b/shifter_TB.vhd
-- Project Name:  Proj1b
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: shifter
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY shifter_TB IS
END shifter_TB;
 
ARCHITECTURE behavior OF shifter_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT shifter
    PORT(
         B : IN  std_logic_vector(15 downto 0);
         S : IN  std_logic_vector(1 downto 0);
         IL : IN  std_logic;
         IR : IN  std_logic;
         H : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal B : std_logic_vector(15 downto 0) := (others => '0');
   signal S : std_logic_vector(1 downto 0) := (others => '0');
   signal IL : std_logic := '0';
   signal IR : std_logic := '0';

 	--Outputs
   signal H : std_logic_vector(15 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: shifter PORT MAP (
          B => B,
          S => S,
          IL => IL,
          IR => IR,
          H => H
        ); 

   -- Stimulus process
   stim_proc: process
   begin		
      wait for 10ns;
		B <= x"FFFF";
		S <= "00";
		
		wait for 16ns;
		S <= "01";
		
		wait for 16ns;
		S <= H;
		
		wait for 16ns;
		
		B <= H;
		S <= "10";

      wait;
   end process;

END;
