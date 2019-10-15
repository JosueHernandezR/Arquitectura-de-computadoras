----------------------------------------------------------------------------------
-- Engineer: Ezzeddeen Gazali and Tyler Starr
-- Create Date: 11/15/2016 10:33:02 AM
-- Description: The control ROM contains the micro-instructions for the 10-bit computer.
--              The con ROM recieves the location of the desired instruction from 
--              the preCounter and outputs the control word for that instruction.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity controlROM is Port ( controlWordLocation  : in STD_LOGIC_VECTOR (4 downto 0);    --The location where the control word is
                            controlWord : out STD_LOGIC_VECTOR (19 downto 0);           --each control word activates different bits 
                                                                                        --that effect different modules in the circuit
                            NOP : out STD_LOGIC);                                       
end controlROM;

architecture Behavioral of controlROM is

signal sControlWord : STD_LOGIC_VECTOR(19 downto 0);

begin
    process (controlWordLocation ) begin
        case (controlWordLocation ) is
            when "00000" => sControlWord <= "01110000010111100011"; --Fetch
            when "00001" => sControlWord <= "01110000101111100011";
            when "00010" => sControlWord <= "01110000001001100011";
            
            when "00011" => sControlWord <= "01110000000110100011"; --LDA
            when "00100" => sControlWord <= "01110000001011000011";
            when "00101" => sControlWord <= "01110000001111100011";
            
            when "00110" => sControlWord <= "01110000000110100011"; --ADD
            when "00111" => sControlWord <= "01110000001011100001";
            when "01000" => sControlWord <= "01110000001111000111";
            
            when "01001" => sControlWord <= "01110000000110100011"; --SUB
            when "01010" => sControlWord <= "01110000001011100001";
            when "01011" => sControlWord <= "01110000001111001111";
           
            when "01100" => sControlWord <= "01110000001111110010"; --OUT
            when "01101" => sControlWord <= "01110000001111100011";
                                       
            when "01110" => sControlWord <= "01010000011111100011"; --Jmp
            when "01111" => sControlWord <= "01100000001110100011";
            when "10000" => sControlWord <= "00111111001111100011";
            
            when "10001" => sControlWord <= "01110000000110100011"; --Cmp
            when "10010" => sControlWord <= "01110000001011100001";
            when "10011" => sControlWord <= "01110000001111100011";
            
            when "10100" => sControlWord <= "01010000011111100011"; --Jeq
            when "10101" => sControlWord <= "01100000001110100011";
            when "10110" => sControlWord <= "00111001001111100011";
            
            when "10111" => sControlWord <= "01010000011111100011"; --Jls
            when "11000" => sControlWord <= "01100000001110100011";
            when "11001" => sControlWord <= "00110011001111100011";
           
            when "11010" => sControlWord <= "01010000011111100011"; --Jgr
            when "11011" => sControlWord <= "01100000001110100011";
            when "11100" => sControlWord <= "00110101001111100011";
            
            when "11101" => sControlWord <= "01110000000110100011"; --Mov
            when "11110" => sControlWord <= "11110000001111110011";
            when "11111" => sControlWord <= "01110000010111100011";
         
            when others => sControlWord <= "01110000001111100011";
        end case;
        
        if (sControlWord = "01110000001111100011") then
                    NOP <= '1';
                else
                    NOP <= '0';
                end if;
    end process;
    
    process (sControlWord) begin
        controlWord <= sControlWord;
    end process;
end Behavioral;