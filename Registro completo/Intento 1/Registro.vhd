library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

ENTITY INTENTO IS
	PORT(
		  CLK		: IN STD_LOGIC;
		  A			: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		  B0,B1		: IN STD_LOGIC;
		  MX		: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		  QA		: OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
		  );
ATTRIBUTE PIN_NUMBERS OF INTENTO: ENTITY IS
	" CLK:1 A(0):2 A(1):3 A(2):4 A(3):5 B0:6 B1:7 "	--Asignacion de pines fisicos
	& " MX(0):10 MX(1):11 "
	& " QA(0):14 QA(1):15 QA(2):16 QA(3):17 ";

END INTENTO;

ARCHITECTURE CODIGO OF INTENTO IS
	
BEGIN
	PROCESS(CLK)
	BEGIN
		IF(CLK'EVENT AND CLK='1')THEN
			IF (MX(0)='0' AND MX(1)='0') THEN
				QA<=A;
			ELSIF (MX(0)='1' AND MX(1)='0') THEN				
				QA(0)<=QA(1);
				QA(1)<=QA(2);
				QA(2)<=QA(3);
				QA(3)<=B0;
			ELSIF (MX(0)='0' AND MX(1)='1') THEN				
				QA(0)<=QA(1);
				QA(1)<=QA(2);
				QA(2)<=QA(3);
				QA(3)<=B1;
			ELSIF (MX(0)='1' AND MX(1)='1') THEN
				QA<=QA;
			END IF;---------------------------------------
		END IF;
	END PROCESS;
END CODIGO;