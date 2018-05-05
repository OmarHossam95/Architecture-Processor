Library ieee;
use ieee.std_logic_1164.all;

entity EMBuffer is port(clk,rst: std_logic;
			ALUoutd,Immd,PCplus1d,Read2d: in std_logic_vector(15 downto 0); --Imm is the same as EA
			OPGroupd: in std_logic_vector(1 downto 0); 
			MemAddSeld,MemWrSeld,MemEnd,ALUImmSeld: in std_logic;
			ALUoutq,Immq,PCplus1q,Read2q: out std_logic_vector(15 downto 0); --Imm is the same as EA
			OPGroupq: out std_logic_vector(1 downto 0); 
			MemAddSelq,MemWrSelq,MemEnq,ALUImmSelq: out std_logic);
end entity;

architecture EMBArch of EMBuffer is

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
	ALUout: nbitRegister generic map(n=>16) port map(clk,rst,'1',ALUoutd,ALUoutq);
	Imm: nbitRegister generic map(n=>16) port map(clk,rst,'1',Immd,Immq);
	PCplus1: nbitRegister generic map(n=>16) port map(clk,rst,'1',PCplus1d,PCplus1q);
	Read2: nbitRegister generic map(n=>16) port map(clk,rst,'1',Read2d,Read2q);
	OPGroup: nbitRegister generic map(n=>16) port map(clk,rst,'1',OPGroupd,OPGroupq);
	MemAddSel: my_DFF port map(clk,rst,'1',MemAddSeld,MemAddSelq);
	MemWrSel: my_DFF port map(clk,rst,'1',MemWrSeld,MemWrSelq);
	MemEn: my_DFF port map(clk,rst,'1',MemEnd,MemEnq);
	ALUImmSel: my_DFF port map(clk,rst,'1',ALUImmSeld,ALUImmSelq);
end architecture;
