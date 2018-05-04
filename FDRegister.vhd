library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;        -- for addition & counting
use ieee.numeric_std.all;               -- for type conversions
use ieee.math_real.all;                 -- for the ceiling and log constant calculation functions

entity FDRegister is
	port (Clk,Rst : in std_logic;
		  FromFetch : in std_logic_vector (15 downto 0);
		  ToDecode : out std_logic_vector (15 downto 0)
	);
end FDRegister;

architecture FDRegister_arc of FDRegister is
	component nbitRegister is
		Generic ( n : integer := 16);
		port( Clk,Rst,en : in std_logic;
		d : in std_logic_vector(n-1 downto 0);
		q : out std_logic_vector(n-1 downto 0));
		
	end component nbitRegister;
begin
FDBuffer : nbitRegister generic map(n=>16)port map (Clk,Rst,'1',FromFetch,ToDecode);
end FDRegister_arc;