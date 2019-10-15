----------------------------------------------------------------------------------
-- Engineer: Ezzeddeen Gazali Tyler Starr
-- Create Date: 11/09/2016 09:46:25 AM
-- Description: A VHDL module for a 1-bit D Register
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity oneBitDRegister is port ( Din, Clk, ARST, outputEnable, readIn: in STD_LOGIC;
                                 Q : out STD_LOGIC := 'Z');
end oneBitDRegister;


architecture Structural of oneBitDRegister is
        signal sQ : STD_LOGIC := 'Z';

    begin
        process (Clk, outputEnable, readIn, ARST) 

        begin
            --------------------- Synchronous Reset
            if (rising_edge(Clk)) then 
                if (readIn = '0') then
                        sQ <= Din;
                    if (outputEnable = '0') then
                        Q <= Din;
                    end if;
                end if; 
            end if;
                
            if (outputEnable = '1') then
                Q <= 'Z';   
            else 
                Q <= sQ; 
            end if;           
            
            if (ARST = '1') then
                sQ <= '0';
                Q <= 'Z';   
            end if;      
        end process;
end Structural;
