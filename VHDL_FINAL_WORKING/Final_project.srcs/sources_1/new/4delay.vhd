library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity delayFour is
    Port (clk : in std_logic;
        data : in integer;
        addr : in integer;
        en : in std_logic;
        data_out : out integer;
        addr_out : out integer;
        en_out : out std_logic );
end delayFour;

architecture Behavioral of delayFour is
signal datad1 : integer;
signal datad2 : integer;
signal datad3 : integer;
signal datad4 : integer;
signal datad5 : integer;
signal addrd1 : integer;
signal addrd2 : integer;
signal addrd3 : integer;
signal addrd4 : integer;
signal addrd5 : integer;
signal end1 : std_logic;
signal end2 : std_logic;
signal end3 : std_logic;
signal end4 : std_logic;
signal end5 : std_logic;

begin
delayProc : process(clk)
begin
    if(rising_edge(clk)) then
        data_out <= datad3;
        addr_out <= addrd3;
        en_out <= end3;
        
        datad3 <= datad2;
        addrd3 <= addrd2;
        end3 <= end2;
        
        datad2 <= datad1;
        addrd2 <= addrd1;
        end2 <= end1;
         
        datad1 <= data;
        addrd1 <= addr;
        end1 <= en;
     end if;
end process delayProc;
end Behavioral;
