Library ieee;
Use ieee.std_logic_1164.all;


entity CUPart3 is 

port( 
OPGroup: in std_logic_vector(1 downto 0);
OP:in std_logic_vector(4 downto 0);

Stall,INTMWB:in std_logic;
INTBegin,JumpEn,RTN:out std_logic

);
end entity;

Architecture CUImp of CUPart3 is
signal OutAnd :std_logic;
begin
OutAnd<=OPGroup(0) and (not(OPGroup(1)));
RTN<=OP(3) and OutAnd;
INTBegin<=INTMWB;
JumpEn<=Stall;
end CUImp;
