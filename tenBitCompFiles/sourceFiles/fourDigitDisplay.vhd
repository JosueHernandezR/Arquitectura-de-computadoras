----------------------------------------------------------------------------------
-- Engineer: Ezzeddeen Gazali and Tyler Starr
-- Create Date: 11/27/2016 11:44:56 PM 
-- Description: This module displays a number on the 7 segment display.
--              refer to the Basys 3 board manual for questions to determine
--              which cathodes and anodes to activate to illuminate the display.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fourDigitDisplay is Port( number     : in STD_LOGIC_VECTOR (15 downto 0); --the number to be displayed on the 7 seg. display
                                 anode  : out STD_LOGIC_VECTOR(3 downto 0);      --which digit place to illuminate
                                 cathode     : out STD_LOGIC_VECTOR(7 downto 0); --which digit to display
                                 error      : in STD_LOGIC;                      --display's "Err" when there is an error
                                 clk        : in STD_LOGIC);                     --clk signal
end fourDigitDisplay;

architecture Behavioral of fourDigitDisplay is

component decoder port (inputNumber : in STD_LOGIC_VECTOR(3 downto 0);
                         cathode : out STD_LOGIC_VECTOR(7 downto 0));
end component;
component fourDigitDriver Port ( number     : in STD_LOGIC_VECTOR (15 downto 0);
                                 anode        : out STD_LOGIC_VECTOR (3 downto 0);
                                 digit      : out STD_LOGIC_VECTOR (3 downto 0);
                                 RST, inClk : in STD_LOGIC);
end component;
    signal sDigit : STD_LOGIC_VECTOR(3 downto 0);
    signal sNum : STD_LOGIC_VECTOR(15 downto 0);
    
    begin
        -- Outputs err if the error flag is active. 
        process (error) begin
            if (error = '1') then
                sNum <= "1111111011011101";
            else
                sNum <= number;    
            end if;
        end process;
        
        driver : fourDigitDriver port map(number => sNum, anode => anode, digit => sDigit, inClk => clk, RST => '0');
        decode : decoder port map(inputNumber => sDigit, cathode => cathode);

end Behavioral;
