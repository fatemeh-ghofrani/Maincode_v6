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
generic (n:integer range 1 to 10 := 8);
  port(  clk:in std_logic;
		--MOTOR1
    		HALL11:in std_logic;
			HALL21:in std_logic;
			HALL31:in std_logic;
			
			M1p1:out std_logic;
			M1n1:out std_logic;
			M2p1:out std_logic;
			M2n1:out std_logic;
			M3p1:out std_logic;
			M3n1:out std_logic;
			
		
		--MOTOR2	
			HALL12:in std_logic;
			HALL22:in std_logic;
			HALL32:in std_logic;
			
			M1p2:out std_logic;
			M1n2:out std_logic;
			M2p2:out std_logic;
			M2n2:out std_logic;
			M3p2:out std_logic;
			M3n2:out std_logic;
			
	
   	--MOTOR3	
			HALL13:in std_logic;
			HALL23:in std_logic;
			HALL33:in std_logic;
		
		   M1p3:out std_logic;
			M1n3:out std_logic;
			M2p3:out std_logic;
			M2n3:out std_logic;
			M3p3:out std_logic;
			M3n3:out std_logic;
		
		
		--MOTOR4	
			HALL14:in std_logic;
			HALL24:in std_logic;
			HALL34:in std_logic;
			
			M1p4:out std_logic;
			M1n4:out std_logic;
			M2p4:out std_logic;
			M2n4:out std_logic;
			M3p4:out std_logic;
			M3n4:out std_logic;
		
       --M1 SPEED
			M_RPM:out std_logic_vector(15 downto 0);
       --FT245  	
         DATA_USB	 :	out std_logic_vector(7 downto 0);
			USB_WR 	 : out std_logic;	
         TXE		 : in  std_logic;			
       --LED
			LED:out std_logic_vector(3 downto 0)
			
			 );
end maincodev6;

  architecture Behavioral of maincodev6 is

   component drivermotor is
		port( 
		   CLK:in std_logic;
			HALL1:in std_logic;
			HALL2:in std_logic;
			HALL3:in std_logic;
			M1p:out std_logic;
			M1n:out std_logic;
			M2p:out std_logic;
			M2n:out std_logic;
			M3p:out std_logic;
			M3n:out std_logic;
			SPEED:in std_logic_vector(n-1 downto 0);
			DIR:in std_logic;
			M_RPM:out std_logic_vector(15 downto 0);
			LED:out std_logic_vector(3 downto 0)
			 );
	
	end component;
	
	component  Write_to_USB is
		port (
		      DATA_IN   : in std_logic_vector(15 downto 0);
				DATA_USB	 :	out std_logic_vector(7 downto 0);
				USB_WR 	 : out std_logic;
				TXE		 : in  std_logic;
				CLK_USB   :	in std_logic
				);
	 end component;
	
	signal DIR1_S   : std_logic:='0'; 
   signal SPEED1 : std_logic_vector(n-1 downto 0):="1111111111"; 
	signal DIR2_S   : std_logic:='0'; 
   signal SPEED2 : std_logic_vector(n-1 downto 0):="1111111111"; 
	signal DIR3_S   : std_logic:='0'; 
   signal SPEED3 : std_logic_vector(n-1 downto 0):="1111111111"; 
	signal DIR4_S   : std_logic:='0'; 
   signal SPEED4 : std_logic_vector(n-1 downto 0):="1111111111"; 
   
	signal M1_RPM : std_logic_vector(15 downto 0):="0000000000000000"; 
	signal M2_RPM : std_logic_vector(15 downto 0):="0000000000000000"; 
	signal M3_RPM : std_logic_vector(15 downto 0):="0000000000000000"; 
   signal M4_RPM : std_logic_vector(15 downto 0):="0000000000000000";
	
begin
--M1		
   driver1:drivermotor port map(HALL1=>HALL11,HALL2=>HALL21,HALL3=>HALL31,CLK=>CLK,
	M1P=>M1P1,M1N=>M1N1,M2P=>M2P1,M2N=>M2N1,M3P=>M3P1,M3N=>M3N1,SPEED=>SPEED1,DIR=>DIR1_S,LED=>LED,M_RPM=>M1_RPM );
--M2	
	driver2:drivermotor port map(HALL1=>HALL12,HALL2=>HALL22,HALL3=>HALL32,CLK=>CLK,
	M1P=>M1P2,M1N=>M1N2,M2P=>M2P2,M2N=>M2N2,M3P=>M3P2,M3N=>M3N2,SPEED=>SPEED2,DIR=>DIR2_S);	
--M3	
	driver3:drivermotor port map(HALL1=>HALL13,HALL2=>HALL23,HALL3=>HALL33,CLK=>CLK,
	M1P=>M1P3,M1N=>M1N3,M2P=>M2P3,M2N=>M2N3,M3P=>M3P3,M3N=>M3N3,SPEED=>SPEED3,DIR=>DIR3_S);
--M4	
   driver4:drivermotor port map(HALL1=>HALL14,HALL2=>HALL24,HALL3=>HALL34,CLK=>CLK,
	M1P=>M1P4,M1N=>M1N4,M2P=>M2P4,M2N=>M2N4,M3P=>M3P4,M3N=>M3N4,SPEED=>SPEED4,DIR=>DIR4_S);
--FT245
  FT245:Write_to_USB port map(DATA_IN =>M1_RPM , DATA_USB=>DATA_USB,USB_WR=>USB_WR,TXE=>TXE,CLK_USB=>CLK);		 
				   
	
	
end Behavioral;

