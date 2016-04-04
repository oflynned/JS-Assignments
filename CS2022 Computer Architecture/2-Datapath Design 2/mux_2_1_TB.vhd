--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:53:24 03/08/2016
-- Design Name:   
-- Module Name:   C:/Users/Ed/CS2022/Proj1b/mux_2_1_TB.vhd
-- Project Name:  Proj1b
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: mux_2_1
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
 
ENTITY mux_2_1_TB IS
END mux_2_1_TB;
 
ARCHITECTURE behavior OF mux_2_1_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT mux_2_1
    PORT(
         B_i : IN  std_logic;
         S0 : IN  std_logic;
         S1 : IN  std_logic;
         Y_i : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal B_i : std_logic := '0';
   signal S0 : std_logic := '0';
   signal S1 : std_logic := '0';

 	--Outputs
   signal Y_i : std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: mux_2_1 PORT MAP (
          B_i => B_i,
          S0 => S0,
          S1 => S1,
          Y_i => Y_i
        );

   -- Stimulus process
   stim_proc: process
   begin		
		S0 <= '1';
		S1 <= '0';
		
		wait for 5ns;
		B_i <= '1';
		
		wait for 5ns;
		B_i <= '0';

      wait;
   end process;

END;
