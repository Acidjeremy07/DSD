LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.numeric_std.all;
USE ieee.std_logic_unsigned.all;

ENTITY DISPLAYOUT is
	PORT (  
			E	: IN 	STD_LOGIC_VECTOR(3 DOWNTO 0);
			DISPLAY	: OUT	STD_LOGIC_VECTOR(6 DOWNTO 0)
		  );

ATTRIBUTE PIN_NUMBERS OF DISPLAYOUT: ENTITY IS
	" E(0):2 E(1):3 E(2):4 E(3):5 "
	& " DISPLAY(0):14 DISPLAY(1):15 DISPLAY(2):16 DISPLAY(3):17 DISPLAY(4):18 "
	& " DISPLAY(5):19 DISPLAY(6):20 ";
END DISPLAYOUT;


ARCHITECTURE CODIGO OF DISPLAYOUT IS
	BEGIN

	PROCESS( E, DISPLAY )
    BEGIN	--4210
	CASE E IS				   --abcdefg
		when "0000"=> DISPLAY <="0000001";  --0
 		when "0001"=> DISPLAY <="1001111";  --1
  		when "0010"=> DISPLAY <="0010010";  --2
	  	when "0011"=> DISPLAY <="0000110";  --3
  		when "0100"=> DISPLAY <="1001100";  --4
  		when "0101"=> DISPLAY <="0100100";  --5
	  	when "0110"=> DISPLAY <="0100000";  --6
	  	when "0111"=> DISPLAY <="0001111";  --7
	 	when "1000"=> DISPLAY <="0000000";  --8
	  	when "1001"=> DISPLAY <="0001100";  --9
-----------------------------------------------
							   --ABCDEFG
		when "1010"=> DISPLAY <="0001000";  --10 A
 		when "1011"=> DISPLAY <="1100000";  --11 B
  		when "1100"=> DISPLAY <="0110001";  --12 C
	  	when "1101"=> DISPLAY <="1000010";  --13 D
  		when "1110"=> DISPLAY <="0110000";  --14 E
  		when "1111"=> DISPLAY <="0111000";  --15 F
-----------------------------------------------
		when others => DISPLAY <="0000000";
	 END CASE;
	 END PROCESS;
END CODIGO;
