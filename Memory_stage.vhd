library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;        -- for addition & counting
use ieee.numeric_std.all;               -- for type conversions
use ieee.math_real.all;                 -- for the ceiling and log constant calculation functions

--------------------------------------------------------------------------------

entity Memory_stage is
	port (
	
		Clk : in std_logic;
		WE : in std_logic;
		MemorySelect : in std_logic;
		EA,SP,Read2,PcPlus2 : in std_logic_vector(15 downto 0);
		DataOut : out std_logic_vector(15 downto 0)
	);

end Memory_stage;

--------------------------------------------------------------------------------

architecture Memory_stage_arc of Memory_stage is

--------------------------------------------------------------------------------
Signal MemoryAddress,MemoryDataIn : std_logic_vector(15 downto 0);

--------------------------------------------------------------------------------

component mux2v1
	
	port (
		D0,D1 : IN std_logic_vector(15 downto 0);
		S : IN std_logic;
		F : OUT std_logic_vector(15 downto 0)
		
	);
end component;

--------------------------------------------------------------------------------

component Memory is
	port(
		Clk : in std_logic;
		WE : in std_logic;
		Address : in std_logic_vector(9 downto 0);
		DataIn : in std_logic_vector(15 downto 0);
		DataOut : out std_logic_vector(15 downto 0)
		
	);
end component Memory;

--------------------------------------------------------------------------------
begin

Mux1: mux2v1 port map(EA,SP,MemorySelect,MemoryAddress);
Mux2: mux2v1 port map(Read2,PcPlus2,MemorySelect,MemoryDataIn);
DataMemory: Memory port map(Clk,WE,MemoryAddress(9 downto 0),MemoryDataIn,DataOut);

--Address <= MemoryAddress;
--DataIn  <= MemoryDataIn;

end Memory_stage_arc;

--------------------------------------------------------------------------------