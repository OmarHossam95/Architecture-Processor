library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;        -- for addition & counting
use ieee.numeric_std.all;               -- for type conversions
use ieee.math_real.all;                 -- for the ceiling and log constant calculation functions


entity Fetch is
	port (	
			Read2,MemOut : in std_logic_vector (15 downto 0);
			Clk,JmpEnable,Stall,Interept,Rtn,Rst : in std_logic; -- Rtn --> Return signal
			FetchOut : out std_logic_vector (15 downto 0) 

	);
end Fetch;

architecture Fetch_arc of Fetch is
	---------------------------------------------------------------------------- multiplixer 2x1
	component mux2v1 is
		port (	
				D0,D1 : IN std_logic_vector(15 downto 0);
				S : IN std_logic;
				F : OUT std_logic_vector(15 downto 0)
		);
	end component mux2v1;
	---------------------------------------------------------------------------- multiplixer 4x1
	component mux4v1 is
		port (
				D0,D1,D2,D3 : IN std_logic_vector(15 downto 0);
				S : IN std_logic_vector (1 downto 0);
				F : OUT std_logic_vector(15 downto 0)
		);
	end component mux4v1;
	---------------------------------------------------------------------------- Memory
	component Memory is
		port (
				Clk : in std_logic;
				WE : in std_logic;
				Address : in std_logic_vector(9 downto 0);
				DataIn : in std_logic_vector(15 downto 0);
				DataOut : out std_logic_vector(15 downto 0)
			
		);
	end component Memory;
	---------------------------------------------------------------------------- Register
	component my_nDFF is
		port (
				Clk,Rst,enable : in std_logic;
				d : in std_logic_vector(15 downto 0);
				q : out std_logic_vector(15 downto 0)
		);
	end component my_nDFF;
	---------------------------------------------------------------------------- end of components
	---------------------------------------------------------------------------- Signals
	signal ShiftedRead2,Mux1out,Mux2out,Mux3out,Mux4out,Mux5out,PCout,NewPCout,IMout : std_logic_vector(15 downto 0); -- PCout : program counter output , IMout : instruction memory output
	Signal Mux4Select : std_logic_vector (1 downto 0);
begin
	ProgramCounter : my_nDFF port map (Clk,Rst,'1',mux4out,PCout);
	InstructionMemory : Memory port map ( Clk,'0',PCout(9 downto 0),X"0000",IMout );
	mux1: mux2v1 port map (NewPCout,PCout,Stall,Mux1out);
	mux2: mux2v1 port map (Mux1out,ShiftedRead2,JmpEnable,Mux2out);
	mux3: mux2v1 port map (Mux2out,MemOut,Rtn,Mux3out);
	mux4: mux4v1 port map (Mux3out,X"0001",X"0000",X"0000",Mux4Select,Mux4out);
	mux5: mux2v1 port map (IMout,X"FFFF",Interept,Mux5out);
	Mux4Select <= Rst & Interept ;
	NewPCout <= std_logic_vector(unsigned (PCout) + 2);
	ShiftedRead2 <= Read2(13 downto 0) & "00";
	FetchOut <= Mux5out ;
end Fetch_arc;