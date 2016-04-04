LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY Proj2_TB IS
END Proj2_TB;
 
ARCHITECTURE behavior OF Proj2_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Proj2
    PORT(
         Clk : IN  std_logic;
         reset : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal reset : std_logic := '0';

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Proj2 PORT MAP (
          Clk => Clk,
          reset => reset
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		reset <= '1';
		wait for 40ns;
		
		reset <= '0';
      wait;
   end process;

END;
