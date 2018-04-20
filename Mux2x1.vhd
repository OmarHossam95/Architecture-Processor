Library ieee;
Use ieee.std_logic_1164.all;
 
Entity mux2v1 is
port(  
	D0,D1 : IN std_logic_vector(15 downto 0);
	S : IN std_logic;
	F : OUT std_logic_vector(15 downto 0));
end mux2v1 ;
 
Architecture mux2_archi of mux2v1 is
Begin
with S select 
F <= D0 when  '0',
     D1 when  others;
end mux2_archi;
