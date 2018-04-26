Library ieee;
use ieee.std_logic_1164.all;

entity EXStage is port(Read1, Read2, EbMout,MbWout,ImmVal: in std_logic_vector(15 downto 0);
		       Op: in std_logic_vector(4 downto 0);
		       Cin,IMMen: in std_logic;
		       FWDen: in std_logic_vector (1 downto 0);
		       F: out std_logic_vector(15 downto 0);
		       ZF,NF,CF,VF: out std_logic);
end entity;


architecture EXArch of EXStage is

component ALU is port(A,B: in std_logic_vector(15 downto 0);
		   Cin: in std_logic;
		   S: in std_logic_vector(4 downto 0);
		   F: out std_logic_vector(15 downto 0);
		   OVF: out std_logic;
		   Cout: out std_logic);
end component;

signal A,B,Binter,ALUout: std_logic_vector(15 downto 0);

begin

	ALU0: ALU port map(A,B,Cin,Op,ALUout,VF,CF);

	with FWDen select
	A <= Read1 when "00",
	     EbMout when "01",
	     MbWout when "10",
	     X"0000" when others;

	with FWDen select
	Binter <= Read1 when "00",
	     EbMout when "01",
	     MbWout when "10",
	     X"0000" when others;

	with IMMen select
	B <= Binter when '0',
	     ImmVal when others;

	F <= ALUout;
	ZF <= not (A(15) and A(14) and A(13) and A(12) and A(11) and A(10) and A(9) and A(8) and A(7) and
		   A(6) and A(5) and A(4) and A(3) and A(2) and A(1) and A(0));
	NF <= ALUout(15);

end architecture;