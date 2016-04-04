LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY ZeroFill_TB IS
END ZeroFill_TB;
 
ARCHITECTURE behavior OF ZeroFill_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ZeroFill
    PORT(
         SB_in : IN  std_logic_vector(2 downto 0);
         zero_fill_out : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal SB_in : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal zero_fill_out : std_logic_vector(15 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ZeroFill PORT MAP (
          SB_in => SB_in,
          zero_fill_out => zero_fill_out
        );

   -- Stimulus process
   stim_proc: process
   begin	
		wait for 10ns;
		SB_in <= "110";
		wait;
   end process;

END;
