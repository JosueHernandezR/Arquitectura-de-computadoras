library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ochoBits is
 Port ( 	inp_a : in signed(7 downto 0);
			sel : in STD_LOGIC_VECTOR (4 downto 0);
			out_alu : out signed(7 downto 0));
end ochoBits;

architecture Behavioral of ochoBits is

begin

	process(inp_a,sel)
	
		variable Ax00: signed(7 downto 0);
		variable Ax01: signed(7 downto 0);
		variable Ax02: signed(7 downto 0);
		variable Ax03: signed(7 downto 0);
		variable Ax04: signed(7 downto 0);
		variable Ax05: signed(7 downto 0);
		variable Ax06: signed(7 downto 0);
		variable Ax07: signed(7 downto 0);
		variable Ax08: signed(7 downto 0);
		variable Ax09: signed(7 downto 0);
		variable Ax10: signed(7 downto 0);
		variable Ax11: signed(7 downto 0);
		variable Ax12: signed(7 downto 0);
		variable Ax13: signed(7 downto 0);
		variable Ax14: signed(7 downto 0);
		variable Ax15: signed(7 downto 0);
		variable reg1: signed(7 downto 0);
		variable buf_out: signed(7 downto 0);
		variable ram_sel: signed(3 downto 0):="0000";
	
   begin
		case sel is
            when "00000" =>
					buf_out:= inp_a + reg1; --addition
            when "00001" =>
					buf_out:= inp_a - reg1; --subtraction
            when "00010" =>
					buf_out:= inp_a - 1; --sub 1
            when "00011" =>
					buf_out:= inp_a + 1; --add 1
            when "00100" =>
					buf_out:= inp_a and reg1; --AND gate
            when "00101" =>
					buf_out:= inp_a or reg1; --OR gate
            when "00110" =>
					buf_out:= not inp_a ; --NOT gate
            when "00111" =>
					buf_out:= inp_a xor reg1; --XOR gate
				when "01000" =>
					case ram_sel is
						when "0000" => Ax00 := inp_a;
						when "0001" => Ax01 := inp_a;
						when "0010" => Ax02 := inp_a;
						when "0011" => Ax03 := inp_a;
						when "0100" => Ax04 := inp_a;
						when "0101" => Ax05 := inp_a;
						when "0110" => Ax06 := inp_a;
						when "0111" => Ax07 := inp_a;
						when "1000" => Ax08 := inp_a;
						when "1001" => Ax09 := inp_a;
						when "1010" => Ax10 := inp_a;
						when "1011" => Ax11 := inp_a;
						when "1100" => Ax12 := inp_a;
						when "1101" => Ax13 := inp_a;
						when "1110" => Ax14 := inp_a;
						when "1111" => Ax15 := inp_a;
					end case;
				when "01001" =>
					case ram_sel is
						when "0000" => reg1 := Ax00;
						when "0001" => reg1 := Ax01;
						when "0010" => reg1 := Ax02;
						when "0011" => reg1 := Ax03;
						when "0100" => reg1 := Ax04;
						when "0101" => reg1 := Ax05;
						when "0110" => reg1 := Ax06;
						when "0111" => reg1 := Ax07;
						when "1000" => reg1 := Ax08;
						when "1001" => reg1 := Ax09;
						when "1010" => reg1 := Ax10;
						when "1011" => reg1 := Ax11;
						when "1100" => reg1 := Ax12;
						when "1101" => reg1 := Ax13;
						when "1110" => reg1 := Ax14;
						when "1111" => reg1 := Ax15;
					end case;
				when "01010" =>
					out_alu <= buf_out;
				when "01011" =>
					ram_sel:= inp_a(3 downto 0);
				when "01100" =>
				when "01101" =>
				when "01110" =>
				when "01111" =>
				when "10000" =>
				when "10001" =>
				when "10010" =>
				when "10011" =>
				when "10100" =>
				when "10101" =>
				when "10110" =>
				when "10111" =>
				when "11000" =>
				when "11001" =>
				when "11010" =>
				when "11011" =>
				when "11100" =>
				when "11101" =>
            when others =>
            NULL;
        end case;
    
    end process;
 
end Behavioral;
	


