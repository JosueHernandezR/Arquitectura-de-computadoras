----------------------------------------------------------------------------------
-- Engineer: Ezzeddeen Gazali and Tyler Starr
-- Create Date: 11/08/2016 10:24:36 AM
-- Description: A VHDL module that behaves as a RAM for the 10-bit computer.
--              The RAM allows for program and data storage in memory before a 
--              program run. Once the program is running, the RAM recieves an 
--              address from the MAR and outputs the data at that address onto the
--              bus.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ramModule is
    Port ( inputData        : in STD_LOGIC_VECTOR (9 downto 0); --data stored in RAM
           inputAddress     : in STD_LOGIC_VECTOR (4 downto 0); --location where data is stored
           program, Clk, move, readWrite, notCE : in STD_LOGIC; --control bits
           outputDataToBus  : out STD_LOGIC_VECTOR (9 downto 0) := "ZZZZZZZZZZ"; --output to bus
           outputData       : out STD_LOGIC_VECTOR (9 downto 0); --output data to instruction Register
           outputAddress    : out STD_LOGIC_VECTOR(4 downto 0)); --output address to instruction Register
end ramModule;

architecture Behavioral of ramModule is
    type Memory_Array is array (31 downto 0) of STD_LOGIC_VECTOR (10 - 1 downto 0);
    signal Memory : Memory_Array;
    signal soutput : STD_LOGIC_VECTOR(9 downto 0);
    
    begin              
        process (Clk, program, move) begin
            if (Clk'event AND Clk = '0') then
                if (readWrite = '0') then
                    outputData <= Memory(to_integer(unsigned(inputAddress)));
                    outputAddress <= inputAddress;
                    if (program = '1' or move = '1') then
                         Memory(to_integer(unsigned(inputAddress))) <= inputData;
                    end if;
                end if;    
            end if;
        end process;
        
        process (notCE) begin
            if (notCE = '0' and readWrite = '1') then
                outputDataToBus <= Memory(to_integer(unsigned(inputAddress)));
            else
                outputDataToBus <= "ZZZZZZZZZZ";
            end if;
        end process;
end Behavioral;
