----------------------------------------------------------------------------------
-- Engineer: Ezzeddeen Gazali and Tyler Starr
-- Create Date: 11/15/2016 10:56:31 AM
-- Description: Each op-code has 3 micro-instructions. The counter increments by 1 
--              starting at 0 for the first 3 cycles (fetch cycle). The precounter is
--              then triggered by the ring counter to load the address where the 3 
--              micro-instructions for that op-code are. The counter continues to 
--              increment by 1 for the remaining 3 cycles. Basically what it does is 
--              control the sequence of micro-instructions to carry out. 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity preCounter is Port ( Clr : in STD_LOGIC;     --sets counter to 0 when high.
                            T1 : in STD_LOGIC;      --when high, the counter is reset to 0
                            T3 : in STD_LOGIC;      --when high, the counter loads opCodeStart
                            Clk : in STD_LOGIC;     --increments counter by 1 on falling edge
                            opCodeStart : in STD_LOGIC_VECTOR (4 downto 0);             --The memory location of the instruction to be carried out
                            controlWordLocation : out STD_LOGIC_VECTOR (4 downto 0));   --The memory location of the control word to be executed
end preCounter;

architecture Behavioral of preCounter is
    signal sClr : STD_LOGIC;

    begin
        sClr <= T1 or Clr;
        
        process (Clk, Clr) 
        variable num : STD_LOGIC_VECTOR(4 downto 0) := "00000";
        begin
            if (falling_edge(Clk)) then
                num := num + "00001";
                
                if (sClr = '1') then
                    num := "00001";
                end if;
                
                if (T3 = '1') then
                    num := opCodeStart + 1;
                end if;
 
                controlWordLocation <= num-1;
            end if;
        end process;
end Behavioral;
