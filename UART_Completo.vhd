library ieee;
use ieee.std_logic_1164.all;

entity UART_Completo is
port(clk_in, tx_en,rst: in std_logic;
	  tx_data: in std_logic_vector(7 DOWNTO 0);
	  tx_rdy,tx: out std_logic);
	  
attribute chip_pin : string;
attribute chip_pin of tx_en : signal is "A7";
attribute chip_pin of rst : signal is "B8";
attribute chip_pin of clk_in : signal is "N14";
attribute chip_pin of tx : signal is "W10";
attribute chip_pin of tx_rdy : signal is "A8";
attribute chip_pin of tx_data : signal is "A14, A13, B12, A12, C12, D12, C11, C10";

end UART_completo;

architecture UART of UART_completo is
signal clk_aux: std_logic;

COMPONENT div_generic
			 generic(divisor : integer := 5208);
			 PORT (clk_in: in std_logic;
					 reset: in std_logic;
					 clk_out: out std_logic);
END COMPONENT;

COMPONENT UART
			 port( tx_en, rst, clk: in std_logic;
			 tx_data: in std_logic_vector(7 DOWNTO 0);
			 tx,tx_rdy: out std_logic);
END COMPONENT;

begin
		
		DIV: div_generic PORT MAP( clk_in => clk_in, reset=>rst, clk_out=>clk_aux);
		FUN: UART PORT MAP(tx_en => tx_en, rst => rst, clk => clk_aux, tx_data => tx_data, tx => tx, tx_rdy => tx_rdy);

END UART;