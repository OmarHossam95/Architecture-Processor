Library ieee;
use ieee.std_logic_1164.all;

entity CCR is port(Zd,Nd,Cd,Vd,clk,en,rst: in std_logic;
		   Zq,Nq,Cq,Vq: out std_logic);
end entity;

architecture CCRArch of CCR is

component nbitRegister is
Generic ( n : integer := 16);
port( Clk,Rst,en : in std_logic;
d : in std_logic_vector(n-1 downto 0);
q : out std_logic_vector(n-1 downto 0));
end component;

signal d,q: std_logic_vector(3 downto 0);

begin
	CCRreg: nbitRegister generic map(n=>4) port map(clk,rst,en,d,q);
	d <= Vd&Cd&Nd&Zd;
	Vq <= q(3);
	Cq <= q(2);
	Nq <= q(1);
	Zq <= q(0);
end architecture;
