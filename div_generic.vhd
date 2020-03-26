library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



ENTITY div_generic IS
	generic(divisor : integer := 5208);
	PORT (clk_in: in std_logic;
			reset: in std_logic;
			clk_out: out std_logic);
	END div_generic;

ARCHITECTURE structure OF div_generic IS
	signal count : integer range 0 to (divisor/2)-1;
	signal estado : std_logic :='0';
	BEGIN

	PROCESS(clk_in, reset)
		
	BEGIN
			IF(reset = '0') THEN
				count <= 0;
				estado <= '0';
				ELSE
				IF (clk_in'EVENT AND clk_in='1') THEN
					IF count < (divisor/2)-1 THEN count <= count + 1;
					elsif estado = '0' THEN estado<='1'; count <= 0;
					else 	estado <='0';	count <= 0;
				
					END IF;
				END IF;
			END IF;
	END PROCESS;
			clk_out <= estado;
END structure;