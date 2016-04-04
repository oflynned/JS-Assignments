--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:56:39 03/08/2016
-- Design Name:   
-- Module Name:   C:/Users/Ed/CS2022/Proj1b/mux_3_1_TB.vhd
-- Project Name:  Proj1b
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: mux_3_1
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
 
ENTITY mux_3_1_TB IS
END mux_3_1_TB;
 
ARCHITECTURE behavior OF mux_3_1_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT mux_3_1
    PORT(
         In0 : IN  std_logic;
         In1 : IN  std_logic;
         In2 : IN  std_logic;
         S0 : IN  std_logic;
         S1 : IN  std_logic;
         Z : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal In0 : std_logic := '0';
   signal In1 : std_logic := '0';
   signal In2 : std_logic := '0';
   signal S0 : std_logic := '0';
   signal S1 : std_logic := '0';

 	--Outputs
   signal Z : std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: mux_3_1 PORT MAP (
          In0 => In0,
          In1 => In1,
          In2 => In2,
          S0 => S0,
          S1 => S1,
          Z => Z
        );

   -- Stimulus process
   stim_proc: process
   begin	
		wait for 10ns;	
		In0 <= '1';
		In1 <= '0';
		In2 <= '1';
		
		wait for 5ns;
		S0 <= '0';
		S1 <= '1';
		
		wait for 5ns;
		S0 <= '1';
		S1 <= '0';
		
		wait for 5ns;
		S0 <= '1';
		S1 <= '1';

      wait;
   end process;

END;
