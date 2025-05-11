library IEEE;
library LPM;

use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
use LPM.LPM_COMPONENTS.ALL;
use IEEE.NUMERIC_STD.ALL;

ENTITY LEDController IS
PORT(
	-- inputs
	CLK			: IN std_logic; -- need to get clock for pwm
	CS			: IN std_logic; -- chip select
	WRITE_EN	: IN std_logic; -- write
	RESETN		: IN std_logic; -- reset
	IO_DATA		: IN std_logic_vector(15 downto 0);
	
	-- outputs
	LEDs		: OUT std_logic_vector(9 downto 0) -- 10 LEDs total
	);
END LEDController;
-- implement architecture of LEDController
architecture a of LEDController is
	-- signals that are grabbed from IO_DATA
	SIGNAL LED_Enable 	: std_logic_vector(9 downto 0) := (others => '0'); -- will be grabbed from IO_DATA(9 downto 0)
	SIGNAL Brightness	: std_logic_vector(5 downto 0) := (others => '0'); -- will be grabbed from IO_DATA(15 downto 10)
	-- signals for pwm generator
	SIGNAL counter			: unsigned(5 downto 0) := (others => '0'); -- 6 bit counter
	SIGNAL duty_reg		: unsigned(5 downto 0) := (others => '0'); -- Registered duty
	SIGNAL active_duty	: unsigned(5 downto 0) := (others => '0'); -- Active duty for current period
	SIGNAL pwm_signal		: std_logic := '0'; -- this is the output of pwm generation
	
begin
	process(clk, resetn)
	begin
		if RESETN = '0' then
			LED_Enable <= (others => '0');
			Brightness <= (others => '0');
			counter <= (others => '0'); -- clear counter, set all bits to 0 upon reset
			active_duty <= (others => '0'); -- clear active duty cycle
			duty_reg <= (others => '0');
			pwm_signal <= '0';
		elsif rising_edge(CLK) then
			if CS = '1' and WRITE_EN = '1' then
				-- operating here
				LED_Enable <= IO_DATA(9 downto 0); -- get LEDs that are enabled
				duty_reg <= unsigned(IO_DATA(15 downto 10));
			end if;
			
			if counter = 63 then
				counter <= (others => '0');
				active_duty <= duty_reg;
			ELSE
				counter <= counter + 1;
			end if;
			
			if counter < active_duty then
				pwm_signal <= '1';
			else
				pwm_signal <= '0';
			end if;
		end if;
	end process;
	
	LEDs(9) <= LED_Enable(9) and pwm_signal;
	LEDs(8) <= LED_Enable(8) and pwm_signal;
	LEDs(7) <= LED_Enable(7) and pwm_signal;
	LEDs(6) <= LED_Enable(6) and pwm_signal;
	LEDs(5) <= LED_Enable(5) and pwm_signal;
	LEDs(4) <= LED_Enable(4) and pwm_signal;
	LEDs(3) <= LED_Enable(3) and pwm_signal;
	LEDs(2) <= LED_Enable(2) and pwm_signal;
	LEDs(1) <= LED_Enable(1) and pwm_signal;
	LEDs(0) <= LED_Enable(0) and pwm_signal;
end a;
				
			
			
			
	