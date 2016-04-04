--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:54:11 03/06/2016
-- Design Name:   
-- Module Name:   C:/Users/Ed/CS2022/Proj1b/FuncUnit_TB.vhd
-- Project Name:  Proj1b
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: function_unit
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
 
ENTITY FuncUnit_TB IS
END FuncUnit_TB;
 
ARCHITECTURE behavior OF FuncUnit_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT function_unit
    PORT(
         FunctionSelect : IN  std_logic_vector(4 downto 0);
         a_in : IN  std_logic_vector(15 downto 0);
         b_in : IN  std_logic_vector(15 downto 0);
         N_fu : OUT  std_logic;
         Z_fu : OUT  std_logic;
         V_fu : OUT  std_logic;
         C_fu : OUT  std_logic;
         F : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal FunctionSelect : std_logic_vector(4 downto 0) := (others => '0');
   signal a_in : std_logic_vector(15 downto 0) := (others => '0');
   signal b_in : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal N_fu : std_logic;
   signal Z_fu : std_logic;
   signal V_fu : std_logic;
   signal C_fu : std_logic;
   signal F : std_logic_vector(15 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: function_unit PORT MAP (
          FunctionSelect => FunctionSelect,
          a_in => a_in,
          b_in => b_in,
          N_fu => N_fu,
          Z_fu => Z_fu,
          V_fu => V_fu,
          C_fu => C_fu,
          F => F
        ); 

   -- Stimulus process
   stim_proc: process
   begin		
		a_in <= x"AAAA";
		b_in <= x"BBBB";
		
		wait for 20ns;
		FunctionSelect <= "00000";
		
		wait for 10ns;
		FunctionSelect <= "00001";
		
		wait for 10ns;
		FunctionSelect <= "00010";
		
		wait for 10ns;
		FunctionSelect <= "00011";
		
		wait for 10ns;
		FunctionSelect <= "00100";
		
		wait for 10ns;
		FunctionSelect <= "00101";
		
		wait for 10ns;
		FunctionSelect <= "00110";
		
		wait for 10ns;
		FunctionSelect <= "00111";
		
		wait for 10ns;
		FunctionSelect <= "01000";
		
		wait for 10ns;
		FunctionSelect <= "01010";
		
		wait for 10ns;
		FunctionSelect <= "01100";
		
		wait for 10ns;
		FunctionSelect <= "01110";
		
		wait for 10ns;
		FunctionSelect <= "10000";
		
		wait for 10ns;
		FunctionSelect <= "10100";
		
		wait for 10ns;
		FunctionSelect <= "11000";
		
		wait;
   end process;

END;
