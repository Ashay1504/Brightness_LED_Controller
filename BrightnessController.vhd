library IEEE;
library LPM;

use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
use LPM.LPM_COMPONENTS.ALL;
use IEEE.NUMERIC_STD.ALL;

ENTITY BrightnessController IS
PORT(
	-- inputs
	CLK			: IN std_logic; -- need to get clock for pwm
	CS				: IN std_logic; -- chip select
	WRITE_EN		: IN std_logic; -- write
	RESETN		: IN std_logic; -- reset
	IO_DATA		: IN std_logic_vector(15 downto 0);
	
	-- outputs
	pwm_signal	: OUT std_logic
	);
END BrightnessController;
-- implement architecture of BrightnessController
architecture br_c of BrightnessController is
	-- signals for pwm generator
	SIGNAL counter			: unsigned(7 downto 0) := (others => '0'); -- 6 bit counter
	SIGNAL duty_reg		: unsigned(7 downto 0) := (others => '0'); -- Registered duty
	SIGNAL active_duty	: unsigned(7 downto 0) := (others => '0'); -- Active duty for current period	
begin
	process(clk, resetn)
	begin
		if RESETN = '0' then
			counter <= (others => '0'); -- clear counter, set all bits to 0 upon reset
			active_duty <= (others => '0'); -- clear active duty cycle
			duty_reg <= (others => '1'); -- upon reset - would be nice for the peripheral to be at full brightness
			pwm_signal <= '0';
		elsif rising_edge(CLK) then
			if CS = '1' and WRITE_EN = '1' then
				-- operating here
				duty_reg <= unsigned(IO_DATA(7 downto 0));
			end if;
			if counter = 255 then
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
end br_c;
				
			
			
	