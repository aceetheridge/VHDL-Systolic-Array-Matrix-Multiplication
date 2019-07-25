library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg_tb is
--  Port ( );
end reg_tb;

architecture behavioral of reg_tb is

component MAC2Reg is
    Port (
        CLK     :   in std_logic;
        A0      :   in integer;
        A1      :   in integer;
        A2      :   in integer;
        A3      :   in integer;
        A_en    :   std_logic_vector(0 to 3);
        B0      :   in integer;
        B1      :   in integer;
        B2      :   in integer;
        B_en    :   std_logic_vector(0 to 2);
        
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

        R1_out  :   out integer;
        R2_out  :   out integer;
        R3_out  :   out integer;
        R4_out  :   out integer;
        R5_out  :   out integer;
        R6_out  :   out integer;
        R7_out  :   out integer;
        R8_out  :   out integer;
        R9_out  :   out integer;
        R10_out :   out integer;
        R11_out :   out integer;
        R12_out :   out integer;
        R13_out :   out integer;
        R14_out :   out integer;
        R15_out :   out integer;
        R16_out :   out integer;
        R17_out :   out integer;
        
        R1_en   :   out std_logic;
        R2_en   :   out std_logic;
        R3_en   :   out std_logic;
        R4_en   :   out std_logic;
        R5_en   :   out std_logic;
        R6_en   :   out std_logic;
        R7_en   :   out std_logic;
        R8_en   :   out std_logic;
        R9_en   :   out std_logic;
        R10_en  :   out std_logic;
        R11_en  :   out std_logic;
        R12_en  :   out std_logic;
        R13_en  :   out std_logic;
        R14_en  :   out std_logic;
        R15_en  :   out std_logic;
        R16_en  :   out std_logic;
        R17_en  :   out std_logic;
        
        C11_Aen :   out std_logic;
        C12_Aen :   out std_logic;
        C13_Aen :   out std_logic;
        C21_Aen :   out std_logic;
        C22_Aen :   out std_logic;
        C23_Aen :   out std_logic;
        C31_Aen :   out std_logic;
        C32_Aen :   out std_logic;
        C33_Aen :   out std_logic;
        C41_Aen :   out std_logic;
        C42_Aen :   out std_logic;
        C43_Aen :   out std_logic;
        
        C11_Ben :   out std_logic;
        C12_Ben :   out std_logic;
        C13_Ben :   out std_logic;
        C21_Ben :   out std_logic;
        C22_Ben :   out std_logic;
        C23_Ben :   out std_logic;
        C31_Ben :   out std_logic;
        C32_Ben :   out std_logic;
        C33_Ben :   out std_logic;
        C41_Ben :   out std_logic;
        C42_Ben :   out std_logic;
        C43_Ben :   out std_logic

     );
end component MAC2Reg;

    signal A0_tb      :   integer := 0;
    signal A1_tb      :   integer := 0;
    signal A2_tb      :   integer := 0;
    signal A3_tb      :   integer := 0;
    signal A_en_tb    :   std_logic_vector(0 to 3) := "0000";
    
    signal B0_tb      :   integer := 0;
    signal B1_tb      :   integer := 0;
    signal B2_tb      :   integer := 0;
    signal B_en_tb    :   std_logic_vector(0 to 2) := "000";
    
    signal C11_tb     :   integer := 0;
    signal C12_tb     :   integer := 0;
    signal C13_tb     :   integer := 0;
    signal C21_tb     :   integer := 0;
    signal C22_tb     :   integer := 0;
    signal C23_tb     :   integer := 0;
    signal C31_tb     :   integer := 0;
    signal C32_tb     :   integer := 0;
    signal C33_tb     :   integer := 0;
    signal C41_tb     :   integer := 0;
    signal C42_tb     :   integer := 0;
    signal C43_tb     :   integer := 0;
    
    signal R1_out_tb  :   integer := 0;
    signal R2_out_tb  :   integer := 0;
    signal R3_out_tb  :   integer := 0;
    signal R4_out_tb  :   integer := 0;
    signal R5_out_tb  :   integer := 0;
    signal R6_out_tb  :   integer := 0;
    signal R7_out_tb  :   integer := 0;
    signal R8_out_tb  :   integer := 0;
    signal R9_out_tb  :   integer := 0;
    signal R10_out_tb  :   integer := 0;
    signal R11_out_tb  :   integer := 0;
    signal R12_out_tb  :   integer := 0;
    signal R13_out_tb  :   integer := 0;
    signal R14_out_tb  :   integer := 0;
    signal R15_out_tb  :   integer := 0;
    signal R16_out_tb  :   integer := 0;
    signal R17_out_tb  :   integer := 0;
    
    signal R1_en_tb   :   std_logic := '0';
    signal R2_en_tb   :   std_logic := '0';
    signal R3_en_tb   :   std_logic := '0';
    signal R4_en_tb   :   std_logic := '0';
    signal R5_en_tb   :   std_logic := '0';
    signal R6_en_tb   :   std_logic := '0';
    signal R7_en_tb   :   std_logic := '0';
    signal R8_en_tb   :   std_logic := '0';
    signal R9_en_tb   :   std_logic := '0';
    signal R10_en_tb   :   std_logic := '0';
    signal R11_en_tb   :   std_logic := '0';
    signal R12_en_tb   :   std_logic := '0';
    signal R13_en_tb   :   std_logic := '0';
    signal R14_en_tb   :   std_logic := '0';
    signal R15_en_tb   :   std_logic := '0';
    signal R16_en_tb   :   std_logic := '0';
    signal R17_en_tb   :   std_logic := '0';
    

    
    signal C11_Aen_tb :  std_logic := '0';
    signal C12_Aen_tb :  std_logic := '0';
    signal C13_Aen_tb :  std_logic := '0';
    signal C21_Aen_tb :  std_logic := '0';
    signal C22_Aen_tb :  std_logic := '0';
    signal C23_Aen_tb :  std_logic := '0';
    signal C31_Aen_tb :  std_logic := '0';
    signal C32_Aen_tb :  std_logic := '0';
    signal C33_Aen_tb :  std_logic := '0';
    signal C41_Aen_tb :  std_logic := '0';
    signal C42_Aen_tb :  std_logic := '0';
    signal C43_Aen_tb :  std_logic := '0';

    
    signal C11_Ben_tb :  std_logic := '0';
    signal C12_Ben_tb :  std_logic := '0';
    signal C13_Ben_tb :  std_logic := '0';
    signal C21_Ben_tb :  std_logic := '0';
    signal C22_Ben_tb :  std_logic := '0';
    signal C23_Ben_tb :  std_logic := '0';
    signal C31_Ben_tb :  std_logic := '0';
    signal C32_Ben_tb :  std_logic := '0';
    signal C33_Ben_tb :  std_logic := '0';
    signal C41_Ben_tb :  std_logic := '0';
    signal C42_Ben_tb :  std_logic := '0';
    signal C43_Ben_tb :  std_logic := '0';
   
    signal CLK_tb     :   std_logic := '0';
    constant clk_period : time := 20ns;
    
    
    
    type RAM is array (0 to 34) of integer;
    
    signal RAM_tb : RAM := 
    (                    
                         -- Matrix A --
                         1,2,3,4,5,
                         6,7,8,9,10,
                         11,12,13,14,15,
                         16,17,18,19,20,
                         
                         -- Matrix B --
                         1,2,3,
                         4,5,6,
                         7,8,9,
                         10,11,12,
                         13,14,15
                            
    );


begin
    
    DUT : MAC2Reg
    port map (
            CLK => CLK_tb,
            
            A0  =>  A0_tb,
            A1  =>  A1_tb,
            A2  =>  A2_tb,
            A3  =>  A3_tb,
            A_en => A_en_tb,
            
            B0  =>  B0_tb,
            B1  =>  B1_tb,
            B2  =>  B2_tb,
            B_en => B_en_tb,
            
            C11 =>  C11_tb,
            C12 =>  C12_tb,
            C13 =>  C13_tb,
            C21 =>  C21_tb,
            C22 =>  C22_tb,
            C23 =>  C23_tb,
            C31 =>  C31_tb,
            C32 =>  C32_tb,
            C33 =>  C33_tb,
            C41 =>  C41_tb,
            C42 =>  C42_tb,
            C43 =>  C43_tb,
            
            R1_out => R1_out_tb,
            R2_out => R2_out_tb,
            R3_out => R3_out_tb,
            R4_out => R4_out_tb,
            R5_out => R5_out_tb,
            R6_out => R6_out_tb,
            R7_out => R7_out_tb,
            R8_out => R8_out_tb,
            R9_out => R9_out_tb,
            R10_out => R10_out_tb,
            R11_out => R11_out_tb,
            R12_out => R12_out_tb,
            R13_out => R13_out_tb,
            R14_out => R14_out_tb,
            R15_out => R15_out_tb,
            R16_out => R16_out_tb,
            R17_out => R17_out_tb,
            
            R1_en => R1_en_tb,
            R2_en => R2_en_tb,
            R3_en => R3_en_tb,
            R4_en => R4_en_tb,
            R5_en => R5_en_tb,
            R6_en => R6_en_tb,
            R7_en => R7_en_tb,
            R8_en => R8_en_tb,
            R9_en => R9_en_tb,
            R10_en => R10_en_tb,
            R11_en => R11_en_tb,
            R12_en => R12_en_tb,
            R13_en => R13_en_tb,
            R14_en => R14_en_tb,
            R15_en => R15_en_tb,
            R16_en => R16_en_tb,
            R17_en => R17_en_tb,
            
            C11_Aen => C11_Aen_tb,
            C12_Aen => C12_Aen_tb,
            C13_Aen => C13_Aen_tb,
            C21_Aen => C21_Aen_tb,
            C22_Aen => C22_Aen_tb,
            C23_Aen => C23_Aen_tb,
            C31_Aen => C31_Aen_tb,
            C32_Aen => C32_Aen_tb,
            C33_Aen => C33_Aen_tb,
            C41_Aen => C41_Aen_tb,
            C42_Aen => C42_Aen_tb,
            C43_Aen => C43_Aen_tb,
            
            C11_Ben => C11_Ben_tb,
            C12_Ben => C12_Ben_tb,
            C13_Ben => C13_Ben_tb,
            C21_Ben => C21_Ben_tb,
            C22_Ben => C22_Ben_tb,
            C23_Ben => C23_Ben_tb,
            C31_Ben => C31_Ben_tb,
            C32_Ben => C32_Ben_tb,
            C33_Ben => C33_Ben_tb,
            C41_Ben => C41_Ben_tb,
            C42_Ben => C42_Ben_tb,
            C43_Ben => C43_Ben_tb
            
    );
    
    clk_proc : process
    begin
        CLK_tb <= '0';
        wait for clk_period / 2;
        CLK_tb <= '1';
        wait for clk_period / 2;
    end process clk_proc;

    stim_proc : process
    variable bOffset : integer := 20;
    begin
    
-- Initialize --
-------------------------------------------
        A_en_tb <= "0000";
        B_en_tb <= "000";
        
        A0_tb <= 0;
        B0_tb <= 0;

        A1_tb <= 0;        
        B1_tb <= 0;
-------------------------------------------
        wait for clk_period / 2;
        
        
        A0_tb <= RAM_tb(0);
        A_en_tb <= "1000";
        
        B0_tb <= RAM_tb(20);
        B_en_tb <= "100";
        
        wait for clk_period;
        
        A1_tb <= RAM_tb(5);
        A_en_tb <= "0100";
        
        B1_tb <= RAM_tb(21);
        B_en_tb <= "010";
        
        wait for clk_period;
        
        A2_tb <= RAM_tb(10);
        A_en_tb <= "0010";
        
        B2_tb <= RAM_tb(22);
        B_en_tb <= "001";
        
        wait for clk_period;
        
        A3_tb <= RAM_tb(15);
        A_en_tb <= "0001";
        
        B_en_tb <= "000";
        
        wait for clk_period;



        A0_tb <= RAM_tb(1);
        A_en_tb <= "1000";
        
        B0_tb <= RAM_tb(23);
        B_en_tb <= "100";
        
        wait for clk_period;
        
        A1_tb <= RAM_tb(6);
        A_en_tb <= "0100";
        
        B1_tb <= RAM_tb(24);
        B_en_tb <= "010";
        
        wait for clk_period;
        
        A2_tb <= RAM_tb(11);
        A_en_tb <= "0010";
        
        B2_tb <= RAM_tb(25);
        B_en_tb <= "001";
        
        wait for clk_period;
        
        A3_tb <= RAM_tb(16);
        A_en_tb <= "0001";
        
        B_en_tb <= "000";
        
        wait for clk_period;
        



        A0_tb <= RAM_tb(2);
        A_en_tb <= "1000";
        
        B0_tb <= RAM_tb(26);
        B_en_tb <= "100";
        
        wait for clk_period;
        
        A1_tb <= RAM_tb(7);
        A_en_tb <= "0100";
        
        B1_tb <= RAM_tb(27);
        B_en_tb <= "010";
        
        wait for clk_period;
        
        A2_tb <= RAM_tb(12);
        A_en_tb <= "0010";
        
        B2_tb <= RAM_tb(28);
        B_en_tb <= "001";
        
        wait for clk_period;
        
        A3_tb <= RAM_tb(17);
        A_en_tb <= "0001";
        
        B_en_tb <= "000";
        
        wait for clk_period;
        
        



        A0_tb <= RAM_tb(3);
        A_en_tb <= "1000";
        
        B0_tb <= RAM_tb(29);
        B_en_tb <= "100";
        
        wait for clk_period;
        
        A1_tb <= RAM_tb(8);
        A_en_tb <= "0100";
        
        B1_tb <= RAM_tb(30);
        B_en_tb <= "010";
        
        wait for clk_period;
        
        A2_tb <= RAM_tb(13);
        A_en_tb <= "0010";
        
        B2_tb <= RAM_tb(31);
        B_en_tb <= "001";
        
        wait for clk_period;
        
        A3_tb <= RAM_tb(18);
        A_en_tb <= "0001";
        
        B_en_tb <= "000";
        
        wait for clk_period;
        
        A0_tb <= RAM_tb(4);
        A_en_tb <= "1000";
        
        B0_tb <= RAM_tb(32);
        B_en_tb <= "100";
        
        wait for clk_period;
        
        A1_tb <= RAM_tb(9);
        A_en_tb <= "0100";
        
        B1_tb <= RAM_tb(33);
        B_en_tb <= "010";
        
        wait for clk_period;
        
        A2_tb <= RAM_tb(14);
        A_en_tb <= "0010";
        
        B2_tb <= RAM_tb(34);
        B_en_tb <= "001";
        
        wait for clk_period;
        
        A3_tb <= RAM_tb(19);
        A_en_tb <= "0001";
        
        B_en_tb <= "000";
        
        wait for clk_period;
        
        wait;
    
    end process;
        


end behavioral;
