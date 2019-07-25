library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity samm_testbench is
--  Port ( );
end samm_testbench;

architecture Behavioral of samm_testbench is

component control_MM is
    Port ( 
        CLK :   in std_logic;
            -- C output
        to_C11  :   out integer;
        to_C12  :   out integer;
        to_C13  :   out integer;
        to_C21  :   out integer;
        to_C22  :   out integer;
        to_C23  :   out integer;
        to_C31  :   out integer;
        to_C32  :   out integer;
        to_C33  :   out integer;
        to_C41  :   out integer;
        to_C42  :   out integer;
        to_C43  :   out integer;
        
        to_C11_en   :   out std_logic;
        to_C12_en   :   out std_logic;
        to_C13_en   :   out std_logic;
        to_C21_en   :   out std_logic;
        to_C22_en   :   out std_logic;
        to_C23_en   :   out std_logic;
        to_C31_en   :   out std_logic;
        to_C32_en   :   out std_logic;
        to_C33_en   :   out std_logic;
        to_C41_en   :   out std_logic;
        to_C42_en   :   out std_logic;
        to_C43_en   :   out std_logic;
        
        RAM_91_ccMM : out integer;
        RAM_92_ccMM : out integer;
        RAM_93_ccMM : out integer;
        RAM_94_ccMM : out integer;
        RAM_95_ccMM : out integer;
        RAM_96_ccMM : out integer;
        RAM_97_ccMM : out integer;
        RAM_98_ccMM : out integer;
        RAM_99_ccMM : out integer;
        RAM_100_ccMM : out integer;
        RAM_101_ccMM : out integer;
        RAM_102_ccMM : out integer;
        
        c_data_out  :   out integer;
        c_addr_out : out integer;
        c_en_out : out std_logic
    );
end component control_MM;
    
    signal CLK_tb       :   std_logic;
    signal to_C11_tb   : integer := 0;
    signal to_C12_tb   : integer := 0;
    signal to_C13_tb   : integer := 0;
    signal to_C21_tb   : integer := 0;
    signal to_C22_tb   : integer := 0;
    signal to_C23_tb   : integer := 0;
    signal to_C31_tb   : integer := 0;
    signal to_C32_tb   : integer := 0;
    signal to_C33_tb   : integer := 0;
    signal to_C41_tb   : integer := 0;
    signal to_C42_tb   : integer := 0;
    signal to_C43_tb   : integer := 0;
    
    signal C11_en_tb : std_logic;
    signal C12_en_tb : std_logic;
    signal C13_en_tb : std_logic;
    signal C21_en_tb : std_logic;
    signal C22_en_tb : std_logic;
    signal C23_en_tb : std_logic;
    signal C31_en_tb : std_logic;
    signal C32_en_tb : std_logic;
    signal C33_en_tb : std_logic;
    signal C41_en_tb : std_logic;
    signal C42_en_tb : std_logic;
    signal C43_en_tb : std_logic;
    
    signal R91_tb : integer;
    signal R92_tb : integer;
    signal R93_tb : integer;
    signal R94_tb : integer;
    signal R95_tb : integer;
    signal R96_tb : integer;
    signal R97_tb : integer;
    signal R98_tb : integer;
    signal R99_tb : integer;
    signal R100_tb : integer;
    signal R101_tb : integer;
    signal R102_tb : integer;
    
    signal c_data_out_tb :integer;
    signal c_addr_out_tb : integer;
    signal c_en_out_tb : std_logic;
    
    
    constant clk_period :   time := 20ns;


begin
    
    DUT : control_MM
    port map (
            CLK => CLK_tb,
            to_C11 => to_C11_tb,
            to_C12 => to_C12_tb,
            to_C13 => to_C13_tb,
            to_C21 => to_C21_tb,
            to_C22 => to_C22_tb,
            to_C23 => to_C23_tb,
            to_C31 => to_C31_tb,
            to_C32 => to_C32_tb,
            to_C33 => to_C33_tb,
            to_C41 => to_C41_tb,
            to_C42 => to_C42_tb,
            to_C43 => to_C43_tb,
            
            to_C11_en => C11_en_tb,
            to_C12_en => C12_en_tb,
            to_C13_en => C13_en_tb,
            to_C21_en => C21_en_tb,
            to_C22_en => C22_en_tb,
            to_C23_en => C23_en_tb,
            to_C31_en => C31_en_tb,
            to_C32_en => C32_en_tb,
            to_C33_en => C33_en_tb,
            to_C41_en => C41_en_tb,
            to_C42_en => C42_en_tb,
            to_C43_en => C43_en_tb,
            c_data_out => c_data_out_tb,
            c_addr_out => c_addr_out_tb,
            c_en_out => c_en_out_tb,
            
            RAM_91_ccMM => R91_tb,
            RAM_92_ccMM => R92_tb,
            RAM_93_ccMM => R93_tb,
            RAM_94_ccMM => R94_tb,
            RAM_95_ccMM => R95_tb,
            RAM_96_ccMM => R96_tb,
            RAM_97_ccMM => R97_tb,
            RAM_98_ccMM => R98_tb,
            RAM_99_ccMM => R99_tb,
            RAM_100_ccMM => R100_tb,
            RAM_101_ccMM => R101_tb,
            RAM_102_ccMM => R102_tb
            
            
            
    );

    clk_proc : process
    begin
    
        if now >= clk_period * 70 then
            std.env.stop;
        end if;
        
        CLK_tb <= '0';
        wait for clk_period / 2;
        CLK_tb <= '1';
        wait for clk_period / 2;
    end process clk_proc;


end Behavioral;
