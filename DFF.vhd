Library ieee;
use ieee.std_logic_1164.all;
Entity my_DFF is
port( clk,rst, enable,d: in std_logic;
q : out std_logic);
end my_DFF;

Architecture a_my_DFF of my_DFF is
begin
process(clk,rst)
begin
if(rst = '1') then
        q <= '0';
elsif rising_edge(clk) then   
	if (enable = '1') then          
 	    q <= d;
  end if;
end if;
end process;
end a_my_DFF;

