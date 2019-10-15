----------------------------------------------------------------------------------
-- Engineer: Ezzeddeen Gazali and Tyler Starr
-- Create Date: 11/09/2016 12:01:12 PM
-- Description: A VHDL module for a 5-bit D Register
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fiveBitDRegister is Port ( Dbus : in STD_LOGIC_VECTOR (4 downto 0);
                                 Clk, ARST, outputEnable, readIn : in STD_LOGIC;
                                 Qbus : out STD_LOGIC_VECTOR (4 downto 0));
end fiveBitDRegister;

architecture Behavioral of fiveBitDRegister is
component oneBitDRegister port ( Din, Clk, ARST, outputEnable, readIn: in STD_LOGIC;
                                 Q : out STD_LOGIC);
end component;
    
    begin
    
    bit0 : oneBitDRegister 
    port map ( Din => Dbus(0), Clk => Clk, outputEnable => outputEnable, readIn => readIn, ARST => ARST, Q => Qbus(0));
    
    bit1 : oneBitDRegister 
    port map ( Din => Dbus(1), Clk => Clk,outputEnable => outputEnable, readIn => readIn, ARST => ARST, Q => Qbus(1));
    
    bit2 : oneBitDRegister 
    port map ( Din => Dbus(2), Clk => Clk, outputEnable => outputEnable, readIn => readIn,  ARST => ARST, Q => Qbus(2));
    
    bit3 : oneBitDRegister 
    port map ( Din => Dbus(3), Clk => Clk, outputEnable => outputEnable, readIn => readIn,  ARST => ARST, Q => Qbus(3));
    
    bit4 : oneBitDRegister 
    port map ( Din => Dbus(4), Clk => Clk, outputEnable => outputEnable, readIn => readIn,  ARST => ARST, Q => Qbus(4));
        
end Behavioral;
