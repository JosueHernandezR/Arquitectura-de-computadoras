----------------------------------------------------------------------------------
-- Engineer: Ezzeddeen Gazali and Tyler Starr
-- Create Date: 11/15/2016 10:07:11 AM
-- Description: A MUX that switches between user input and internal addressing.
--              When in program mode, the user inputs the address. In run mode, 
--              the address is determined by the program counter.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity inputMUX is Port (address : in STD_LOGIC_VECTOR (4 downto 0);--user input
                         MAR : in STD_LOGIC_VECTOR (4 downto 0);    --internal address
                         program : in STD_LOGIC;                    --low in program mode and high in run mode
                         output : out STD_LOGIC_VECTOR (4 downto 0)); --input to the RAM
end inputMUX;

architecture Behavioral of inputMUX is
    begin
        process (program, MAR, address)is
        begin
            case (program) is
            when '0' => output <= address;
            when '1' => output <= MAR;
            when others => output <= "ZZZZZ";
            end case;
        end process;
end Behavioral;
