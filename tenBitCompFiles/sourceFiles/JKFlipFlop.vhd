----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/09/2016 11:49:50 AM
-- Design Name: 
-- Module Name: JKFlipFlop - Behavioral
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity JKFlipFlop is
    Port ( JK : in STD_LOGIC_VECTOR(1 downto 0);
           Clk : in STD_LOGIC;
           ARST : in STD_LOGIC;
           setInput : in STD_LOGIC;
           set : in STD_LOGIC;
           Q : out STD_LOGIC);
end JKFlipFlop;

architecture Behavioral of JKFlipFlop is
signal sQ : STD_LOGIC := '0';
begin
    process (Clk, ARST) begin
        if (rising_edge(Clk)) then
                case (JK) is
                    when "01" => sQ <= '0';
                    when "10" => sQ <= '1';
                    when "11" => sQ <= not sQ;
                    when others => null;
                end case;
        end if;
         if (ARST = '1') then
            sQ <= '0';
        end if;
        if (set = '1') then
            sQ <= setInput;
        end if;
    end process;
    
    
    
    process (sQ) begin
        Q <= sQ;
    end process;
end Behavioral;
