library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity Write_to_USB is
port (
         DATA_IN   : in std_logic_vector(15 downto 0);
         DATA_USB	 :	out std_logic_vector(7 downto 0);
			USB_WR 	 : out std_logic;
			TXE		 : in  std_logic;
			CLK_USB   :	in std_logic
			);
end Write_to_USB;

architecture Behavioral of Write_to_USB is

signal data1 : std_logic_vector(15 downto 0);
signal cnt1	:	std_logic_vector(2  downto 0):=(others=>'0');
signal cnt	:	std_logic_vector(13  downto 0):=(others=>'0');
begin
   data1 <= "1111111001110010";--01010101";--01010101--11111111--00000000
	process(clk_USB)	---USB CONTROLLER DRIVER
	begin
   data1 <= DATA_IN;
   if rising_edge(clk_USB) then
		  cnt<=cnt+'1';
		  if cnt="10011100010000" then
		     cnt<="00000000000000";
				if txe='0' then
					if cnt1="000" then
						usb_wr <= '1';
						data_usb <= data1(7 downto 0);
						cnt1 <= cnt1+"001";
					elsif cnt1="001" then
						usb_wr <= '0';
						cnt1 <= cnt1 + "001";
					elsif cnt1 = "010" then
						usb_wr <= '1';
						data_usb <= data1(15 downto 8);
						cnt1 <= cnt1+"001";
					elsif cnt1="011" then
						usb_wr <= '0';
						cnt1 <= cnt1+"001";
					elsif cnt1="100" then
						usb_wr <= '1';
						data_usb <= "01011010";--5A
						cnt1 <= cnt1+"001";
					else
					   usb_wr <= '0';
						cnt1 <= "000";
					end if;
				end if;
		  end if;
		end if;
end process;
end Behavioral;

