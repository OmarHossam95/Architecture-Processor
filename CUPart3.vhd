Library ieee;
Use ieee.std_logic_1164.all;


entity CUPart3 is 

port( 
OPGroup: in std_logic_vector(1 downto 0);
OP:in std_logic_vector(4 downto 0);

Stall,INT:in std_logic;
INTBegin,RTN,ALUImmSel:out std_logic

);
end entity;

Architecture CUImp of CUPart3 is
signal OutAnd :std_logic;
begin
OutAnd<=OPGroup(0) and (not(OPGroup(1)));
RTN<=OP(3) and OutAnd;
INTBegin<=INT;

with OPGroup&OP select
	ALUImmSel <= '1' when "0001110",
		     '0' when others;
end CUImp;
