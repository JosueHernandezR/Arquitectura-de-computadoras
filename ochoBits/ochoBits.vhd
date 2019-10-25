library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ochoBits is
Port ( 	clk : in std_logic;		/* Reloj de procesaor */
			inp_a : in signed(7 downto 0); --Entrada de dato de 8 bits
			sel : in STD_LOGIC_VECTOR (4 downto 0); --Instruccion que el procesador ejecutara
			out_alu : out signed(7 downto 0)); --Salida estandar del procesador
end ochoBits;

architecture Behavioral of ochoBits is

begin

	process(inp_a,sel,clk)
	
	
	-- Direcciones de memoria de 8 bits que estaran disponibles como RAM
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
		
		variable buf_out: signed(7 downto 0):="00000000"; --Registro en el que se guardara el resutado de las operaciones
		variable ram_sel: signed(3 downto 0):="0000"; --Selector de la memoria de ram que se usara en un pulso de reloj
		variable aux: signed(15 downto 0); --Asignacion auxiliar para el acarreo de la multiplicacion
	
   begin
		--Evento de reloj de procesador
		IF clk'event AND clk='1' then
			case sel is
					when "00000" =>
						buf_out:= inp_a + reg1; --Suma
					when "00001" =>
						buf_out:= inp_a - reg1; --Resta
					when "00010" =>
						buf_out:= inp_a - 1; --Decrementar 1
					when "00011" =>
						buf_out:= inp_a + 1; --Sumar 1
					when "00100" =>
						buf_out:= inp_a and reg1; --Compuerta AND
					when "00101" =>
						buf_out:= inp_a or reg1; --Compuerta OR
					when "00110" =>
						buf_out:= not inp_a ; --Compuerta NOT
					when "00111" =>
						buf_out:= inp_a xor reg1; --Compuerta XOR
					when "01000" =>
					--Instruccion que guardara el dato de entrada en la direccion de RAM que se tenga seleccionada
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
					--Instruccion que recuperara el valor de una direccion de RAM determinada
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
					--Intruccion que limpiara un registro de RAM seleccionado
						case ram_sel is
							when "0000" => Ax00 := "00000000";
							when "0001" => Ax01 := "00000000";
							when "0010" => Ax02 := "00000000";
							when "0011" => Ax03 := "00000000";
							when "0100" => Ax04 := "00000000";
							when "0101" => Ax05 := "00000000";
							when "0110" => Ax06 := "00000000";
							when "0111" => Ax07 := "00000000";
							when "1000" => Ax08 := "00000000";
							when "1001" => Ax09 := "00000000";
							when "1010" => Ax10 := "00000000";
							when "1011" => Ax11 := "00000000";
							when "1100" => Ax12 := "00000000";
							when "1101" => Ax13 := "00000000";
							when "1110" => Ax14 := "00000000";
							when "1111" => Ax15 := "00000000";
						end case;
					when "01011" =>
						-- Instrucción de obtener la salida del proceador
						out_alu <= buf_out;
					when "01100" =>
						-- Intruccion que selecciona la direccion de RAM que se usara
						ram_sel:= inp_a(3 downto 0);
					when "01101" =>
						--Intruccion que hace que el Procesador opere con la salida que acaba de obtener
						reg1 := buf_out;
					when "01110" =>
						--Limpiar todos los registros de la RAM y la chache del procesador
							Ax00 := "00000000";
							Ax01 := "00000000";
							Ax02 := "00000000";
							Ax03 := "00000000";
							Ax04 := "00000000";
							Ax05 := "00000000";
							Ax06 := "00000000";
							Ax07 := "00000000";
							Ax08 := "00000000";
							Ax09 := "00000000";
							Ax10 := "00000000";
							Ax11 := "00000000";
							Ax12 := "00000000";
							Ax13 := "00000000";
							Ax14 := "00000000";
							Ax15 := "00000000";
							reg1 := "00000000";
					when "01111" =>
						buf_out := reg1 NAND inp_a; --Compuerta NAND
					when "10000" =>
						buf_out := "0000" & inp_a(3 downto 0); --Multiplexor de los 4 bits menos significativos del dato
 					when "10001" =>
						buf_out := inp_a(7 downto 4) & "0000"; --Multiplexor de los 4 bits mas significativos del dato
					when "10010" =>
						--Multiplicacion
						aux := inp_a * reg1;
						if aux > "11111111" then 
							buf_out := "00000000";
						else
							buf_out := aux(7 downto 0);
						end if;
					when "10011" =>
						buf_out := reg1 / inp_a; --Division
					when "10100" =>
						buf_out := reg1 NOR inp_a; --COmpuerta NOR
					when "10101" =>
						buf_out := reg1 XNOR inp_a; -- Compuerta XNOR
					when others =>
					NULL;
			  end case;
		end if;
    end process;
 
end Behavioral;
	


