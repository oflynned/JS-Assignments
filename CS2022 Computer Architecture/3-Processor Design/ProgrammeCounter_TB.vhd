LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY ProgrammeCounter_TB IS
END ProgrammeCounter_TB;
 
ARCHITECTURE behavior OF ProgrammeCounter_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ProgrammeCounter
    PORT(
         PC_module_in : IN  std_logic_vector(15 downto 0);
         PL_module_in : IN  std_logic;
         PI_module_in : IN  std_logic;
         reset : IN  std_logic;
         PC_module_out : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal PC_module_in : std_logic_vector(15 downto 0) := (others => '0');
   signal PL_module_in : std_logic := '0';
   signal PI_module_in : std_logic := '0';
   signal reset : std_logic := '0';

 	--Outputs
   signal PC_module_out : std_logic_vector(15 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ProgrammeCounter PORT MAP (
          PC_module_in => PC_module_in,
          PL_module_in => PL_module_in,
          PI_module_in => PI_module_in,
          reset => reset,
          PC_module_out => PC_module_out
        );

   -- Stimulus process
   stim_proc: process
   begin		
		wait for 5ns;
		reset <= '1';
		PC_module_in <= x"0000";
		
		wait for 5ns;
		reset <= '0';
		
		wait for 5ns;
		PI_module_in <= '1';
		PC_module_in <= x"0002";
		
		wait for 20ns;
		PI_module_in <= '0';
		PL_module_in <= '1';
		PC_module_in <= x"000F";

      wait;
   end process;

END;
