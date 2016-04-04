--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:49:08 03/08/2016
-- Design Name:   
-- Module Name:   C:/Users/Ed/CS2022/Proj1b/logic_circuit_a_b_TB.vhd
-- Project Name:  Proj1b
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: logic_circuit_a_b
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
 
ENTITY logic_circuit_a_b_TB IS
END logic_circuit_a_b_TB;
 
ARCHITECTURE behavior OF logic_circuit_a_b_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT logic_circuit_a_b
    PORT(
         a_logic_in : IN  std_logic_vector(15 downto 0);
         b_logic_in : IN  std_logic_vector(15 downto 0);
         select_in : IN  std_logic_vector(1 downto 0);
         logic_output_a_b : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal a_logic_in : std_logic_vector(15 downto 0) := (others => '0');
   signal b_logic_in : std_logic_vector(15 downto 0) := (others => '0');
   signal select_in : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal logic_output_a_b : std_logic_vector(15 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: logic_circuit_a_b PORT MAP (
          a_logic_in => a_logic_in,
          b_logic_in => b_logic_in,
          select_in => select_in,
          logic_output_a_b => logic_output_a_b
        ); 

   -- Stimulus process
   stim_proc: process
   begin		
		wait for 5ns;
		a_login_in <= x"FFFF";
		b_logic_in <= x"9999";
		select_in <= "00";
		
		wait for 5ns;
		select_in <= "01";
		
		wait for 5ns;
		select_in <= "10";
		
		wait for 5ns;
		select_in <= "11";

      wait;
   end process;

END;
