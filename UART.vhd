library ieee;
use ieee.std_logic_1164.all;

entity UART is
port( tx_en, rst, clk: in std_logic;
tx_data: in std_logic_vector(7 DOWNTO 0);
tx,tx_rdy: out std_logic);
end UART;

architecture FSM of UART is
type state_type is(S0,S1,S2,S3);
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
				if(tx_en = '1') then
					State <= S1;
				end if;
				
			when S1 =>
				if(tx_en = '1') then
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
				if(tx_en = '1') then
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
				tx <= '1';
				tx_rdy <= '1';
			
			when S1 =>
				tx <= '0';
				tx_rdy <= '0';
			
			when S2 =>
				tx <= tx_data(Bit_count);
				tx_rdy <= '0';
			
			when S3 =>
				tx <= '1';
				tx_rdy <='0';
			
			end case;
end process;
end FSM;



	


