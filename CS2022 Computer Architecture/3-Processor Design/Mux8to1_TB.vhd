LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY Mux8to1_TB IS
END Mux8to1_TB;
 
ARCHITECTURE behavior OF Mux8to1_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Mux8to1
    PORT(
         In_zero : IN  std_logic;
         In_one : IN  std_logic;
         In_n : IN  std_logic;
         In_z : IN  std_logic;
         In_c : IN  std_logic;
         In_v : IN  std_logic;
         In_not_c : IN  std_logic;
         In_not_z : IN  std_logic;
         S_ms : IN  std_logic_vector(2 downto 0);
         out_s_car : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal In_zero : std_logic := '0';
   signal In_one : std_logic := '0';
   signal In_n : std_logic := '0';
   signal In_z : std_logic := '0';
   signal In_c : std_logic := '0';
   signal In_v : std_logic := '0';
   signal In_not_c : std_logic := '0';
   signal In_not_z : std_logic := '0';
   signal S_ms : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal out_s_car : std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Mux8to1 PORT MAP (
          In_zero => In_zero,
          In_one => In_one,
          In_n => In_n,
          In_z => In_z,
          In_c => In_c,
          In_v => In_v,
          In_not_c => In_not_c,
          In_not_z => In_not_z,
          S_ms => S_ms,
          out_s_car => out_s_car
        );

   -- Stimulus process
   stim_proc: process
   begin		
		wait for 5ns;
		In_one <= '1';
		In_c <= '1';
		In_v <= '1';
		In_not_z <= '1';
		
		wait for 5ns;
		S_ms <= "001";
		
		wait for 5ns;
		S_ms <= "010";
		
		wait for 5ns;
		S_ms <= "011";
		
		wait for 5ns;
		S_ms <= "100";
		
		wait for 5ns;
		S_ms <= "101";
		
		wait for 5ns;
		S_ms <= "110";
		
		wait for 5ns;
		S_ms <= "111";
		
		wait for 5ns;
		
      wait;
   end process;

END;
