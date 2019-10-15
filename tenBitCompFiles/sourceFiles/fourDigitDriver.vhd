----------------------------------------------------------------------------------
-- Engineer: Ezzeddeen Gazali and Tyler Starr
-- Create Date: 11/27/2016 11:26:56 PM
-- Description: This VHDL module that drives the decoder output to the output
--              the binary coded decimal (BCD) number to the 7 segment display.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity fourDigitDriver is Port( number : in STD_LOGIC_VECTOR (15 downto 0);
                                anode : out STD_LOGIC_VECTOR (3 downto 0);
                                digit : out STD_LOGIC_VECTOR (3 downto 0);
                                RST, inClk : in STD_LOGIC);
end fourDigitDriver;

architecture Behavioral of fourDigitDriver is
    signal clk : STD_LOGIC;
    
    begin
    -- A clock divider which allows each digit refresh at 60Hz. This allows for
    -- multiple digits to show on the 7 segment display at once.
    clock : process (inClk, RST)
    variable count : std_logic_vector(29 downto 0) := (others => '0');
    begin
        if (RST = '1') then 
            clk <= '0';
            count := (others => '0');    
        else
            if (rising_edge(inClk)) then
                -- Once the count is where the internal clock (inClk) equals 60 Hz, 
                -- invert the clock and reset count. If not, increment count by 1.
                if (count >= (std_logic_vector(to_unsigned(104166, 29)))) then
                    clk  <= NOT(clk);
                    count := (others => '0');
                else
                    count := count + 1;
                end if;
            end if;
        end if;
    end process clock; 
    
    -- This process uses the 60 Hz clock obtained from above to refresh and cycle through 
    -- each digit place on the 7 segment display individually.
    process (clk)
    variable digitPlace : std_logic_vector(3 downto 0) := "0000"; --digit place on the display
    begin
    --NOTE: The anodes on the 7 segment display are active low.
        if ( rising_edge(clk)) then
            if (digitPlace = "0000") then
                digit <= number(3 downto 0);
                anode <= "1110";        -- Sets right most anode active to display digit in the ones place
                digitPlace := digitPlace + "0001";
            elsif (digitPlace = "0001") then
                digit <= number(7 downto 4);
                anode <= "1101";        -- Sets second anode active to display digit in the tens place
                digitPlace := digitPlace + "0001";
            elsif (digitPlace = "0010") then
                digit <= number(11 downto 8);
                anode <= "1011";        -- Sets third anode active to display digit in the hundreds place
                digitPlace := digitPlace + "0001";
            elsif (digitPlace = "0011") then 
                digit <= number(15 downto 12);
                digitPlace := "0000";
                anode <= "1111";        -- Sets left most anode active to display digit in the thousands place
            end if;
        end if;
    end process;
end Behavioral;
