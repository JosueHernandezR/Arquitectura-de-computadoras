----------------------------------------------------------------------------------
-- Engineer: Ezzeddeen Gazali and Tyler Starr 
-- Create Date: 11/18/2016 10:54:21 AM
-- Description: Progam counter for the 10-bit computer. This part keeps track
--              of the memory location that the program is in. All programs start
--              at memory location 00000 and can go up to 11111, unless a halt is
--              used. In jump statements, the program counter continues to count 
--              from the address that the program is jumping to. 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity programCounter is
    Port ( Cp : in STD_LOGIC;                                       --Counts on rising clock edge when active
           Clk : in STD_LOGIC;                                      --Clock signal
           Clr : in STD_LOGIC;                                      --Clear/reset
           Ep : in STD_LOGIC;                                       --Progam Counter is enabled when active
           Sp : in STD_LOGIC;                                       --Set operation for the jump statement.
           input : in STD_LOGIC_VECTOR (4 downto 0):= "00000";      --Starts count at 0
           output : out STD_LOGIC_VECTOR (4 downto 0):= "ZZZZZ";    --Copy of count for use on LED's 0-15
           count : out STD_LOGIC_VECTOR (4 downto 0):= "ZZZZZ");    --Count output

end programCounter;

architecture Behavioral of programCounter is
    component JKFlipFlop Port ( JK : in STD_LOGIC_VECTOR(1 downto 0);
                                Clk : in STD_LOGIC;
                                ARST : in STD_LOGIC;
                                setInput : in STD_LOGIC;
                                set : in STD_LOGIC;
                                Q : out STD_LOGIC);
    end component;
    
    component triStateBuffer Port ( Din : in STD_LOGIC_VECTOR (4 downto 0);
                                    Ep : in STD_LOGIC;
                                    Dout : out STD_LOGIC_VECTOR (4 downto 0));
    end component;
    

    signal sClk, sClk1, sClk2, sClk3, sClk4 : STD_LOGIC;                            --Clock signals
    signal outputBit0, outputBit1, outputBit2, outputBit3, outputBit4 : STD_LOGIC;  --Output signals
    signal sOutput : STD_LOGIC_VECTOR(4 downto 0);
    
    begin
        sClk <= Clk;
        sClk1 <= not outputBit0;
        sClk2 <= not outputBit1;
        sClk3 <= not outputBit2;
        sClk4 <= not outputBit3;
        
        flipflop  : JKFlipFlop port map(JK(0) => Cp, JK(1) => Cp, Clk => sClk,  ARST => Clr, setInput => input(0), set => Sp, Q => outputBit0);
        flipflop1 : JKFlipFlop port map(JK(0) => Cp, JK(1) => Cp, Clk => sClk1, ARST => Clr, setInput => input(1), set => Sp, Q => outputBit1);
        flipflop2 : JKFlipFlop port map(JK(0) => Cp, JK(1) => Cp, Clk => sClk2, ARST => Clr, setInput => input(2), set => Sp, Q => outputBit2);
        flipflop3 : JKFlipFlop port map(JK(0) => Cp, JK(1) => Cp, Clk => sClk3, ARST => Clr, setInput => input(3), set => Sp, Q => outputBit3);
        flipflop4 : JKFlipFlop port map(JK(0) => Cp, JK(1) => Cp, Clk => sClk4, ARST => Clr, setInput => input(4), set => Sp, Q => outputBit4);
        
        sOutput <= outputBit4 & outputBit3 & outputBit2 & outputBit1 & outputBit0;
        count <= sOutput;
        
        buffer1 : triStateBuffer port map(Din => sOutput, Ep => Ep, Dout => output);

    end Behavioral;
