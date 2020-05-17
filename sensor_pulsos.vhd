--Lector de señales de pulsos
library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

ENTITY sensor_pulsos IS 
	port(clk, pulse, rst: in std_logic;
	  total_count: out std_logic_vector(63 DOWNTO 0);
	  debug: out std_logic;
		timer: out std_logic_vector(63 DOWNTO 0));
	END sensor_pulsos;

ARCHITECTURE arch OF sensor_pulsos IS
	type state_type is(S0,S1);
	signal State : state_type;
	signal timer_count: unsigned(63 DOWNTO 0);
	signal pulse_count: unsigned(63 DOWNTO 0);
	
	BEGIN
	
	PROCESS(clk)IS
		BEGIN
		IF rising_edge(clk) then
			IF rst = '0' then
		State <= S0;
			ELSE
				case State is
			when S0 =>
					State <= S1;
			
			when S1 =>
					IF(timer_count < 300) THEN
						timer_count <= timer_count+1;
						State <= S1;
					ELSE
						total_count <= std_logic_vector(pulse_count);
						timer_count <= (others => '0');
						State <= S0;
					END IF;
			END case;		
			END IF;		
		END IF;
	END PROCESS;
	
	PROCESS(pulse,State)IS
		BEGIN
		
			case State is
				when S0 =>
					pulse_count <=  (others => '0');
					
					
				when S1 =>
					IF(rising_edge(pulse)) THEN
						pulse_count <= pulse_count+1;
					END IF;
			END case;
	END PROCESS;
END arch;
--10000000000000000000000000001001
--00000000000000000000000000001011
--U0000000000000000000000000000001
		