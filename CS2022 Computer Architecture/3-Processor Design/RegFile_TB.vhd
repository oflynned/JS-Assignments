LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY RegFile_TB IS
END RegFile_TB;
 
ARCHITECTURE behavior OF RegFile_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RegFile
    PORT(
         des_d : IN  std_logic_vector(3 downto 0);
         add_a : IN  std_logic_vector(3 downto 0);
         add_b : IN  std_logic_vector(3 downto 0);
         Clk : IN  std_logic;
         load_in : IN  std_logic;
         data : IN  std_logic_vector(15 downto 0);
         out_data_a : OUT  std_logic_vector(15 downto 0);
         out_data_b : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal des_d : std_logic_vector(3 downto 0) := (others => '0');
   signal add_a : std_logic_vector(3 downto 0) := (others => '0');
   signal add_b : std_logic_vector(3 downto 0) := (others => '0');
   signal Clk : std_logic := '0';
   signal load_in : std_logic := '0';
   signal data : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal out_data_a : std_logic_vector(15 downto 0);
   signal out_data_b : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RegFile PORT MAP (
          des_d => des_d,
          add_a => add_a,
          add_b => add_b,
          Clk => Clk,
          load_in => load_in,
          data => data,
          out_data_a => out_data_a,
          out_data_b => out_data_b
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
		load_in <= '1'
		des_d <= "0000";
		data <= x"FFFF";
		wait for 10ns;
		
		des_d <= "0001";
		data <= x"EEEE";
		wait for 10ns;
		
		des_d <= "0010";
		data <= x"DDDD";
		wait for 10ns;
		
		des_d <= "0011";
		data <= x"CCCC";
		wait for 10ns;
		
		des_d <= "0100";
		data <= x"BBBB";
		wait for 10ns;
		
		des_d <= "0101";
		data <= x"AAAA";
		wait for 10ns;
		
		des_d <= "0110";	
		data <= x"9999";
		wait for 10ns;
			
		des_d <= "0111";
		data <= x"8888";
		wait for 10ns;
		
		des_d <= "1000";
		data <= x"7777";
		wait for 10ns;
		
		load_in <= '0';
		add_a <= "0000";
		add_b <= "0111";
		wait for 5ns;
		
		add_a <= "0001";
		add_b <= "0110";
		wait for 5ns;
		
		add_a <= "0010";
		add_b <= "0101";
		wait for 5ns;
		
		add_a <= "0011";
		add_b <= "0100";
		wait for 5ns;
		
		add_a <= "1000";
		add_b <= "1111";
		wait for 5ns;
		

      wait;
   end process;

END;
