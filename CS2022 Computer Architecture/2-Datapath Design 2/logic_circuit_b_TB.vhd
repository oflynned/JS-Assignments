--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:51:36 03/08/2016
-- Design Name:   
-- Module Name:   C:/Users/Ed/CS2022/Proj1b/logic_circuit_b_TB.vhd
-- Project Name:  Proj1b
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: logic_circuit_b
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
 
ENTITY logic_circuit_b_TB IS
END logic_circuit_b_TB;
 
ARCHITECTURE behavior OF logic_circuit_b_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT logic_circuit_b
    PORT(
         B : IN  std_logic_vector(15 downto 0);
         S_in : IN  std_logic_vector(1 downto 0);
         Y_out : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal B : std_logic_vector(15 downto 0) := (others => '0');
   signal S_in : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal Y_out : std_logic_vector(15 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: logic_circuit_b PORT MAP (
          B => B,
          S_in => S_in,
          Y_out => Y_out
        );

   -- Stimulus process
   stim_proc: process
   begin		
		B <= x"AAAA";
		S_in <= "00";
		
		wait for 5ns;
		S_in <= "01";
		
		wait for 5ns;
		S_in <= "10";
		
		wait for 5ns;
		S_in <= "11";

      wait;
   end process;

END;
