Library ieee;
Use ieee.std_logic_1164.all;

Entity my_nDFF is

port( Clk,Rst,enable : in std_logic;
d : in std_logic_vector(15 downto 0);
q : out std_logic_vector(15 downto 0));
end my_nDFF;

Architecture a_my_nDFF of my_nDFF is
begin
process(Clk,Rst)
begin 
if(Rst='1') then
q<=(others=>'0');
elsif Clk'event and Clk='1' then
	if(enable='1') then
		q<=d;
	end if;
end if;
end process;

end a_my_nDFF;

