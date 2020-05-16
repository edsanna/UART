--UART lectura
library ieee;
use ieee.std_logic_1164.all;

entity UART_Lectura is
port( read_en, rst, clk: in std_logic;
tx_rdy:  out std_logic;
tx_data: out std_logic_vector(7 DOWNTO 0);
tx: in std_logic);
end UART_Lectura;

architecture FSM of UART_Lectura is
type state_type is(S0,S1,S2,S3,S4);
signal State, NextState : state_type;
signal Bit_count: natural range 0 to 8;


begin

process(clk) is
begin
if rising_edge(clk) then
	if rst = '0' then
		State <= S0;
	else
		case State is
			when S0 =>
				if(read_en = '1') then
					State <= S1;
				end if;
				
			when S1 =>
				if(tx = '0') then
					State <= S2;
					Bit_count <= 0;
				end if;
			
			when S2 =>
				if(Bit_count < 7) then
					State <= S2;
					Bit_count <= Bit_count + 1;
				else
					State <= S3;
				end if;
			
			when S3 => 
				if(tx = '1') then
					State <= S4;
				end if;
			when S4 =>
				if(tx = '1') then
					State <= S0;
				end if;
			
			end case;
		end if;
	end if;
end process;

process(State)is

begin
		case State is
			when S0 =>
				tx_rdy <= '1';
			
			when S1 =>
				tx_rdy <= '0';
			
			when S2 =>
				tx_data(Bit_count) <= tx;
				tx_rdy <= '0';
			
			when S3 =>
				tx_rdy <='0';
				
			when S4 =>
				tx_rdy <='0';
			
			
			end case;
end process;
end FSM;
