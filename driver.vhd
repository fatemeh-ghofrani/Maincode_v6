
	library IEEE;
	use IEEE.STD_LOGIC_1164.ALL;
	use IEEE.STD_LOGIC_unsigned.ALL;
	use IEEE.STD_LOGIC_arith.ALL;


	entity drivermotor is
	generic (n:integer range 1 to 10 := 8);
	port( clk:in std_logic;
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
	end drivermotor;

		
	architecture Behavioral of drivermotor is
   
		
      component PWM is
		generic (n:integer range 1 to 10 := 8);
   	port (
      	  CLK: in std_logic;
		     OC_IN: in std_logic_vector (n-1 downto 0);
			  OC_OUT: out std_logic
			 );
   end component;
	
	
   constant T_1MS : std_logic_vector(15 downto 0):="1100001101010000" ;
	signal PWM_S : std_logic;
	signal STATE1 : std_logic_vector(3 downto 0); 
	signal HALL_COUNT : std_logic_vector(7 downto 0);
   signal TIMER_COUNT : std_logic_vector(19 downto 0); 
   signal CLK_TIMER : std_logic;
   signal M_RPMTEMP : STD_LOGIC_VECTOR(15 DOWNTO 0):="0000000000000000";	
	begin
	
	PWM_1:PWM port map (OC_IN =>SPEED ,CLK =>CLK ,OC_OUT=>PWM_S  );
	
	
	read_sensors :process(clk,HALL1,HALL2,HALL3,DIR)
					  begin
					  STATE1 <=(DIR & HALL3 & HALL2 & HALL1) ;
					  LED <=  STATE1;
					  end process;
					  
	motor_update :process(clk)
					  begin
					  
					  case STATE1 is 
					  
					  when "0001" --(1|0x00)
													 =>  M2p<='0'; M1p<='0'; M2n<='0';	  M3n<='0';   M3p<='1'; M1n<= PWM_S;
					  when "1110" --(6|0x08)
													 =>  M2p<='0'; M1p<='0'; M2n<='0';	  M3n<='0';   M3p<='1'; M1n<= PWM_S;
					 

					  when "0010" --(2|0x00) 
													 =>  M2p<='1'; M1p<='0'; M2n<='0';	  M3n<=PWM_S; M3p<='0'; M1n<='0';
					  when "1101" --(5|0x08) 
													 =>  M2p<='1'; M1p<='0'; M2n<='0';	  M3n<=PWM_S; M3p<='0'; M1n<='0';
					  
					  
					  when "0011" --(3|0x00) 
													 =>  M2p<='1'; M1p<='0'; M2n<='0';	  M3n<='0';   M3p<='0';  M1n<=PWM_S;
					  when "1100" --(4|0x08) 
													 =>  M2p<='1'; M1p<='0'; M2n<='0';	  M3n<='0';   M3p<='0';  M1n<=PWM_S;
					  
					  
					  when "0100" --(4|0x00) 
													 =>  M2p<='0'; M1p<='1'; M2n<=PWM_S;  M3n<='0';   M3p<='0';   M1n<= '0';
					  when "1011" --(3|0x08) 
													 =>  M2p<='0'; M1p<='1'; M2n<=PWM_S;  M3n<='0';   M3p<='0';   M1n<= '0';
					  
					  
					  when "0101" --(5|0x00) 
													 =>  M2p<='0'; M1p<='0'; M2n<= PWM_S;	  M3n<='0';   M3p<='1';   M1n<='0' ;
					  when "1010" --(2|0x08) 
													 =>  M2p<='0'; M1p<='0'; M2n<= PWM_S;	  M3n<='0';   M3p<='1';   M1n<= '0';
					  
					  when "0110" --(6|0x00) 
													 =>  M2p<='0'; M1p<='1'; M2n<='0';	  M3n<=PWM_S;   M3p<='0'; M1n<= '0';
					  when "1001" --(1|0x08) 
													 =>  M2p<='0'; M1p<='1'; M2n<='0';	  M3n<=PWM_S;   M3p<='0'; M1n<= '0';
					  
					  when "0111" --(7|0x08) 
													 =>  M2p<='0'; M1p<='0'; M2n<='0';	  M3n<='0';   M3p<='0';   M1n<='0';
					  when others            => null;							 
					  end case;								 
					  end process;				  

		 

   
         	 process(hall1,hall2,hall3)
				 begin
				 IF CLK_TIMER='1' THEN
				 HALL_COUNT <= (others=>'0');
				 ELSE
				 HALL_COUNT<=HALL_COUNT+1;
				 END IF;
				 end process;
				 
				 process(clk)  
				 begin
				 TIMER_COUNT <=  TIMER_COUNT+1;	
				 if(TIMER_COUNT >= T_1MS) then
				 CLK_TIMER <='1';	
				 end if;							
				 end process;
						 
                		  
		     
				M_RPMTEMP <="1001110001" * HALL_COUNT WHEN CLK_TIMER='1' ELSE
				M_RPMTEMP;
				
				M_RPM <= M_RPMTEMP; --rpm*10  HALL_COUNT; 

            TIMER_COUNT <= (others=>'0') WHEN CLK_TIMER='1' ELSE 
				TIMER_COUNT;
				
			end Behavioral;