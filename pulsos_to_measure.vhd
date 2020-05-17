--CAMBIO PULSOS A MEDIDA FÍSICA
library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

ENTITY pulsos_to_measure IS 
	port(total_pulsos_in: in std_logic_vector(63 DOWNTO 0);
		  total_pulsos_out: out std_logic_vector(7 DOWNTO 0));
	END pulsos_to_measure;
	
ARCHITECTURE arch OF pulsos_to_measure IS
signal pulsos_in_aux:  unsigned(63 DOWNTO 0);
signal pulsos_out_aux: unsigned(7 DOWNTO 0);

	BEGIN
	
	pulsos_in_aux    <= unsigned(total_pulsos_in)/10;
	pulsos_out_aux   <= pulsos_in_aux(7 DOWNTO 0) ;
	total_pulsos_out <= std_logic_vector(pulsos_out_aux);

	END arch;
		
