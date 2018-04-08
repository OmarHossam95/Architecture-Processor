Library ieee;
use ieee.std_logic_1164.all;

entity LU is
port (A,B : in std_logic_vector (15 downto 0);
	S : in std_logic_vector (1 downto 0);
	F : out std_logic_vector (15 downto 0));
end entity LU;

Architecture myArch of LU is
begin
	with S select
		F <= A and B when "00",
		     A or B when "01",
		     A xor B when "10",
		     not A when others;
end Architecture myArch;

