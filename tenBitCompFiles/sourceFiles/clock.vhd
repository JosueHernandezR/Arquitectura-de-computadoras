----------------------------------------------------------------------------------
-- Engineer: Ezzeddeen Gazali and Tyler Starr
-- Create Date: 11/08/2016 11:19:58 AM
-- Description: A clock divider that allows the computer to run on a 2Hz clock
--              instead of the FPGA's internal clock. 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity clockDivider is port(inputClk  : in STD_LOGIC;                   --FPGA's internal clock
                            stop      : in STD_LOGIC_VECTOR(4 downto 0);--halt command when all 1's
                            outputClk : out STD_LOGIC);                 --the new clock signal
end clockDivider;

architecture Behavioral of clockDivider is
    signal sInputClk : STD_LOGIC := '0';
    signal sStop : STD_LOGIC := '1';
    signal count  : integer := 1;
    signal sOutputClk : STD_LOGIC;
    
    begin
        clockDivider2Hz: process(inputClk, sStop) begin
            if(inputClk'event and inputClk='1') then               
                count <=count+1;           
                if (stop(0) = '1' and stop(1) = '1' and stop(2) = '1' and stop(3) = '1' and stop(4) = '1') then
                    sStop <= '0';
                else 
                    sStop <= '1';
                end if;
            
                if(count >= 2499999) then
                    sInputClk <= not sInputClk;
                    count <=1;
                end if;
            end if;
        end process;
        
        process (sInputClk) begin
            if(sInputClk'event and sInputClk='1') then
                if (sOutputClk = '1') then
                    sOutputClk <= '0';
                else
                    sOutputClk <= '1';
                end if;
            end if;
        outputClk <= sStop and sOutputClk;
        end process;
end Behavioral;
