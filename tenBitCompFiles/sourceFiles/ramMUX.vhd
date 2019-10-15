----------------------------------------------------------------------------------
-- Engineer: Ezzeddeen Gazali and Tyler Starr
-- Create Date: 12/05/2016 10:43:58 AM 
-- Description: This MUX outputs the 10-bit input Data that is used in the RAM 
--              module. When the control bit is high, the MUX outputs the data that
--              the user entered in program mode. When the control bit is low, the 
--              MUX outputs the data on the control bus.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ramMUX is port ( userInput : in STD_LOGIC_VECTOR (9 downto 0); --input during program
                        aRegInput : in STD_LOGIC_VECTOR (9 downto 0); --input during run
                        output : out STD_LOGIC_VECTOR (9 downto 0);   --output of MUX
                        control : in STD_LOGIC);                      --select
end ramMUX;

architecture Behavioral of ramMUX is   
    begin
     process (control, userInput, aRegInput)is
       begin
           case (control) is
           when '0' => output <= userInput;
           when '1' => output <= aRegInput;
           when others => output <= userInput;
           end case;
       end process;

end Behavioral;
