LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.NUMERIC_STD.all;

ENTITY INTENTO IS
	PORT(												--Asignaciòn logica de las variables
		  CLK		: IN STD_LOGIC;
		  A			: IN STD_LOGIC;					  	--Entrada 
		  QA		: OUT STD_LOGIC_VECTOR(3 DOWNTO 0)	--Vector de salida, salida general del sistema
		  );

ATTRIBUTE PIN_NUMBERS OF INTENTO: ENTITY IS				--Asignacion de pines fisicos
	" CLK:1 A:2 "	  									--Entradas
	& " QA(0):14 QA(1):15 QA(2):16 QA(3):17 ";			--Salidas

END INTENTO;

ARCHITECTURE CODIGO OF INTENTO IS

SIGNAL  COUNT		:	STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	CONT		:	STD_LOGIC;
SIGNAL 	CLKSTATE	: 	STD_LOGIC := '0';

BEGIN

	PROCESS(CLK)
	BEGIN
		IF (CLK'EVENT AND CLK='1') THEN					--Detecciòn del flanco de subida y clock en 1
			IF (A='1' AND COUNT="0000") THEN
				COUNT(3)<=COUNT(2);
				COUNT(2)<=COUNT(1);
				COUNT(1)<=COUNT(0);
				COUNT(0)<=A;
			ELSIF (A='1') THEN
				COUNT(3)<=COUNT(2);
				COUNT(2)<=COUNT(1);
				COUNT(1)<=COUNT(0);
				COUNT(0)<='0';
			END IF;
		END IF;
	END PROCESS;

PROCESS(CLK)
	BEGIN
		IF(CLK'EVENT AND CLK='1')THEN
			IF (COUNT(0)='1') THEN
				IF(QA(0)='0' AND QA(1)='0' AND QA(2)='0' AND QA(3)='0')THEN
					QA(0)<='1';
					CONT<='0';
				ELSE
					QA(0)<='0';
				END IF;
				IF(CONT='0')THEN
					QA(3)<=QA(2);
					QA(2)<=QA(1);
					QA(1)<=QA(0);
					IF(QA(3)='1')THEN
						CONT<='1';
						QA(3)<='1';
					END IF;
				ELSIF(CONT='1')THEN
					QA(0)<=QA(1);
					QA(1)<=QA(2);
					QA(3)<='0';
					QA(2)<=QA(3);	
					IF(QA(0)='1')THEN
						CONT<='0';
						QA(0)<='1';
					END IF;
				END IF;
			ELSIF (COUNT(1)='1') THEN
				CLKSTATE<=NOT CLKSTATE;
				QA(0)<=CLKSTATE;
				QA(1)<=CLKSTATE;
				QA(2)<=CLKSTATE;
				QA(3)<=CLKSTATE;
			ELSIF (COUNT(2)='1') THEN
				QA(3)<=QA(2);
				QA(2)<=QA(1);
				QA(1)<=QA(0);
				IF(QA(0)='0' AND QA(1)='0' AND QA(2)='0' AND QA(3)='0')THEN
					QA(0)<='1';
				ELSE
					QA(0)<='0';
				END IF;
			ELSIF (COUNT(3)='1') THEN
				QA(0)<=QA(1);
				QA(1)<=QA(2);
				QA(2)<=QA(3);
				QA(3)<=NOT A;
				IF(QA(0)='0' AND QA(1)='0' AND QA(2)='0' AND QA(3)='0')THEN
					QA(3)<='1';
				ELSE
					QA(3)<='0';
				END IF;
			ELSE
				QA<="0000";
			END IF;
		END IF;
	END PROCESS;
END CODIGO;