LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.NUMERIC_STD.all;

ENTITY INTENTO IS
	PORT(												--Asignaci�n logica de las variables
		  CLK		: IN STD_LOGIC;
		  SI,SD		: IN STD_LOGIC;					  	--Entrada 
		  MI		: OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		  MD		: OUT STD_LOGIC_VECTOR(1 DOWNTO 0)	--Vector de salida, salida general del sistema
		  );

ATTRIBUTE PIN_NUMBERS OF INTENTO: ENTITY IS				--Asignacion de pines fisicos
	" CLK:1 SI:2 SD:3 "	  									--Entradas
	& " MI(0):14 MI(1):15 MD(0):16 MD(1):17 ";			--Salidas

END INTENTO;

ARCHITECTURE CODIGO OF INTENTO IS

BEGIN

	PROCESS(CLK)
	BEGIN
		IF(CLK'EVENT AND CLK='1')THEN
			IF(SI='0' AND SD='0')THEN		--NO DETECTA NADA
				MI<="10";					--SIGUE DERECHO
				MD<="10";
			ELSIF(SI='0' AND SD='1')THEN	--DETECTA ALGO A LA DERECHA
				MI<="01";					--MOTOR IZQUIERO RETROCEDE
				MD<="10";					--MOTOR DERECHO SIGUE AVANZANDO
			ELSIF(SI='1' AND SD='0')THEN	--DETECTA ALGO A LA IZQUIERDA	(GIRO A LA IZQUIERDA
				MI<="10";					--MOTOR IZQUIERDO SIGUE AVANZANDO
				MD<="01";					--MOTOR DERECHO RETROCEDE
			ELSIF(SI='1' AND SD='1')THEN	--DETECTA ALGO EN LOS DOS LADOS (REVERSA)
				MI<="01";					--MOTOR IZQUIERDO RETROCEDE
				MD<="01";					--MOTOR DERECHO RETROCEDE
			END IF;
		END IF;
	END PROCESS;
END CODIGO;
