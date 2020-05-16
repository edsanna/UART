library ieee;
use ieee.std_logic_1164.all;

entity UART_Completo is
port(clk_in, tx_en,rst,read_en: in std_logic;
	  tx_data: in std_logic_vector(7 DOWNTO 0);
	  tx_data_read : out std_logic_vector(7 DOWNTO 0);
	  tx_read: in std_logic;
	  tx_rdy,tx, debug: out std_logic);
	  
attribute chip_pin : string;
attribute chip_pin of tx_en : signal is "A7";
attribute chip_pin of rst : signal is "B8";
attribute chip_pin of clk_in : signal is "N14";
attribute chip_pin of tx : signal is "W10";
attribute chip_pin of tx_read : signal is "W9";
attribute chip_pin of tx_rdy : signal is "A8";
attribute chip_pin of tx_data_read : signal is "A11, D14, E14, C13, D13, B10, A10, A9";
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

COMPONENT UART_Lectura
			 port( read_en, rst, clk: in std_logic;
			 tx_data : out std_logic_vector(7 DOWNTO 0);
			 tx_rdy: out std_logic;
			 tx: in std_logic);
END COMPONENT;

begin
		
		DIV: 	div_generic   PORT MAP( clk_in => clk_in, reset=>rst, clk_out=>clk_aux);
		LECT: UART_Lectura  PORT MAP( read_en => '1', rst => rst, clk => clk_aux, tx_data => tx_data_read, tx => tx_read, tx_rdy => tx_rdy); 
		FUN: UART PORT MAP(tx_en => tx_en, rst => rst, clk => clk_aux, tx_data => tx_data, tx => tx); --tx_rdy => tx_rdy);
		

END UART;