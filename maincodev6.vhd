----------------------------------------------------------------------------------
-- Company: kntoosi
-- Create Date: 2/6/93
-- Design Name: 
-- Module Name:    maincodev6 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.STD_LOGIC_arith.ALL;


entity maincodev6 is
port( led: out std_logic_vector(3 downto 0);
      clk: in std_logic
     );


end maincodev6;

architecture Behavioral of maincodev6 is
signal led_s :std_logic_vector(3 downto 0):="0000"; 
begin
		process(clk)
		begin
			if rising_edge(Clk) then
			led_s <= led_s + "0001" ;
			end if;
		end process;
led <= led_s;
end Behavioral;

