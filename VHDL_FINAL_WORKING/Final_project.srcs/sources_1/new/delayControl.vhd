library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity delayControl is
    Port (clk : in std_logic;
          C11_data : in integer;
          C11_en : in std_logic;
          
          C12_data : in integer;
          C12_en : in std_logic;
          
          C13_data : in integer;
          C13_en : in std_logic;
          
          C21_data : in integer;
          C21_en : in std_logic;
          
          C22_data : in integer;
          C22_en : in std_logic;
          
          C23_data : in integer;
          C23_en : in std_logic;
          
          C31_data : in integer;
          C31_en : in std_logic;
          
          C32_data : in integer;
          C32_en : in std_logic;
          
          C33_data : in integer;
          C33_en : in std_logic;
          
          C41_data : in integer;
          C41_en : in std_logic;
          
          C42_data : in integer;
          C42_en : in std_logic;
          
          C43_data : in integer;
          C43_en : in std_logic;
          
          c_final_data : out integer;
          c_final_addr : out integer;
          c_final_en   : out std_logic);
end delayControl;

architecture Behavioral of delayControl is
component delayOne is                       -- All of these delay blocks do the same as the reg.
    Port (clk : in std_logic;
        data : in integer;
        addr : in integer;
        en : in std_logic;
        data_out : out integer;
        addr_out : out integer;
        en_out : out std_logic );
end component delayOne;

component delayTwo is
    Port (clk : in std_logic;
        data : in integer;
        addr : in integer;
        en : in std_logic;
        data_out : out integer;
        addr_out : out integer;
        en_out : out std_logic );
end component delayTwo;

component delayThree is
    Port (clk : in std_logic;
        data : in integer;
        addr : in integer;
        en : in std_logic;
        data_out : out integer;
        addr_out : out integer;
        en_out : out std_logic );
end component delayThree;

component delayFour is
    Port (clk : in std_logic;
        data : in integer;
        addr : in integer;
        en : in std_logic;
        data_out : out integer;
        addr_out : out integer;
        en_out : out std_logic );
end component delayFour;

component delayFive is
    Port (clk : in std_logic;
        data : in integer;
        addr : in integer;
        en : in std_logic;
        data_out : out integer;
        addr_out : out integer;
        en_out : out std_logic );
end component delayFive;

component delaySix is
    Port (clk : in std_logic;
        data : in integer;
        addr : in integer;
        en : in std_logic;
        data_out : out integer;
        addr_out : out integer;
        en_out : out std_logic );
end component delaySix;

signal C11_addr : integer := 91; -- These signals are used to assign an address that the Cblock writes to.
signal C12_addr : integer := 92;
signal C13_addr : integer := 93;
signal C21_addr : integer := 94;
signal C22_addr : integer := 95;
signal C23_addr : integer := 96;
signal C31_addr : integer := 97;
signal C32_addr : integer := 98;
signal C33_addr : integer := 99;
signal C41_addr : integer := 100;
signal C42_addr : integer := 101;
signal C43_addr : integer := 102;

signal six_addr : integer;      -- All these signals are to connect the MAC2Reg to the delay.
signal six_data : integer;
signal six_en : std_logic:= '0';
signal six_addr_out : integer;
signal six_data_out : integer;
signal six_en_out : std_logic:= '0';

signal six2_addr : integer;     -- There are duplicates of certain delays because multiple blocks needed the
signal six2_data : integer;     -- same amount of delay. For example C42 and C43 need a six cycle delay after they
signal six2_en : std_logic:= '0';-- complete.
signal six2_addr_out : integer;
signal six2_data_out : integer;
signal six2_en_out : std_logic:= '0';


signal five_addr : integer;
signal five_data : integer;
signal five_en : std_logic:= '0';
signal five_addr_out : integer;
signal five_data_out : integer;
signal five_en_out : std_logic:= '0';

signal five2_addr : integer;
signal five2_data : integer;
signal five2_en : std_logic:= '0';
signal five2_addr_out : integer;
signal five2_data_out : integer;
signal five2_en_out : std_logic:= '0';


signal four_addr : integer;
signal four_data : integer;
signal four_en : std_logic:= '0';
signal four_addr_out : integer;
signal four_data_out : integer;
signal four_en_out : std_logic:= '0';

signal four2_addr : integer;
signal four2_data : integer;
signal four2_en : std_logic:= '0';
signal four2_addr_out : integer;
signal four2_data_out : integer;
signal four2_en_out : std_logic:= '0';

signal three_addr : integer;
signal three_data : integer;
signal three_en : std_logic:= '0';
signal three_addr_out : integer;
signal three_data_out : integer;
signal three_en_out : std_logic:= '0';


signal three2_addr : integer;
signal three2_data : integer;
signal three2_en : std_logic:= '0';
signal three2_addr_out : integer;
signal three2_data_out : integer;
signal three2_en_out : std_logic:= '0';

signal two_addr : integer;
signal two_data : integer;
signal two_en : std_logic:= '0';
signal two_addr_out : integer;
signal two_data_out : integer;
signal two_en_out : std_logic:= '0';

signal two2_addr : integer;
signal two2_data : integer;
signal two2_en : std_logic:= '0';
signal two2_addr_out : integer;
signal two2_data_out : integer;
signal two2_en_out : std_logic:= '0';

signal one_addr : integer;
signal one_data : integer;
signal one_en : std_logic:= '0';
signal one_addr_out : integer;
signal one_data_out : integer;
signal one_en_out : std_logic:= '0';

signal one2_addr : integer;
signal one2_data : integer;
signal one2_en : std_logic:= '0';
signal one2_addr_out : integer;
signal one2_data_out : integer;
signal one2_en_out : std_logic:= '0';

signal none_addr :integer;
signal none_data : integer;
signal none_en : std_logic:='0';



begin
    D1      :   delayOne port map( -- all of these port map the Cblocks to a specific delay.
                clk => clk,        -- The delay was determined by which cBlocks finish first and
                data => one_data,  -- what order they should be written back to the ram.
                addr => one_addr,  -- The delay is simply the the cycle completion minus the cycle 
                en => one_en,      -- it should be written back.
                data_out => one_data_out,
                addr_out => one_addr_out,
                en_out => one_en_out
                );
    D12    : delayOne port map(
                clk=> clk,
                data => one2_data,
                addr => one2_addr,
                en => one2_en,
                data_out => one2_data_out,
                addr_out => one2_addr_out,
                en_out => one2_en_out
    );
    D2      :   delayTwo port map(
                clk => clk,
                data => two_data,
                addr => two_addr,
                en => two_en,
                data_out => two_data_out,
                addr_out => two_addr_out,
                en_out => two_en_out
                );
    D22     : delayTwo port map(
                clk => clk,
                data => two2_data,
                addr => two2_addr,
                en => two2_en,
                data_out => two2_data_out,
                addr_out => two2_addr_out,
                en_out => two2_en_out
    );
    D3      :   delayThree port map(
                clk => clk,
                data => three_data,
                addr => three_addr,
                en => three_en,
                data_out => three_data_out,
                addr_out => three_addr_out,
                en_out => three_en_out
                );
    D32      :   delayThree port map(
                clk => clk,
                data => three2_data,
                addr => three2_addr,
                en => three2_en,
                data_out => three2_data_out,
                addr_out => three2_addr_out,
                en_out => three2_en_out
                );
    D4      :   delayFour port map(
                clk => clk,
                data => four_data,
                addr => four_addr,
                en => four_en,
                data_out => four_data_out,
                addr_out => four_addr_out,
                en_out => four_en_out
                );
                
    D42     :   delayFour port map(
                clk => clk,
                data => four2_data,
                addr => four2_addr,
                en => four2_en,
                data_out => four2_data_out,
                addr_out => four2_addr_out,
                en_out => four2_en_out
                );
    D5      :   delayFive port map(
                clk => clk,
                data => five_data,
                addr => five_addr,
                en => five_en,
                data_out => five_data_out,
                addr_out => five_addr_out,
                en_out => five_en_out
                );
    D52      :   delayFive port map(
                clk => clk,
                data => five2_data,
                addr => five2_addr,
                en => five2_en,
                data_out => five2_data_out,
                addr_out => five2_addr_out,
                en_out => five2_en_out
                );
    D6      :   delaySix port map(
                clk => clk,
                data => six_data,
                addr => six_addr,
                en => six_en,
                data_out => six_data_out,
                addr_out => six_addr_out,
                en_out => six_en_out
                );
    D62      :   delaySix port map(
                clk => clk,
                data => six2_data,
                addr => six2_addr,
                en => six2_en,
                data_out => six2_data_out,
                addr_out => six2_addr_out,
                en_out => six2_en_out
                );
feed : process(clk)
begin
    if(rising_edge(clk)) then -- This massive if else statement maps the cblocks either directly to the ram or to the delays.
         if(C11_en = '1') then -- no delay
            c_final_data <= C11_data; -- Because there is no delay it writes the C addr data and enable to the ram
            c_final_addr <= C11_addr;
            c_final_en <=C11_en;
        elsif(C11_en = '0') then
            none_en <= C11_en;
        end if;
        if(C12_en = '1') then -- no delay
            c_final_data <= C12_data;
            c_final_addr <= C12_addr;
            c_final_en <=C12_en;
        elsif(C12_en = '0') then
            none_en <= C12_en;
        end if;
    
        
        if(C13_en = '1') then --delay1
            one2_addr <= C13_addr;
            one2_data <= C13_data;
            one2_en <= C13_en;
        elsif(C13_en = '0') then
            one2_en <= C13_en;
        end if;
        
        if(C21_en = '1') then --delay1
            one_addr <= C21_addr;
            one_data <= C21_data;
            one_en <= C21_en;
        elsif(C21_en = '0') then
            one_en <= C21_en;
        end if;
            
       
        
        if(C22_en = '1') then --delay2
            two_addr <= C22_addr;
            two_data <= C22_data;
            two_en <= C22_en;
        elsif(C22_en = '0') then
            two_en <= C22_en;
        end if;
        
        if(C31_en = '1') then -- delay 3
            three_addr <= C31_addr;
            three_data <= C31_data;
            three_en <= C31_en;
        elsif(C31_en = '0') then
            three_en <= C31_en;
        end if;
        
        
        
        if(C23_en = '1') then -- delay 3
            three2_addr <= C23_addr;
            three2_data <= C23_data;
            three2_en <= C23_en;
        elsif(C23_en = '0') then
            three2_en <= C23_en;
        end if;

            
        if(C32_en = '1') then --delay 4
            four_addr <= C32_addr;
            four_data <= C32_data;
            four_en <= C32_en;
        elsif(C32_en = '0') then
            four_en <= C32_en;
        end if;
        
        if(C41_en = '1') then -- delay 5
            five_addr <= C41_addr;
            five_data <= C41_data;
            five_en <= C41_en;
        elsif(C41_en = '0') then
            five_en <= C41_en;
        end if;
        
        if(C33_en = '1') then --delay 5
            five2_addr <= C33_addr;
            five2_data <= C33_data;
            five2_en <= C33_en;
        elsif(C33_en = '0') then
            five2_en <= C33_en;
        end if;
            
        if(C42_en = '1') then -- delay 6
            six_addr <= C42_addr;
            six_data <= C42_data;
            six_en <= C42_en;
        elsif(C42_en = '0') then
            six_en <= C42_en;
        end if;        
        
        if(C43_en = '1') then -- delay 6
            six2_addr <= C43_addr;
            six2_data <= C43_data;
            six2_en <= C43_en;
        elsif(C43_en = '0') then
            six2_en <= C43_en;
        end if;    
    
        if(one_en_out = '1') then -- This block of if else statemenst is for when the data comes out of the delay,
            c_final_data <= one_data_out; -- the data addr and enable are written back to ram.
            c_final_addr <= one_addr_out;
            c_final_en <= one_en_out;
        elsif(one2_en_out = '1') then
            c_final_data <= one2_data_out;
            c_final_addr <= one2_addr_out;
            c_final_en <= one2_en_out;
        elsif(two_en_out ='1') then
            c_final_data <= two_data_out;
            c_final_addr <= two_addr_out;
            c_final_en <= two_en_out;
        elsif(three_en_out ='1') then
            c_final_data <= three_data_out;
            c_final_addr <= three_addr_out;
            c_final_en <= three_en_out;
        
        elsif(three2_en_out ='1') then
            c_final_data <= three2_data_out;
            c_final_addr <= three2_addr_out;
            c_final_en <= three2_en_out;    
        elsif(four_en_out ='1') then
            c_final_data <= four_data_out;
            c_final_addr <= four_addr_out;
            c_final_en <= four_en_out;
        elsif(five_en_out ='1') then
            c_final_data <= five_data_out;
            c_final_addr <= five_addr_out;
            c_final_en <= five_en_out;
        elsif(five2_en_out ='1') then
            c_final_data <= five2_data_out;
            c_final_addr <= five2_addr_out;
            c_final_en <= five2_en_out;
        elsif(six_en_out ='1') then
            c_final_data <= six_data_out;
            c_final_addr <= six_addr_out;
            c_final_en <= six_en_out;
        elsif(six2_en_out ='1') then
            c_final_data <= six2_data_out;
            c_final_addr <= six2_addr_out;
            c_final_en <= six2_en_out;
        end if;
        
    end if;

end process feed;

end Behavioral;
