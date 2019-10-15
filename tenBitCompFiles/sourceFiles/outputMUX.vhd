----------------------------------------------------------------------------------
-- Engineer: Ezzeddeen Gazali and Tyler Starr
-- Create Date: 12/02/2016 11:50:00 AM
-- Description: Depending on the mode that the computer is in (program or run),
--              the MUX will turn on different led's.
--              In program mode, the MUX turns on the led's to resemble the memory
--              location that the computer is in and what it contains. In run mode
--              the MUX ouputs the control word.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity outputMUX is Port ( progModeInput : in STD_LOGIC_VECTOR (15 downto 0);   --led's to turn on in program mode
                           runModeInput  : in STD_LOGIC_VECTOR (15 downto 0);   --led's to turn on in run mode
                           ledOutput     : out STD_LOGIC_VECTOR (15 downto 0);  --output of the MUX
                           modeSelect    : in STD_LOGIC);                       --select
end outputMUX;

architecture Behavioral of outputMUX is
    begin
     process (modeSelect, progModeInput, runModeInput)is
       begin
           case (modeSelect) is
               when '0' => ledOutput <= progModeInput;
               when '1' => ledOutput <= runModeInput;
               when others => ledOutput <= "0000000000000000";
               end case;
       end process;
end Behavioral;
