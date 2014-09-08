--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:14:26 08/29/2014
-- Design Name:   
-- Module Name:   D:/maincodev6/test_1.vhd
-- Project Name:  maincodev6
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: maincodev6
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test_1 IS
END test_1;
 
ARCHITECTURE behavior OF test_1 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT maincodev6
    PORT(
         led : OUT  std_logic_vector(3 downto 0);
         clk : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';

 	--Outputs
   signal led : std_logic_vector(3 downto 0);

   -- Clock period definitions
   --constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: maincodev6 PORT MAP (
          led => led,
          clk => clk
        );

  clk <= not clk after 10 ns;
  

END;
