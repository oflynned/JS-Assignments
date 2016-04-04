--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:18:50 02/09/2016
-- Design Name:   
-- Module Name:   C:/Users/Ed/CS2022/Proj1a/mux_2_16_test_bench.vhd
-- Project Name:  Proj1a
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: mux_2_16
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
 
ENTITY mux_2_16_test_bench IS
END mux_2_16_test_bench;
 
ARCHITECTURE behavior OF mux_2_16_test_bench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT mux_2_16
    PORT(
         in0 : IN  std_logic_vector(15 downto 0);
         in1 : IN  std_logic_vector(15 downto 0);
         s : IN  std_logic;
         z : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal in0 : std_logic_vector(15 downto 0) := (others => '0');
   signal in1 : std_logic_vector(15 downto 0) := (others => '0');
   signal s : std_logic := '0';

 	--Outputs
   signal z : std_logic_vector(15 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: mux_2_16 PORT MAP (
          in0 => in0,
          in1 => in1,
          s => s,
          z => z
        ); 

   -- Stimulus process
   stim_proc: process
   begin		
		wait for 10ns;
		in0 <= x"FFFF";
		in1 <= x"AAAA";
		
		wait for 10ns;
		s <= '1';
		
		wait for 10ns;
		s <= '0';
		
		wait for 10ns;
		s <= '1';
	
   end process;

END;
