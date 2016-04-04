LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY ExtendedProgrammeCounter_TB IS
END ExtendedProgrammeCounter_TB;
 
ARCHITECTURE behavior OF ExtendedProgrammeCounter_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ExtendedProgrammeCounter
    PORT(
         SR_SB : IN  std_logic_vector(5 downto 0);
         ExtendedProgrammeCounter : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal SR_SB : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal ExtendedProgrammeCounter : std_logic_vector(15 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ExtendedProgrammeCounter PORT MAP (
          SR_SB => SR_SB,
          ExtendedProgrammeCounter => ExtendedProgrammeCounter
        );

   -- Stimulus process
   stim_proc: process
   begin		
		wait for 10ns;
		SR_SB <= "010110";
		
		wait for 10ns;
		SR_SB <= "110110";
		
      wait;
   end process;

END;
