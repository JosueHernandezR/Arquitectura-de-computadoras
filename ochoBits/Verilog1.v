library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RAM is
	Port(
		sel: in STD_LOGIC_VECTOR(3 downto 0);
		Ax00: out signed(7 downto 0);
		Ax01: out signed(7 downto 0);
		Ax02: out signed(7 downto 0);
		Ax03: out signed(7 downto 0);
		Ax04: out signed(7 downto 0);
		Ax05: out signed(7 downto 0);
		Ax06: out signed(7 downto 0);
		Ax07: out signed(7 downto 0);
		Ax08: out signed(7 downto 0);
		Ax09: out signed(7 downto 0);
		Ax10: out signed(7 downto 0);
		Ax11: out signed(7 downto 0);
		Ax12: out signed(7 downto 0);
		Ax13: out signed(7 downto 0);
		Ax14: out signed(7 downto 0);
		Ax15: out signed(7 downto 0);
	);
end RAM;

architecture Behavioral of RAM is 

end Behavioral;