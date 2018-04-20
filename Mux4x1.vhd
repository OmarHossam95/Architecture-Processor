Library ieee;
Use ieee.std_logic_1164.all;
 
Entity mux4v1 is
port(  
	D0,D1,D2,D3 : IN std_logic_vector(15 downto 0);
	S : IN std_logic_vector (1 downto 0);
	F : OUT std_logic_vector(15 downto 0));
end mux4v1 ;
 
Architecture mux4_archi of mux4v1 is
Begin
with S select 
F <=	D0 when  "00",
	D1 when  "01",
	D2 when  "10",
     	D3 when  others;
end mux4_archi;
