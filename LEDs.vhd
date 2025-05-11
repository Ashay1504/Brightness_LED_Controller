library IEEE;
library LPM;

use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
use LPM.LPM_COMPONENTS.ALL;
use IEEE.NUMERIC_STD.ALL;

ENTITY LEDs IS
PORT(
	-- inputs
	CLK				: IN std_logic; -- need to get clock for pwm
	CS					: IN std_logic; -- chip select
	WRITE_EN			: IN std_logic; -- write
	RESETN			: IN std_logic; -- reset
	IO_DATA			: IN std_logic_vector(15 downto 0);
	pwm_signal		: IN std_logic;
	-- outputs
	LEDs				: OUT std_logic_vector(9 downto 0) -- 10 LEDs total
	);
END LEDs;

architecture a of LEDs is
	SIGNAL LEDs_Enabled : std_logic_vector(9 downto 0) := (others => '0');
begin
	process(clk, resetn)
	begin
		if RESETN = '0' then
			LEDs <= "0000000000";
		elsif rising_edge(CLK) then
			if CS = '1' and WRITE_EN = '1' then
				-- operating here
				LEDs_Enabled <= IO_DATA(9 downto 0); -- get LEDs that are enabled
			end if;
		end if;
		
	LEDs(9) <= LEDs_Enabled(9) and pwm_signal;
	LEDs(8) <= LEDs_Enabled(8) and pwm_signal;
	LEDs(7) <= LEDs_Enabled(7) and pwm_signal;
	LEDs(6) <= LEDs_Enabled(6) and pwm_signal;
	LEDs(5) <= LEDs_Enabled(5) and pwm_signal;
	LEDs(4) <= LEDs_Enabled(4) and pwm_signal;
	LEDs(3) <= LEDs_Enabled(3) and pwm_signal;
	LEDs(2) <= LEDs_Enabled(2) and pwm_signal;
	LEDs(1) <= LEDs_Enabled(1) and pwm_signal;
	LEDs(0) <= LEDs_Enabled(0) and pwm_signal;
	
	end process;
end a;
