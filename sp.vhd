library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;        -- for addition & counting
use ieee.numeric_std.all;               -- for type conversions
use ieee.math_real.all;                 -- for the ceiling and log constant calculation functions

entity sp is 
port( 
clk,res,spEnable,spSel: in std_logic;
dataIn:in std_logic_vector(15 downto 0);
dataOut:out std_logic_vector(15 downto 0)


);
end entity;


Architecture spImp of sp is
signal outSpReg,outAdder : std_logic_vector(15 downto 0);

Component my_nDFF is

port( Clk,Rst,enable : in std_logic;
d : in std_logic_vector(15 downto 0);
q : out std_logic_vector(15 downto 0));
end component;

begin


with spSel select  
 outAdder<=std_logic_vector( unsigned(outSpReg)+1) when '1',
 std_logic_vector(unsigned(outSpReg)-1) when others;

ro:my_nDFF  port map(clk,res,spEnable,outAdder,outSpReg);

end Architecture spImp;