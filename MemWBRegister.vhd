
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;        -- for addition & counting
use ieee.numeric_std.all;               -- for type conversions
use ieee.math_real.all;                 -- for the ceiling and log constant calculation functions

entity MemWBRegister is
	port (Clk,Rst : in std_logic;
		  FromMem1,FromMem2,FromMem3 : in std_logic_vector (15 downto 0);
		  ToWB1,ToWB2,ToWB3 : out std_logic_vector (15 downto 0)
	);
end MemWBRegister;

architecture MemWBRegister_arc of MemWBRegister is
	component nbitRegister is
		Generic ( n : integer := 16);
		port( Clk,Rst,en : in std_logic;
		d : in std_logic_vector(n-1 downto 0);
		q : out std_logic_vector(n-1 downto 0));
		
	end component nbitRegister;
begin
MemWBBuffer1 : nbitRegister generic map(n=>16)port map (Clk,Rst,'1',FromMem1,ToWB1);
MemWBBuffer2 : nbitRegister generic map(n=>16)port map (Clk,Rst,'1',FromMem2,ToWB2);
MemWBBuffer3 : nbitRegister generic map(n=>16)port map (Clk,Rst,'1',FromMem3,ToWB3);

end MemWBRegister_arc;