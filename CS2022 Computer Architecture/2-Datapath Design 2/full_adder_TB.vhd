--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:03:37 03/08/2016
-- Design Name:   
-- Module Name:   C:/Users/Ed/CS2022/Proj1b/full_adder_TB.vhd
-- Project Name:  Proj1b
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: full_adder
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
 
ENTITY full_adder_TB IS
END full_adder_TB;
 
ARCHITECTURE behavior OF full_adder_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT full_adder
    PORT(
         X : IN  std_logic;
         Y : IN  std_logic;
         Cin : IN  std_logic;
         Cout : OUT  std_logic;
         S : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal X : std_logic := '0';
   signal Y : std_logic := '0';
   signal Cin : std_logic := '0';

 	--Outputs
   signal Cout : std_logic;
   signal S : std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: full_adder PORT MAP (
          X => X,
          Y => Y,
          Cin => Cin,
          Cout => Cout,
          S => S
        );

   -- Stimulus process
   stim_proc: process
   begin		
		wait for 5ns;
		X <= '1';
		
		wait for 5ns;
		X <= '0';
		Y <= '1';
		
		wait for 5ns;
		X <= '1';
		
		wait for 5ns;
		Cin <= '1';
		
		wait for 5ns;
		Y <= '0';
		
		wait for 5ns;
		X <= '0';

      wait;
   end process;

END;
