----------------------------------------------------------------------------------
-- Engineer: Ezzeddeen Gazali and Tyler Starr 
-- Create Date: 11/14/2016 12:41:10 PM
-- Description: Each op-code runs for 6 cycles and has 6 micro-instructions, the 
--              ring counter increments by a power of 2 after each cycle, then resets
--              after it reaches the 6th state or cycle. the instructions are fetched
--              and executed during these 6 states of the ring counter.               
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity ringCounter is port( reset, NOP : in STD_LOGIC;                  --reset returns the counter back to '100000'
                            Clk : in STD_LOGIC;                         --on the falling edge, the counter is incremented
                            Count : out STD_LOGIC_VECTOR (5 downto 0)); --the state that the ring counter is in
end ringCounter;

architecture Behavioral of ringCounter is
begin
    process (Clk) is
    variable tmpCount : integer := 0;
    begin
        if (falling_edge(Clk)) then
            if (reset = '1' or NOP = '1') then
                tmpCount := 5;
            end if;   
            
            case (tmpCount) is
                when (0) => Count <= "100000";
                when (1) => Count <= "010000";
                when (2) => Count <= "001000";
                when (3) => Count <= "000100";
                when (4) => Count <= "000010";
                when (5) => Count <= "000001";
                when others => Count <= "000000";
             end case;
             
             tmpCount := tmpCount + 1;
             
             if (tmpCount = 6) then
                tmpCount := 0;
             end if;
 
        end if;
    end process;
end Behavioral;
