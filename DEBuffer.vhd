Library ieee;
use ieee.std_logic_1164.all;

entity DEBuffer is port( clk, rst: std_logic;
		       Read1d, Read2d, ImmVald,SPd,PCplus1d: in std_logic_vector(15 downto 0);
		       OpGroupd: in std_logic_vector(1 downto 0); 
		       Opd: in std_logic_vector(4 downto 0);
		       Cind,Cend,IMMend,WBCCRd: in std_logic;
		       MemAddSeld,MemWrSeld,MemEnd: in std_logic;
		       ALUImmSeld: in std_logic;
		       Read1q, Read2q, ImmValq,SPq,PCplus1q: out std_logic_vector(15 downto 0);
		       OpGroupq: out std_logic_vector(1 downto 0); 
		       Opq: out std_logic_vector(4 downto 0);
		       Cinq,Cenq,IMMenq,WBCCRq: out std_logic;
		       MemAddSelq,MemWrSelq,MemEnq: out std_logic;
		       ALUImmSelq: out std_logic);
end entity;

architecture DEArch of DEBuffer is

component nbitRegister is
Generic ( n : integer := 16);
port( Clk,Rst,en : in std_logic;
d : in std_logic_vector(n-1 downto 0);
q : out std_logic_vector(n-1 downto 0));
end component;

component my_DFF is
port( clk,rst, enable,d: in std_logic;
q : out std_logic);
end component;

begin
	Read1: nBitRegister generic map (n => 16) port map(clk,rst,'1',Read1d,Read1q);
	Read2: nBitRegister generic map (n => 16) port map(clk,rst,'1',Read2d,Read2q);
	ImmVal: nBitRegister generic map (n => 16) port map(clk,rst,'1',ImmVald,ImmValq);
	SP: nBitRegister generic map (n => 16) port map(clk,rst,'1',SPd,SPq);
	PCplus1: nBitRegister generic map (n => 16) port map(clk,rst,'1',PCplus1d,PCplus1q);
	OpGroup: nBitRegister generic map (n => 2) port map(clk,rst,'1',OpGroupd,OpGroupq);
	Op: nBitRegister generic map (n => 5) port map(clk,rst,'1',Opd,Opq);
	Cin: my_DFF port map(clk,rst,'1',Cind,Cinq);
	Cen: my_DFF port map(clk,rst,'1',Cend,Cenq);
	IMMen: my_DFF port map(clk,rst,'1',IMMend,IMMenq);
	WBCCR: my_DFF port map(clk,rst,'1',WBCCRd,WBCCRq);
	MemAddSel: my_DFF port map(clk,rst,'1',MemAddSeld,MemAddSelq);
	MemWrSel: my_DFF port map(clk,rst,'1',MemWrSeld,MemWrSelq);
	MemEn: my_DFF port map(clk,rst,'1',MemEnd,MemEnq);
	ALUImmSel: my_DFF port map(clk,rst,'1',ALUImmSeld,ALUImmSelq);
end architecture;
