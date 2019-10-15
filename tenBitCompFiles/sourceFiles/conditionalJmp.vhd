----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/04/2016 01:51:12 AM
-- Design Name: 
-- Module Name: conditionalJmp - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library ieee;  
use ieee.std_logic_1164.all;  
use ieee.std_logic_unsigned.all; 

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity conditionalJmp is
    Port ( loadFromRegister : in STD_LOGIC;
           loadCount : in STD_LOGIC;
           outputEnable : in STD_LOGIC;
           gT : in STD_LOGIC;
           lT : in STD_LOGIC;
           eQ : in STD_LOGIC;
           equalTo : in STD_LOGIC;
           lessThan : in STD_LOGIC;
           greaterThan : in STD_LOGIC;
           Clk : in STD_LOGIC;
           addressEnable : out STD_LOGIC;
           inputCount : in STD_LOGIC_VECTOR (4 downto 0);
           inputAddress : in STD_LOGIC_VECTOR (4 downto 0);
           outputJmp : out STD_LOGIC_VECTOR (4 downto 0));
end conditionalJmp;

architecture Behavioral of conditionalJmp is
component fourBitRegister Port ( Dbus : in STD_LOGIC_VECTOR (4 downto 0);
                                 Clk, ARST, outputEnable, readIn : in STD_LOGIC;
                                 Qbus : out STD_LOGIC_VECTOR (4 downto 0));
end component;
signal sCount, sAddress : STD_LOGIC_VECTOR(4 downto 0);
begin
    countReg : fourBitRegister port map(Dbus => inputCount, Clk => Clk, ARST => '0', outputEnable => outputEnable, 
                                        readIn => loadCount, Qbus => sCount);
    addrReg  : fourBitRegister port map(Dbus => inputAddress, Clk => Clk, ARST => '0', outputEnable => outputEnable, 
                                        readIn => loadFromRegister, Qbus => sAddress);
    process (gT, lT, eQ) begin
        if (equalTo = '1' and eQ = '1') then
            outputJmp <= sAddress;
            addressEnable <= '1';
        elsif (lessThan = '1' and lT = '1') then
           outputJmp <= sAddress;
           addressEnable <= '1';
        elsif (greaterThan = '1' and gT = '1') then
            outputJmp <= sAddress;
            addressEnable <= '1';
        elsif (gT = '1' and lT = '1' and eQ = '1') then
            outputJmp <= sAddress;
            addressEnable <= '0';
        else
            addressEnable <= '0';
        end if;
        
        
    end process;
end Behavioral;
