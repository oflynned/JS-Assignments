library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Memory is
	Port(	address_mem : in STD_LOGIC_VECTOR(15 downto 0);
			write_data : in STD_LOGIC_VECTOR(15 downto 0);
			mem_write : in STD_LOGIC;
			read_data : out STD_LOGIC_VECTOR(15 downto 0)
			);
end Memory;

architecture Behavioral of Memory is
	--512 bit memory array
	type mem_array is array(0 to 511) of  STD_LOGIC_VECTOR(15 downto 0);
begin
	mem_process : process(address_mem, write_data, mem_write)
	variable data_mem : mem_array := (
		--module 00
		x"0000", --0 
		x"0000", --1 store in reg 0
		x"0241", --2 store in reg 1
		x"0482", --3 store in reg 2
		x"06C3", --4 store in reg 3
		x"0904", --5 store in reg 4
		x"0B45", --6 store in reg 5
		x"0D86", --7 store in reg 6
		x"0FC7", --8 store in reg 7
		x"11BE", --9 ADD -> add operands
		x"1230", --A LDR -> load to r0 from memory
		x"1401", --B STR -> store from r1 into memory address
		x"1650", --C INC -> increment value in r2 by 1 and store in r1
		x"1928", --D CMP -> compliment value in r5 and store in r4
		x"1A9B", --E ADD -> adds values and stores into r2 via r3
		x"1C52", --F BCH -> branch unconditionally
		
		--module 01
		x"2652", --0 ADD STR r1 -> add and store into r1
		x"2802", --1 BCZ -> branch conditionally if z is set thereby skipping the next add instruction
		x"2A5B", --2 ADD STR r1 -> add and stores into r1
		x"2D9B", --3 ADD STR r6 -> add and stores into r6
		x"2F9B", --4 ADD STR r6 -> add and stores into r6
		x"0000",
		x"0000",
		x"0000",
		x"0000",
		x"0000",
		x"0000",
		x"0000",
		x"0000",
		x"0000",
		x"0000",
		x"0000",
		
		--module 02
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		
		--module 03
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		
		--module 04
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		
		--module 05
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		
		--module 06
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		
		--module 07
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		
		--module 08
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		
		--module 09
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		
		--module 0A
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		
		--module 0B
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		
		--module 0C
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		
		--module 0D
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		
		--module 0E
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		
		--module 0F
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		
		--module 10
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		
		--module 11
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		
		--module 12
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		
		--module 13
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		
		--module 14
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		
		--module 15
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		
		--module 16
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		
		--module 17
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		
		--module 18
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		
		--module 19
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		
		--module 1A
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		
		--module 1B
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		
		--module 1C
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		
		--module 1D
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		
		--module 1E
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		
		--module 1F
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000",
		x"0000", x"0000", x"0000", x"0000"
	);
	
	variable addr : integer range 0 to 511;
	variable addr_out : STD_LOGIC_VECTOR(15 downto 0);
	
	begin
		addr := conv_integer(address_mem(8 downto 0));
		addr_out := data_mem(addr);
		if mem_write = '1' then
			data_mem(addr) := write_data;
		else read_data <= addr_out;
		end if;
	end process;

end Behavioral;

