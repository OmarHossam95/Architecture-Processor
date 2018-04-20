library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;        -- for addition & counting
use ieee.numeric_std.all;               -- for type conversions
use ieee.math_real.all;                 -- for the ceiling and log constant calculation functions

entity Memory is
	port (
		Clk : in std_logic;
		WE : in std_logic;
		Address : in std_logic_vector(9 downto 0);
		DataIn : in std_logic_vector(15 downto 0);
		DataOut : out std_logic_vector(15 downto 0)
	);
end Memory;

architecture Memory_arc of Memory is

type RamType is array (0 to 1023) of std_logic_vector(15 downto 0);
signal Ram : RamType;

begin

process(Clk) is
begin
if rising_edge(Clk) then
if WE = '1' then
Ram(to_integer(unsigned(Address))) <= DataIn;
end if;
end if;
end process;
DataOut <= Ram(to_integer(unsigned(Address)));

end Memory_arc;
