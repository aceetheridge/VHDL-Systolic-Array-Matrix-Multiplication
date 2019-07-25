library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity control_MM is
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
end control_MM;
architecture Behavioral of control_MM is

component controller is
    Port (
        CLK     :   in std_logic;
        c_data  : in integer;
        c_addr  : in integer;
        c_en :  in std_logic;
        -- To A inputs
        to_A0   :   out integer;
        to_A1   :   out integer;
        to_A2   :   out integer;
        to_A3   :   out integer;
        -- To A enable pins
        to_A_en    : out std_logic_vector(0 to 3);
        -- To B inputs
        to_B0   :   out integer;
        to_B1   :   out integer;
        to_B2   :   out integer;
        -- To B enable pins
        to_B_en    : out std_logic_vector(0 to 2);
        
        RAM_91 : out integer;
        RAM_92 : out integer;
        RAM_93 : out integer;
        RAM_94 : out integer;
        RAM_95 : out integer;
        RAM_96 : out integer;
        RAM_97 : out integer;
        RAM_98 : out integer;
        RAM_99 : out integer;
        RAM_100 : out integer;
        RAM_101 : out integer;
        RAM_102 : out integer
     );
end component controller;

component MAC2Reg is
    Port(
        CLK     :   in std_logic;
        A0      :   in integer;
        A1      :   in integer;
        A2      :   in integer;
        A3      :   in integer;
        A_en    :   in std_logic_vector(0 to 3);
        B0      :   in integer;
        B1      :   in integer;
        B2      :   in integer;
        B_en    :   in std_logic_vector(0 to 2);
        
        C11     :   out integer;
        C12     :   out integer;
        C13     :   out integer;
        C21     :   out integer;
        C22     :   out integer;
        C23     :   out integer;
        C31     :   out integer;
        C32     :   out integer;
        C33     :   out integer;
        C41     :   out integer;
        C42     :   out integer;
        C43     :   out integer;
        
        C11_en  :   out std_logic;
        C12_en  :   out std_logic;
        C13_en  :   out std_logic;
        C21_en  :   out std_logic;
        C22_en  :   out std_logic;
        C23_en  :   out std_logic;
        C31_en  :   out std_logic;
        C32_en  :   out std_logic;
        C33_en  :   out std_logic;
        C41_en  :   out std_logic;
        C42_en  :   out std_logic;
        C43_en  :   out std_logic
    );
end component MAC2Reg;

component delayControl is
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
end component delayControl;

    signal A0_wire  : integer;
    signal A1_wire  : integer;
    signal A2_wire  : integer;
    signal A3_wire  : integer;
    signal A_enable : std_logic_vector(0 to 3);
    
    signal B0_wire  : integer;
    signal B1_wire  : integer;
    signal B2_wire  : integer;
    signal B_enable : std_logic_vector(0 to 2);

    signal C11_wire : integer;
    signal C12_wire : integer;
    signal C13_wire : integer;
    signal C21_wire : integer;
    signal C22_wire : integer;
    signal C23_wire : integer;
    signal C31_wire : integer;
    signal C32_wire : integer;
    signal C33_wire : integer;
    signal C41_wire : integer;
    signal C42_wire : integer;
    signal C43_wire : integer;
    
    signal C11_con : integer;
    signal C12_con : integer;
    signal C13_con : integer;
    signal C21_con : integer;
    signal C22_con : integer;
    signal C23_con : integer;
    signal C31_con : integer;
    signal C32_con : integer;
    signal C33_con : integer;
    signal C41_con : integer;
    signal C42_con : integer;
    signal C43_con : integer;
    
    signal C11_con_en : std_logic;
    signal C12_con_en : std_logic;
    signal C13_con_en : std_logic;
    signal C21_con_en : std_logic;
    signal C22_con_en : std_logic;
    signal C23_con_en : std_logic;
    signal C31_con_en : std_logic;
    signal C32_con_en : std_logic;
    signal C33_con_en : std_logic;
    signal C41_con_en : std_logic;
    signal C42_con_en : std_logic;
    signal C43_con_en : std_logic;
    
    signal R91_sig : integer;
    signal R92_sig : integer;
    signal R93_sig : integer;
    signal R94_sig : integer;
    signal R95_sig : integer;
    signal R96_sig : integer;
    signal R97_sig : integer;
    signal R98_sig : integer;
    signal R99_sig : integer;
    signal R100_sig : integer;
    signal R101_sig : integer;
    signal R102_sig : integer;
    
    
    signal c_data : integer;
    signal c_addr : integer;
    signal c_en : std_logic;
    
    
   
    

    
    

begin

    ctl : controller port map (
                                CLK => CLK,
                                c_data => c_data,
                                c_addr => c_addr,
                                c_en => c_en,
                                to_A0 => A0_wire,
                                to_A1 => A1_wire,
                                to_A2 => A2_wire,
                                to_A3 => A3_wire,
                                to_A_en => A_enable,
                                
                                to_B0 => B0_wire,
                                to_B1 => B1_wire,
                                to_B2 => B2_wire,
                                to_B_en => B_enable,
                                
                                RAM_91 => R91_sig,
                                RAM_92 => R92_sig,
                                RAM_93 => R93_sig,
                                RAM_94 => R94_sig,
                                RAM_95 => R95_sig,
                                RAM_96 => R96_sig,
                                RAM_97 => R97_sig,
                                RAM_98 => R98_sig,
                                RAM_99 => R99_sig,
                                RAM_100 => R100_sig,
                                RAM_101 => R101_sig,
                                RAM_102 => R102_sig
                                
                                
                              );
                                
    SAMM : MAC2Reg  port map (
                                CLK => CLK,
                                A0 => A0_wire,
                                A1 => A1_wire,
                                A2 => A2_wire,
                                A3 => A3_wire,
                                A_en => A_enable,
                                
                                B0 => B0_wire,
                                B1 => B1_wire,
                                B2 => B2_wire,
                                B_en => B_enable,
                                
                                
                                
                                C11 => C11_con,
                                C12 => C12_con,
                                C13 => C13_con,
                                C21 => C21_con,
                                C22 => C22_con,
                                C23 => C23_con,
                                C31 => C31_con,
                                C32 => C32_con,
                                C33 => C33_con,
                                C41 => C41_con,
                                C42 => C42_con,
                                C43 => C43_con,
                            
                                C11_en => C11_con_en,
                                C12_en => C12_con_en,
                                C13_en => C13_con_en,
                                C21_en => C21_con_en,
                                C22_en => C22_con_en,
                                C23_en => C23_con_en,
                                C31_en => C31_con_en,
                                C32_en => C32_con_en,
                                C33_en => C33_con_en,
                                C41_en => C41_con_en,
                                C42_en => C42_con_en,
                                C43_en => C43_con_en
                               
                            );
c_data_out <= c_data;
c_addr_out <= c_addr;
c_en_out <= c_en;
to_C11 <= C11_con;
to_C12 <= C12_con;
to_C13 <= C13_con;
to_C21 <= C21_con;
to_C22 <= C22_con;
to_C23 <= C23_con;
to_C31 <= C31_con;
to_C32 <= C32_con;
to_C33 <= C33_con;
to_C41 <= C41_con;
to_C42 <= C42_con;
to_C43 <= C43_con;

to_C11_en <= C11_con_en;
to_C12_en <= C12_con_en;
to_C13_en <= C13_con_en;
to_C21_en <= C21_con_en;
to_C22_en <= C22_con_en;
to_C23_en <= C23_con_en;
to_C31_en <= C31_con_en;
to_C32_en <= C32_con_en;
to_C33_en <= C33_con_en;
to_C41_en <= C41_con_en;
to_C42_en <= C42_con_en;
to_C43_en <= C43_con_en;

RAM_91_ccMM <= R91_sig;
RAM_92_ccMM <= R92_sig;
RAM_93_ccMM <= R93_sig;
RAM_94_ccMM <= R94_sig;
RAM_95_ccMM <= R95_sig;
RAM_96_ccMM <= R96_sig;
RAM_97_ccMM <= R97_sig;
RAM_98_ccMM <= R98_sig;
RAM_99_ccMM <= R99_sig;
RAM_100_ccMM <= R100_sig;
RAM_101_ccMM <= R101_sig;
RAM_102_ccMM <= R102_sig;


    DC : delayControl port map(
                
                        clk => CLK,
                        C11_data => C11_con,
                        C11_en => C11_con_en,
                        
                        C12_data => C12_con,
                        C12_en => C12_con_en,
                        
                        C13_data => C13_con,
                        C13_en => C13_con_en,
                        
                        C21_data => C21_con,
                        C21_en => C21_con_en,
                        
                        C22_data => C22_con,
                        C22_en => C22_con_en,
                        
                        C23_data => C23_con,
                        C23_en => C23_con_en,
                        
                        C31_data => C31_con,
                        C31_en => C31_con_en,
                        
                        C32_data => C32_con,
                        C32_en => C32_con_en,
                        
                        C33_data => C33_con,
                        C33_en => C33_con_en,
                        
                        C41_data => C41_con,
                        C41_en => C41_con_en,
                        
                        C42_data => C42_con,
                        C42_en => C42_con_en,
                        
                        C43_data => C43_con,
                        C43_en => C43_con_en,
                        
                        c_final_data => c_data,
                        c_final_addr => c_addr,
                        c_final_en => c_en
                        
                        );
                        

end Behavioral;
