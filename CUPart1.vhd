library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;        -- for addition & counting
use ieee.numeric_std.all;               -- for type conversions
use ieee.math_real.all;                 -- for the ceiling and log constant calculation functions

entity CUPart1 is
	port (
		OP :in std_logic_vector (4 downto 0);
		OPGrp :in std_logic_vector (1 downto 0);
		Z,N,C : in std_logic; 
		JmpEn,WB,WBCCR,Cen : out std_logic
	);
end CUPart1;

architecture CUPart1_arc of CUPart1 is
signal AndOpgrp,AndOPgrpOP4, MuxOut,OROut : std_logic;
signal AndOut1,Andout2,Andout3,Andout4,Andout5,Andout6,ORout1:std_logic;
signal SETC,CLRC,RLC,RRC: std_logic;
signal OPgrpOP : std_logic_vector ( 6 downto 0);
signal OPP:std_logic_vector(1 downto 0);
begin
	----------------------------------------------------------------------------
	AndOpgrp <= OPGrp(1) and (not OPGrp(0));
	AndOPgrpOP4 <= AndOpgrp and (not OP(4));
OPP<=OP(0)&OP(1);	
with OPP select
	MuxOut <= Z when "00",
		  N when "01",
		  C when "10",
		 '0' when others;
	OROut <= MuxOut or (OP(0) and OP(1)) or OP(2) or OP(3);
	JmpEn <= OROut and AndOPgrpOP4;
	----------------------------------------------------------------------------
	AndOut1 <= (not OPGrp(0)) and (not OPGrp(1));
	ORout1   <= OP(0) or OP(1) or OP(2) or OP(3) ;
	Andout2 <= ORout1 and (not OP(4));
	Andout3 <= AndOut1 and Andout2 ;
	WBCCR <= Andout3;
	Andout4 <= (not OPGrp(0)) and OPGrp(1);
	
	Andout5 <= Andout4 and OP(0);
	Andout6 <= OPGrp(0) and OPGrp(1);

	WB <= Andout3 or Andout6 or Andout5;
	----------------------------------------------------------------------------
	OPgrpOP<= OPGrp&OP;
with OPgrpOP select
		SETC <= '1' when "0010001",
		 	 '0' when others;
with OPgrpOP select
		 RLC <= '1' when "0000110",
		 		'0' when others;
with OPgrpOP select
		 RRC <= '1' when "0000111",
		 		'0' when others;
with OPgrpOP select
		 CLRC <= '1' when "0010000",
		 		'0' when others;


	Cen <= SETC or RLC or RRC or CLRC ;
end CUPart1_arc;
