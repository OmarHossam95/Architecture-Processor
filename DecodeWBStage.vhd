library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;        -- for addition & counting
use ieee.numeric_std.all;               -- for type conversions
use ieee.math_real.all;                 -- for the ceiling and log constant calculation functions


entity DecodeWB is
	port (	
			MEMout,INport,ALUout,Imm : in std_logic_vector (15 downto 0);
			Clk,AluImm,SPdir,Rst,SpEn,WB : in std_logic; -- Rtn --> Return signal
			OPgrp: in std_logic_vector (1 downto 0);
			RS,RD: in std_logic_vector (2 downto 0);
			Read1,Read2,SPout,CCRout : out std_logic_vector (15 downto 0) 

	);
end DecodeWB;

architecture DecodeWB_arc of DecodeWB is
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
	----------------------------------------------------------------------------StackPointer
	component sp  is
		port (
			clk,rst,spEn,spSel: in std_logic;
			dataOut:out std_logic_vector(15 downto 0)
		);
	end component sp;
	----------------------------------------------------------------------------RegisterFile
	component register_file is
		port (
			port1_sel,port2_sel,w_sel : in std_logic_vector(2 downto 0);
			w_en,clk,res: in std_logic;
			write_value:in std_logic_vector(15 downto 0);
			port1_data,port2_data : out std_logic_vector(15 downto 0)
		);
	end component register_file;
	----------------------------------------------------------------------------
	signal Mux1out,Mux2out: std_logic_vector (15 downto 0);
	begin
		StackPointer : sp port map (Clk,Rst,SpEn,SPdir,SPout);
		RegisterFile : register_file port map (RS,RD,RD,WB,Clk,Rst,Mux2out,Read1,Read2);
		Mux2x1 : mux2v1 port map (ALUout,Imm,AluImm,Mux1out);
		Mux4x1 : mux4v1 port map (Mux1out,X"0000",MEMout,INport,OPgrp,Mux2out);

end DecodeWB_arc;