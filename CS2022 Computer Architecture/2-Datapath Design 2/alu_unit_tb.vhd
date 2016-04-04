--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:41:29 03/08/2016
-- Design Name:   
-- Module Name:   C:/Users/Ed/CS2022/Proj1b/ALU_TB.vhd
-- Project Name:  Proj1b
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: alu_unit
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
 
ENTITY ALU_TB IS
END ALU_TB;
 
ARCHITECTURE behavior OF ALU_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT alu_unit
    PORT(
         a_in : IN  std_logic_vector(15 downto 0);
         b_in : IN  std_logic_vector(15 downto 0);
         G_select : IN  std_logic_vector(3 downto 0);
         V : OUT  std_logic;
         C : OUT  std_logic;
         G : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal a_in : std_logic_vector(15 downto 0) := (others => '0');
   signal b_in : std_logic_vector(15 downto 0) := (others => '0');
   signal G_select : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal V : std_logic;
   signal C : std_logic;
   signal G : std_logic_vector(15 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: alu_unit PORT MAP (
          a_in => a_in,
          b_in => b_in,
          G_select => G_select,
          V => V,
          C => C,
          G => G
        );

   -- Stimulus process
   stim_proc: process
   begin		
      a_in <= x"FFAA";
		b_in <= x"000F";
		G_select <= "0000";
		
		wait for 100ns;
		G_select <= "0001";
		
		wait for 100ns;
		G_select <= "0010";
		
		wait for 100ns;
		G_select <= "0010";
		
		wait for 100ns;
		G_select <= "0011";
		
		wait for 100ns;
		G_select <= "0100";
		
		wait for 100ns;
		G_select <= "0101";
		
		wait for 100ns;
		G_select <= "0110";
		
		wait for 100ns;
		G_select <= "0111";
      wait;
   end process;

END;
