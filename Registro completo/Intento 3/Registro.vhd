library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

ENTITY INTENTO IS
	PORT(												--Asignaciòn logica de las variables
		  CLK		: IN STD_LOGIC;
		  A			: IN STD_LOGIC_VECTOR(3 DOWNTO 0);	--Entrada paralelo
		  B0,B1		: IN STD_LOGIC;					  	--Entrada en serie
		  MX		: IN STD_LOGIC_VECTOR(1 DOWNTO 0);	--Opciones del multiplexor de 4 a 1
		  QA		: OUT STD_LOGIC_VECTOR(3 DOWNTO 0)	--Vector de salida, salida general del sistema
		  );

ATTRIBUTE PIN_NUMBERS OF INTENTO: ENTITY IS				--Asignacion de pines fisicos
	" CLK:1 A(0):2 A(1):3 A(2):4 A(3):5 B0:6 B1:7 "	  	--Entradas
	& " MX(0):10 MX(1):11 "								--Entradas
	& " QA(0):14 QA(1):15 QA(2):16 QA(3):17 ";			--Salidas

END INTENTO;

ARCHITECTURE CODIGO OF INTENTO IS
BEGIN
	PROCESS(CLK)
	BEGIN
		IF(CLK'EVENT AND CLK='1')THEN					--Detecciòn del flanco de subida y clock en 1
			IF (MX(0)='0' AND MX(1)='0') THEN			--Si el selector del multiplexor es 00
				QA<=A;									--Asignaciòn en paralelo
			ELSIF (MX(0)='1' AND MX(1)='0') THEN		--Si el selector del multiplexor es 01			
				QA(0)<=QA(1);							--Rotaciòn del màs significativo al menos significativo
				QA(1)<=QA(2);							--Entra por la izquierda y sale por la derecha 
				QA(2)<=QA(3);							--Fisicamente se ve un corrimiento a la derecha
				QA(3)<=B0;
			ELSIF (MX(0)='0' AND MX(1)='1') THEN		--Si el selector del multiplexor es 10		
				QA(3)<=QA(2);							--Rotaciòn del menos signficativo al màs significativo
				QA(2)<=QA(1);							--Entra por la derecha y sale por la izquierda				
				QA(1)<=QA(0);							--Fiscamente se ve un corrimiento a la izquierda
				QA(0)<=B1;
			ELSIF (MX(0)='1' AND MX(1)='1') THEN
				QA<=QA;									--Memoria, mantiene el dato
			END IF;---------------------------------------
		END IF;
	END PROCESS;
END CODIGO;