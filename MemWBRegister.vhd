
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;        -- for addition & counting
use ieee.numeric_std.all;               -- for type conversions
use ieee.math_real.all;                 -- for the ceiling and log constant calculation functions

entity MemWBRegister is
	port (Clk,Rst : in std_logic;
	      MemOutd,ALUoutd,Immd: in std_logic_vector (15 downto 0);
	      OPGroupd: in std_logic_vector(1 downto 0);
	      ALUImmSeld: in std_logic;
	      MemOutq,ALUoutq,Immq: out std_logic_vector (15 downto 0);
	      OPGroupq: out std_logic_vector(1 downto 0);
	      ALUImmSelq: out std_logic);
end MemWBRegister;

architecture MemWBRegister_arc of MemWBRegister is
	component nbitRegister is
		Generic ( n : integer := 16);
		port( Clk,Rst,en : in std_logic;
		d : in std_logic_vector(n-1 downto 0);
		q : out std_logic_vector(n-1 downto 0));
		
	end component nbitRegister;

	component my_DFF is
		port( clk,rst, enable,d: in std_logic;
		q : out std_logic);
	end component;
begin
	MemOut: nbitRegister generic map(n=>16)port map (Clk,Rst,'1',MemOutd,MemOutq);
	ALUOut: nbitRegister generic map(n=>16)port map (Clk,Rst,'1',ALUOutd,ALUOutq);
	Imm: nbitRegister generic map(n=>16)port map (Clk,Rst,'1',Immd,Immq);
	OPGroup: nbitRegister generic map(n=>2)port map (Clk,Rst,'1',OPGroupd,OPGroupq);
	ALUImmSel: my_DFF port map(Clk,Rst,'1',ALUImmSeld,ALUImmSelq);
end MemWBRegister_arc;