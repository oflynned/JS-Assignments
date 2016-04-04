LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY Mux2to8_TB IS
END Mux2to8_TB;
 
ARCHITECTURE behavior OF Mux2to8_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Mux2to8
    PORT(
         In0_NA : IN  std_logic_vector(7 downto 0);
         In1_opcode : IN  std_logic_vector(7 downto 0);
         S_mc : IN  std_logic;
         out_car : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal In0_NA : std_logic_vector(7 downto 0) := (others => '0');
   signal In1_opcode : std_logic_vector(7 downto 0) := (others => '0');
   signal S_mc : std_logic := '0';

 	--Outputs
   signal out_car : std_logic_vector(7 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Mux2to8 PORT MAP (
          In0_NA => In0_NA,
          In1_opcode => In1_opcode,
          S_mc => S_mc,
          out_car => out_car
        ); 

   -- Stimulus process
   stim_proc: process
   begin		
		In0_NA <= x"FF";
		In1_opcode <= x"AA";
		
		wait for 20ns;
		S_mc <= '1';
		
      wait;
   end process;

END;
