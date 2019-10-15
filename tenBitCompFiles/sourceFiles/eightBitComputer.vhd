----------------------------------------------------------------------------------
-- Engineer: Ezzeddeen Gazali and Tyler Starr
-- Create Date: 11/18/2016 05:23:13 PM
-- Description: A VHDL module that behaves as a 10-bit computer
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity eightBitComputer is
Port (inputAddress : in STD_LOGIC_VECTOR(4 downto 0);
      inputData : in STD_LOGIC_VECTOR(9 downto 0);
      program, write, inputClk, reset, defaultProgram, clearProgram: in STD_LOGIC;
      enableOut : out STD_LOGIC_VECTOR(3 downto 0);
      outputData : out STD_LOGIC_VECTOR(7 downto 0);
      ledOutput : out STD_LOGIC_VECTOR(15 downto 0));
end eightBitComputer;

architecture Behavioral of eightBitComputer is
    component binToBCD port (number : in  std_logic_vector (9 downto 0);
                             hundreds : out std_logic_vector (3 downto 0);
                             tens : out std_logic_vector (3 downto 0);
                             ones : out std_logic_vector (3 downto 0));
    end component;
    component programCounter port ( Cp, Clk, Clr, Ep, Sp : in STD_LOGIC;
                                    output : out STD_LOGIC_VECTOR (4 downto 0);
                                    input : in STD_LOGIC_VECTOR(4 downto 0);
                                    count : out STD_LOGIC_VECTOR (4 downto 0));
    end component;
    component tenBitDRegister is port ( Dbus : in STD_LOGIC_VECTOR (9 downto 0);
                                          Clk, ARST, outputEnable, readIn : in STD_LOGIC;
                                          Qbus : out STD_LOGIC_VECTOR (9 downto 0));
    end component;
    component fiveBitDRegister Port ( Dbus : in STD_LOGIC_VECTOR (4 downto 0);
                                     Clk, ARST, outputEnable, readIn : in STD_LOGIC;
                                     Qbus : out STD_LOGIC_VECTOR (4 downto 0));
    end component;
    component inputMUX port ( address : in STD_LOGIC_VECTOR (4 downto 0);
                             MAR : in STD_LOGIC_VECTOR (4 downto 0);
                             program : in STD_LOGIC;
                             output : out STD_LOGIC_VECTOR (4 downto 0));
    end component;
    component ramModule Port ( inputData        : in STD_LOGIC_VECTOR (9 downto 0);
                               inputAddress     : in STD_LOGIC_VECTOR (4 downto 0);
                               program, Clk, move, readWrite : in STD_LOGIC; --control bits
                               outputDataToBus  : out STD_LOGIC_VECTOR (9 downto 0) := "ZZZZZZZZZZ";
                               outputData       : out STD_LOGIC_VECTOR (9 downto 0);
                               outputAddress    : out STD_LOGIC_VECTOR(4 downto 0);
                               notCE            : in STD_LOGIC);
    end component;
    component addressROM port ( opCode : in STD_LOGIC_VECTOR (4 downto 0);
                             opCodeStart : out STD_LOGIC_VECTOR (4 downto 0));
    end component;
    component preCounter port ( Clr, T1, T3, Clk : in STD_LOGIC;
                                opCodeStart : in STD_LOGIC_VECTOR (4 downto 0);
                                controlWordLocation : out STD_LOGIC_VECTOR (4 downto 0));
    end component;
    component ringCounter Port ( reset, Clk, NOP : in STD_LOGIC;
                                 count : out STD_LOGIC_VECTOR (5 downto 0));
    end component;
    component controlROM port ( controlWordLocation : in STD_LOGIC_VECTOR (4 downto 0);
                            controlWord : out STD_LOGIC_VECTOR (19 downto 0);
                            NOP : out STD_LOGIC);
    end component;
    component ALU Port ( A, B : in STD_LOGIC_VECTOR (9 downto 0);
                         result : out STD_LOGIC_VECTOR (9 downto 0);
                         error, greaterThan, equalTo, lessThan : out STD_LOGIC;
                         subtract : in STD_LOGIC);
    end component;
    component clockDivider Port ( inputClk : in STD_LOGIC;
                           stop : in STD_LOGIC_VECTOR(4 downto 0);
                           outputClk : out STD_LOGIC);
    end component;
    component triStateBuffer Port ( Din : in STD_LOGIC_VECTOR (4 downto 0);
                                    Ep : in STD_LOGIC;
                                    Dout : out STD_LOGIC_VECTOR (4 downto 0));
    end component;
    component fourDigitDisplay Port ( number : in STD_LOGIC_VECTOR (15 downto 0);
                                      anode : out STD_LOGIC_VECTOR(3 downto 0);
                                      cathode : out STD_LOGIC_VECTOR(7 downto 0);
                                      error : in STD_LOGIC;
                                      clk : in STD_LOGIC);
    end component;
    component outputMUX port ( progModeInput : in STD_LOGIC_VECTOR (15 downto 0);
                               runModeInput : in STD_LOGIC_VECTOR (15 downto 0);
                               ledOutput : out STD_LOGIC_VECTOR (15 downto 0);
                               modeSelect : in STD_LOGIC);
    end component;
    component conditionalJmp Port ( loadFromRegister : in STD_LOGIC;
                                    loadCount : in STD_LOGIC;
                                    outputEnable : in STD_LOGIC;
                                    gT : in STD_LOGIC;
                                    lT : in STD_LOGIC;
                                    eQ : in STD_LOGIC;
                                    equalTo : in STD_LOGIC;
                                    lessThan : in STD_LOGIC;
                                    greaterThan : in STD_LOGIC;
                                    addressEnable : out STD_LOGIC;
                                    Clk : in STD_LOGIC;
                                    inputCount : in STD_LOGIC_VECTOR (4 downto 0);
                                    inputAddress : in STD_LOGIC_VECTOR (4 downto 0);
                                    outputJmp : out STD_LOGIC_VECTOR (4 downto 0));
    end component;
    component ramMUX Port ( userInput : in STD_LOGIC_VECTOR (9 downto 0);
                            aRegInput : in STD_LOGIC_VECTOR (9 downto 0);
                            output : out STD_LOGIC_VECTOR (9 downto 0);
                            control : in STD_LOGIC);
    end component;


    --signals are headed with a "s" followed by the name of what is being signaled
    signal sControlWord                                                                                     : STD_LOGIC_VECTOR(19 downto 0); 
    signal sNumber, sProgModeInput, sRunModeInput                                                           : STD_LOGIC_VECTOR(15 downto 0); 
    signal sBus, sRegisterA, sRegisterB, sSum, sBinaryNumber, sOutputData, sRamInput                        : STD_LOGIC_VECTOR(9 downto 0);
    signal sRingCount                                                                                       : STD_LOGIC_VECTOR(5 downto 0);
    signal sRam, sOpCode, sOpCodeStart, sControlWordLocatoin, sMar, sOutputAddress, sJumpAddress, sCount    : STD_LOGIC_VECTOR(4 downto 0);
    signal sHun, sTen, sOne                                                                                 : STD_LOGIC_VECTOR(3 downto 0);
    signal sError, sClk, Clk, sGreaterThan, sEqualTo, sLessThan, sNOP, sProgram, sAddressEnable             : STD_LOGIC;

begin
        Clk <= sClk;
        
        sNumber        <= "0000"     
                          & sHun              
                          & sTen              
                          & sOne;
        
        sProgModeInput <= sOutputAddress    
                          & "0"               
                          & sOutputData;
        
        sRunModeInput <= sProgram           
                         & Clk                
                         & sError
                         & reset         
                         & sControlWord(12)   
                         & "000000"              
                         & sCount;
        
        sProgram <= not sControlWord(19) and program;
        
        
        rMux        : ramMUX port map(userInput => inputData, aRegInput => sBus(9 downto 0), output =>sRamInput, control => sControlWord(19));
        condJmp     : conditionalJmp port map(inputCount => sBus(4 downto 0), inputAddress => sBus(4 downto 0), outputJmp => sJumpAddress,
                                              outputEnable => sControlWord(18), loadCount => sControlWord(17), loadFromRegister => sControlWord(16), eQ => sControlWord(15),
                                              gT => sControlWord(14), lT => sControlWord(13), equalTo => sEqualTo, greaterThan => sGreaterThan, lessThan => sLessThan, Clk => Clk, addressEnable => sAddressEnable);
        progCnt     : programCounter port map(Clk => Clk, Clr => reset, Cp => sControlWord(11), Ep => sControlWord(10),count => sCount, output => sBus(4 downto 0), input => sJumpAddress, Sp =>sAddressEnable ); 
        oMux        : outputMUX port map(progModeInput => sProgModeInput, runModeInput => sRunModeInput, modeSelect => program, ledOutput => ledOutput);
        bcd         : binToBCD port map(number => sBinaryNumber, ones => sOne, tens => sTen, hundreds => sHun);
        fourDigDis  : fourDigitDisplay port map(number => sNumber, clk => inputClk, anode => enableOut, cathode => outputData, error => sError);
        clock1      : clockDivider port map(inputClk => inputClk, outputClk => sClk, stop => sOpCode);
        marLatch    : fiveBitDRegister port map(Clk => Clk, ARST => reset, Dbus => sBus(4 downto 0), outputEnable => '0', readIn => sControlWord(9), Qbus => sMar); 
        inpMux      : inputMUX port map(address => inputAddress, MAR => sMar, program => program, output => sRam);
        RAM         : ramModule port map(inputData => sRamInput, inputAddress => sRam, outputDataToBus => sBus, program => write, readWrite => sProgram, notCE => sControlWord(8), outputAddress => sOutputAddress, outputData => sOutputData, Clk => Clk, move => sControlWord(19));
        addrReg     : fiveBitDRegister port map(Clk => Clk, ARST => reset, Dbus => sBus(4 downto 0), outputEnable => sControlWord(6), readIn => sControlWord(7), Qbus => sBus(4 downto 0));
        conReg      : fiveBitDRegister port map(Clk => Clk, ARST => reset, Dbus => sBus(9 downto 5), outputEnable => '0', readIn => sControlWord(7), Qbus => sOpCode);
        aRom        : addressROM port map(opCode => sOpCode, opCodeStart => sOpCodeStart);
        ringCnt     : ringCounter port map(reset => reset, Clk => Clk, count => sRingCount, NOP => sNOP);
        preCnt      : preCounter port map(Clr => reset, Clk => Clk, T1 => sRingCount(0), T3 => sRingCount(3), opCodeStart => sOpCodeStart, controlWordLocation => sControlWordLocatoin); 
        cRom        : controlROM port map(controlWordLocation => sControlWordLocatoin, controlWord => sControlWord, NOP => sNOP);
        aReg        : tenBitDRegister port map (Clk => Clk, ARST => reset, Dbus => sBus, outputEnable => '0', readIn => sControlWord(5), Qbus => sRegisterA);
        aBuff1      : triStateBuffer port map(Din => sRegisterA(4 downto 0), Ep => sControlWord(4), Dout => sBus(4 downto 0));
        aBuff2      : triStateBuffer port map(Din => sRegisterA(9 downto 5), Ep => sControlWord(4), Dout => sBus(9 downto 5));
        bReg        : tenBitDRegister port map (Clk => Clk, ARST => reset, Dbus => sBus, outputEnable => '0', readIn => sControlWord(1), Qbus => sRegisterB);
        arithlogic  : ALU port map(A => sRegisterA, B => sRegisterB, result => sSum, error => sError, subtract => sControlWord(3), equalTo => sEqualTo, greaterThan => sGreaterThan, lessThan => sLessThan);
        arithBuff1  : triStateBuffer port map(Din => sSum(4 downto 0), Ep => sControlWord(2), Dout => sBus(4 downto 0));
        arithBuff2  : triStateBuffer port map(Din => sSum(9 downto 5), Ep => sControlWord(2), Dout => sBus(9 downto 5));
        oReg        : tenBitDRegister port map (Clk => Clk, ARST => reset, Dbus => sRegisterA, outputEnable => '0', readIn => sControlWord(0), Qbus => sBinaryNumber);
end Behavioral;
