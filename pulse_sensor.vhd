--Lector de señales de pulsos
library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

ENTITY pulse_sensor IS 
	port(clk, pulse: in std_logic;
	  total_count: out std_logic_vector(63 DOWNTO 0);
	  debug: out std_logic;
		timer: out std_logic_vector(63 DOWNTO 0));
	END pulse_sensor;

ARCHITECTURE arch OF pulse_sensor IS
	signal timer_count: unsigned(63 DOWNTO 0);
	signal pulse_count: unsigned(63 DOWNTO 0);
	
	BEGIN
	
	PROCESS(clk,pulse)IS
	BEGIN
	IF (rising_edge(clk)) THEN
		IF(timer_count < 100) THEN
		 timer_count <= timer_count + 1;
		 timer <= std_logic_vector(timer_count);
		 debug <= '0';
		ELSE 
		 timer_count <= (others => '0');
		 total_count <= std_logic_vector(pulse_count);
		 debug <= '1';
		END IF;
		END IF;
		
	IF (rising_edge(pulse)) THEN
		 pulse_count <= pulse_count+1;	 
		 END IF;
	END IF;
	END PROCESS;
	
END arch;
		 
--10000000000000000000000000001001
--00000000000000000000000000001011
--U0000000000000000000000000000001
		