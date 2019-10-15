---------------------------------------------------------------------------------- 
-- Engineer: Ezzeddeen Gazali and Tyler Starr
-- Create Date: 11/08/2016 10:07:29 AM
-- Description: This module behaves as a tri-state buffer. When the control bit
--              Ep is active, the buffer outputs the input. When the control bit
--              not active, the buffer doesn't output anything.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity triStateBuffer is port ( Din : in STD_LOGIC_VECTOR (4 downto 0);
                                Ep : in STD_LOGIC;
                                Dout : out STD_LOGIC_VECTOR (4 downto 0));
end triStateBuffer;

architecture Behavioral of triStateBuffer is
    begin
        process (Din, Ep) begin
            if (Ep = '0') then
                Dout <= "ZZZZZ";
            else
                Dout <= Din;
            end if;
        end process;
end Behavioral;
