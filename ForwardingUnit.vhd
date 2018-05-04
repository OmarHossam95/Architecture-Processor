library ieee;
use ieee.std_logic_1164.all;

entity FWDUnit is port(Rsrc, Rdst, EMdst, MWdst: in std_logic_vector(2 downto 0);
		       EMwb, MWwb: in std_logic;
		       FWselSrc, FWselDst: out std_logic_vector(1 downto 0));
end entity;

architecture FWDArch of FWDUnit is
signal EMsameSrc, MWsameSrc, EMsameDst, MWsameDst: std_logic_vector(2 downto 0);
signal EMsrcFWD, MWsrcFWD, EMdstFWD, MWdstFWD: std_logic;
begin
	EMsameSrc <= EMdst xnor Rsrc;
	MWsameSrc <= MWdst xnor Rsrc;
	EMsameDst <= EMdst xnor Rdst;
	MWsameDst <= MWdst xnor Rdst;

	EMsrcFWD <= EMsameSrc(0) and EMsameSrc(1) and EMsameSrc(2) and EMwb;
	MWsrcFWD <= MWsameSrc(0) and MWsameSrc(1) and MWsameSrc(2) and MWwb;
	EMdstFWD <= EMsameDst(0) and EMsameDst(1) and EMsameDst(2) and EMwb;
	MWdstFWD <= MWsameDst(0) and MWsameDst(1) and MWsameDst(2) and MWwb;

	FWselSrc <= MWsrcFWD&EMsrcFWD;
	FWselDst <= MWdstFWD&EMdstFWD;
end architecture;
