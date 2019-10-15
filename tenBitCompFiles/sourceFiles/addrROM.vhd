----------------------------------------------------------------------------------
-- Engineer: Ezzeddeen Gazali and Tyler Starr
-- Create Date: 11/14/2016 11:51:30 PM 
-- Description: A VHDL module for an address ROM. The address ROM contains 
--              the starting address of each op-code in the 10-bit computer. 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity addressROM is Port( opCode : in STD_LOGIC_VECTOR (4 downto 0);       --The binary number that resembles the opCode
                        opCodeStart : out STD_LOGIC_VECTOR (4 downto 0));   --The location in the control Rom where the 
end addressROM;                                                             --  micro-instruction for that opCode start.


architecture Behavioral of addressROM is
    begin
        process (opCode) begin
            case (opCode) is
                when "00000" => opCodeStart <= "00011";     --LDA
                when "00001" => opCodeStart <= "00110";     --ADD
                when "00010" => opCodeStart <= "01001";     --SUB
                when "00011" => opCodeStart <= "01110";     --Jmp
                when "00100" => opCodeStart <= "10001";     --Cmp
                when "00101" => opCodeStart <= "10100";     --Jeq
                when "00110" => opCodeStart <= "11010";     --Jgr 
                when "00111" => opCodeStart <= "10111";     --Jls 
                when "01000" => opCodeStart <= "11101";     --Mov
                when "01110" => opCodeStart <= "01100";     --OUT
                when others => opCodeStart <= "00000";
            end case;
        end process;
end Behavioral;
