Library ieee;
Use ieee.std_logic_1164.all;



entity rgister_file is 

port( 
port1_sel,port2_sel,w_sel : in std_logic_vector(2 downto 0);
w_en,clk,res: in std_logic;

write_value:in std_logic_vector(15 downto 0);
port1_data,port2_data : out std_logic_vector(15 downto 0)


);
end entity;




Architecture rgister_file_imp of rgister_file is
signal out1,out2,out3,out5,out4,out6 : std_logic_vector(15 downto 0);
signal e1,e2,e3,e4,e5,e6 :std_logic;




Component my_nDFF is

port( Clk,Rst,enable : in std_logic;
d : in std_logic_vector(15 downto 0);
q : out std_logic_vector(15 downto 0));
end component;
begin



ro:my_nDFF  port map(clk,res,e1,write_value,out1);
r1:my_nDFF  port map(clk,res,e2,write_value,out2);
r2:my_nDFF  port map(clk,res,e3,write_value,out3);
r3:my_nDFF  port map(clk,res,e4,write_value,out4);
r4:my_nDFF  port map(clk,res,e5,write_value,out5);
r5:my_nDFF  port map(clk,res,e6,write_value,out6);



with w_sel&w_en select  
 e1<='1' when "0001",
 '0' when others;

with w_sel&w_en select  
 e2<='1' when "0011",
 '0' when others;
with w_sel&w_en select  
 e3<='1' when "0101",
 '0' when others;
with w_sel&w_en select  
 e4<='1' when "0111",
 '0' when others;

with w_sel&w_en select  
 e5<='1' when "1001",
 '0' when others;
with w_sel&w_en select  
 e6<='1' when "1011",
 '0' when others;



with port1_sel select  
 port1_data<=out1 when "000",
out2 when "001",
out3 when "010",
out4 when "011",
out5 when "100",
 out6 when others;


with port2_sel select  
 port2_data<=out1 when "000",
out2 when "001",
out3 when "010",
out4 when "011",
out5 when "100",
 out6 when others;

end Architecture rgister_file_imp;
