LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY ControlAddressRegister_TB IS
END ControlAddressRegister_TB;
 
ARCHITECTURE behavior OF ControlAddressRegister_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ControlAddressRegister
    PORT(
         car_in : IN  std_logic_vector(7 downto 0);
         s_car : IN  std_logic;
         reset : IN  std_logic;
         car_out : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal car_in : std_logic_vector(7 downto 0) := (others => '0');
   signal s_car : std_logic := '0';
   signal reset : std_logic := '0';

 	--Outputs
   signal car_out : std_logic_vector(7 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ControlAddressRegister PORT MAP (
          car_in => car_in,
          s_car => s_car,
          reset => reset,
          car_out => car_out
        );
		  
   -- Stimulus process
   stim_proc: process
   begin		
		wait for 5ns;
		reset <= '1';
		
		wait for 30ns;
		reset <= '0';
		
		wait for 30ns;
		car_in <= x"01";
		
		wait for 30ns;
		car_in <= x"A1";
		s_car <= '1';

      wait;
   end process;

END;
