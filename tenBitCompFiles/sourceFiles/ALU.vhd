----------------------------------------------------------------------------------
-- Engineer: Ezzeddeen Gazali and Tyler Starr
-- Create Date: 11/21/2016 10:36:00 PM
-- Description: The ALU contains the logic for the arithmetic and logic operations.
----------------------------------------------------------------------------------
library ieee;  
use ieee.std_logic_1164.all;  
use ieee.std_logic_unsigned.all; 
use IEEE.NUMERIC_STD.ALL;

entity ALU is port( A : in STD_LOGIC_VECTOR (9 downto 0);           --input A
                    B : in STD_LOGIC_VECTOR (9 downto 0);           --input B
                    result : out STD_LOGIC_VECTOR (9 downto 0);     --result of the addition/subtraction
                    error : out STD_LOGIC;                          --error indicates over/undeflow
                    greaterThan, equalTo, lessThan : out STD_LOGIC; --depending on which bit is high, these bits indicate 
                                                                    --that A>B, A<B, or A=B                                                          
                    subtract : in STD_LOGIC);                       --when high, a subtraction occurs
end ALU;

architecture Behavioral of ALU is
    begin
        process (A, B, subtract) 
        variable sResult : integer := 0;
        begin
            --Logic for ADD and SUB
            if (sub = '0') then
                sResult := to_integer(unsigned(A)) + to_integer(unsigned(B));
            else
                sResult := to_integer(unsigned(A)) - to_integer(unsigned(B));
            end if;
            
            --Logic for conditional jumps
            if (A = B) then
                equalTo <= '1';
                greaterThan <= '0';
                lessThan <= '0';
            elsif (A > B) then
                equalTo <= '0';
                greaterThan <= '1';
                lessThan <= '0';
            elsif (A < B) then
                equalTo <= '0';
                greaterThan <= '0';
                lessThan <= '1';
            end if;
            
            --Check if there is an overflow or underflow
            if (sResult > 999 or sResult < 0) then
                error <= '1';
            else
                error <= '0';
            end if;
            
            result <= std_logic_vector(to_unsigned(sResult, 10));       
        end process;
    

end Behavioral;
