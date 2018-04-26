Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is port(A,B: in std_logic_vector(15 downto 0);
		   Cin: in std_logic;
		   S: in std_logic_vector(4 downto 0);
		   F: out std_logic_vector(15 downto 0);
		   OVF: out std_logic;
		   Cout: out std_logic);
end entity;

architecture aluArch of ALU is
signal AddSubOp: std_logic_vector(15 downto 0);
signal addResult: std_logic_vector(15 downto 0);
signal subResult: std_logic_vector(15 downto 0);
begin
	
	with S(1) select
	AddSubOp <= B when '1',
		    X"0001" when others;

	addResult <= std_logic_vector(signed(A) + signed(AddSubOp));
	subResult <= std_logic_vector(signed(A) - signed(AddSubOp));

	with S select
	F <= A when "00001",
	     addResult when "00010",
	     subResult when "00011",
	     A and B when "00100",
	     A or B when "00101",
	     A(14 downto 0) & Cin when "00110",
	     Cin & A(15 downto 1) when "00111",
	     to_stdlogicvector(to_bitvector(A) sll to_integer(unsigned(B))) when "01000",
	     to_stdlogicvector(to_bitvector(A) srl to_integer(unsigned(B))) when "01001",
	     not A when "01010",
	     std_logic_vector(-signed(A)) when "01011",
	     addResult when "01100",
	     subResult when "01101",
	     A when "01110",
	     X"0000" when others;

	with S select
	OVF <= (A(15) xnor B(15)) and (A(15) xor addResult(15)) when "00010",
	       (A(15) xor B(15)) and (A(15) xor subResult(15)) when "00011",
	       ((not A(15)) and addResult(15)) when "01100",
	       (A(15) and (not subResult(15))) when "01101",
	       '0' when others;

	with S select
	Cout <= A(15) when "00110",
		A(0) when "00111",
		'1' when "10001",
		'0'when others;

end architecture;