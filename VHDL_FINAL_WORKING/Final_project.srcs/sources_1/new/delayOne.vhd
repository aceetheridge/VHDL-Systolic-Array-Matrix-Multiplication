library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity delayOne is
    Port (clk : in std_logic;
        data : in integer;
        addr : in integer;
        en : in std_logic;
        data_out : out integer;
        addr_out : out integer;
        en_out : out std_logic );
end delayOne;

architecture Behavioral of delayOne is
signal datad1 : integer;
signal datad2 : integer;
signal datad3 : integer;
signal datad4 : integer;
signal datad5 : integer;
signal addrd1 : integer;
signal addrd2 : integer;
signal addrd3 : integer;
signal addrd4 : integer; -- some of these signals are not used until later delays.
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
        data_out <= data; -- writes the data addr and en to a temperary varaible for one cycle.
        addr_out <= addr;
        en_out <= en;
     end if;
end process delayProc;
end Behavioral;
