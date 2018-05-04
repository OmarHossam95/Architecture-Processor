Library ieee;
use ieee.std_logic_1164.all;

entity CUPart3 is port(OpGroup: in std_logic_vector(1 downto 0);
		       Op: in std_logic_vector (4 downto 0);
		       INT: in std_logic;
		       ImmEn, SPwriteEn, SPsel, MemAddSel, MemWrSel, MemEn: out std_logic);
end entity;

architecture CU3Arch of CUPart3 is
signal LDM, SHL, RRC, PUSH, CALL, LDD, STD: std_logic;
signal opGrp01, opGrp10, op2or3: std_logic;
begin
	with OpGroup&Op select
	LDM <= '1' when "0001110",
	       '0' when others;

	with OpGroup&Op select
	SHL <= '1' when "0001000",
	       '0' when others;

	with OpGroup&Op select
	RRC <= '1' when "0000111",
	       '0' when others;

	with OpGroup&Op select
	PUSH <= '1' when "0100000",
	       '0' when others;

	with OpGroup&Op select
	CALL <= '1' when "1000100",
	       '0' when others;

	with OpGroup&Op select
	LDD <= '1' when "0100011",
	       '0' when others;

	with OpGroup&Op select
	STD <= '1' when "0100010",
	       '0' when others;

	ImmEn <= LDM or SHL or RRC;
	opGrp01 <= OpGroup(0) and (not OpGroup(1));
	opGrp10 <= (not OpGroup(0)) and OpGroup(1);
	op2or3 <= Op(2) or Op(3);

	SPwriteEn <= (opGrp01 and (not Op(1))) or (OpGrp10 and op2or3) or INT;
	SPsel <= PUSH or CALL or INT;
	MemAddSel <= LDD or STD;
	MemWrSel <= Op(0);
	MemEn <= ((not Op(0)) and OpGrp01) or (op2or3 and OpGrp10) or INT;


end architecture;
