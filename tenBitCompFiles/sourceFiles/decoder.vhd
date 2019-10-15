----------------------------------------------------------------------------------
-- Engineer: Ezzeddeen Gazali and Tyler Starr
-- Create Date: 11/14/2016 12:22:46 PM
-- Description: Based on the input number, certain cathodes are activated to allow
--              the 7 segment display to display the desired number.j
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decoder is
    Port (inputNumber       : in STD_LOGIC_VECTOR(3 downto 0);
          cathode : out STD_LOGIC_VECTOR(7 downto 0));
end decoder;

architecture Behavioral of decoder is
-----------------------------------
    begin
        process (inputNumber) is begin
            case (inputNumber) is 
                when "0000" => cathode <= not "00111111";
                when "0001" => cathode <= not "00000110";
                when "0010" => cathode <= not "01011011";
                when "0011" => cathode <= not "01001111";
                when "0100" => cathode <= not "01100110";
                when "0101" => cathode <= not "01101101";
                when "0110" => cathode <= not "01111101";
                when "0111" => cathode <= not "00000111";
                when "1000" => cathode <= not "01111111";
                when "1001" => cathode <= not "01100111";
                when "1010" => cathode <= not "01110111";
                when "1011" => cathode <= not "01111100";
                when "1100" => cathode <= not "00111001";
                when "1101" => cathode <= not "01010000";
                when "1110" => cathode <= not "01111001";
                when "1111" => cathode <= not "00000000";
                when others => cathode <= not "00000000";
            end case;
         end process;
end Behavioral;
