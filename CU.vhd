library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;        -- for addition & counting
use ieee.numeric_std.all;               -- for type conversions
use ieee.math_real.all;                 -- for the ceiling and log constant calculation functions


entity CU is 
port (
OP :in std_logic_vector (4 downto 0);
Z,N,C : in std_logic; 
JmpEn,WB,WBCCR,Cen : out std_logic;

OpGroup: in std_logic_vector(1 downto 0);

ImmEn, SPwriteEn, SPsel, MemAddSel, MemWrSel, MemEn: out std_logic;
Stall:in std_logic;
INTBegin,JumpEn,RTN,ALUImmSel:out std_logic


);
end CU;

architecture CUArc of CU is

signal INT: std_logic;

component CUPart1 is
	port (
		OP :in std_logic_vector (4 downto 0);
		OPGrp :in std_logic_vector (1 downto 0);
		Z,N,C : in std_logic; 
		JmpEn,WB,WBCCR,Cen : out std_logic
	);
end component;
component CUPart2 is port(OpGroup: in std_logic_vector(1 downto 0);
		       Op: in std_logic_vector (4 downto 0);
		       INT: in std_logic;
		       ImmEn, SPwriteEn, SPsel, MemAddSel, MemWrSel, MemEn: out std_logic);
end component;
component CUPart3 is 
port( 
OPGroup: in std_logic_vector(1 downto 0);
OP:in std_logic_vector(4 downto 0);

Stall,INT:in std_logic;
INTBegin,RTN,ALUImmSel:out std_logic

);
end component;

begin
with OPGroup&OP select
INT <= '1' when "1111111",
       '0' when others;

Part1:CUPart1  port map(OP,OPGroup,Z,N,C,JmpEn,WB,WBCCR,Cen);
Part2:CUPart2  port map(OPGroup,OP,INT,ImmEn,SPwriteEn,SPsel,MemAddSel,MemWrSel,MemEn);
Part3:CUPart3  port map(OPGroup,OP,Stall,INT,INTBegin,RTN,ALUImmSel);




end CUArc;
