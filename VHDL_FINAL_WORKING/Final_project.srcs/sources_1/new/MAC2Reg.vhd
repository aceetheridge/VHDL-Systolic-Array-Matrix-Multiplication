library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MAC2Reg is
    Port (
        CLK     :   in std_logic; -- Takes a and b from the Ram and whick row and column to be fed into
        A0      :   in integer;
        A1      :   in integer;
        A2      :   in integer;
        A3      :   in integer;
        A_en    :   in std_logic_vector(0 to 3);
        B0      :   in integer;
        B1      :   in integer;
        B2      :   in integer;
        B_en    :   in std_logic_vector(0 to 2);
        
        C11     :   out integer; -- C data that is computed
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
        
        C11_en  :   out std_logic; -- for displaying when the C's have completed and to feed into the delay
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
        C43_en  :   out std_logic;
        
        

        R1_out  :   out integer; -- for testing purposes.
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
        
        R1_en   :   out std_logic; -- for testing purposes.
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
        
        C11_Aen :   out std_logic; -- outputs to the reg blocks to tell when data is avalible. 
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
        
        C11_Ben :   out std_logic; -- outputs to the reg blocks to tell when data is avalible.
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
end MAC2Reg;

architecture Behavioral of MAC2Reg is
    component PE_TL is -- this is the main computation block of the array
    Port (
        a_in    :   in  integer;
        a_en    :   in  std_logic;
        b_in    :   in  integer;
        b_en    :   in  std_logic;
        CLK     :   in  std_logic;
        a_out   :   out integer;
        a_en_out:   out std_logic;
        b_out   :   out integer;
        b_en_out:   out std_logic;
        c_out   :   out integer;
        sum_out :   out integer;
        c_EN    :   out std_logic;
        a_en_sim:   out std_logic;
        b_en_sim:   out std_logic
     );
    end component PE_TL;
    
    component reg is -- this is essentially just a delay block called a register
    Port (
        CLK         :   in  std_logic;
        reg_in      :   in  integer;
        reg_en      :   in  std_logic;
        reg_out     :   out integer;
        reg_en_out  :   out std_logic;
        reg_sim     :   out integer;
        reg_en_sim  :   out std_logic
     );
    end component reg;
    
    -- integer wires  --
    -- Row 1
    signal R1_L : integer;  -- Port maping for the matrix.
    signal R1_R : integer;  -- There is a register in front of the A matrix as well as between all the
    signal R2_L : integer;  -- Cblocks that stall data between the computations.
    signal R2_R : integer;  -- 

    -- Row 2
    signal R6_L : integer;  -- Data gets written to the C block as well as the register after so that the data, 
    signal R6_R : integer;  -- is ready for the next C block.
    signal R7_L : integer;
    signal R7_R : integer;
    
    -- Row 3
    signal R11_L : integer;
    signal R11_R : integer;
    signal R12_L : integer;
    signal R12_R : integer;
    
    -- Row 4
    signal R16_L : integer;
    signal R16_R : integer;
    signal R17_L : integer;
    signal R17_R : integer;

    -- Column 1
    signal R3_T : integer;
    signal R3_B : integer;
    signal R4_T : integer;
    signal R4_B : integer;   
    signal R5_T : integer;
    signal R5_B : integer;
    
    -- Column 2
    signal R8_T : integer;
    signal R8_B : integer;
    signal R9_T : integer;
    signal R9_B : integer;   
    signal R10_T : integer;
    signal R10_B : integer;
    
    -- Column 2
    signal R13_T : integer;
    signal R13_B : integer;
    signal R14_T : integer;
    signal R14_B : integer;   
    signal R15_T : integer;
    signal R15_B : integer; 
    
    -- enable wires --
    -- Row 1
    signal R1_L_en : std_logic;
    signal R1_R_en : std_logic;
    signal R2_L_en : std_logic;
    signal R2_R_en : std_logic;
    
    -- Row 1
    signal R6_L_en : std_logic;
    signal R6_R_en : std_logic;
    signal R7_L_en : std_logic;
    signal R7_R_en : std_logic;
    
    -- Row 1
    signal R11_L_en : std_logic;
    signal R11_R_en : std_logic;
    signal R12_L_en : std_logic;
    signal R12_R_en : std_logic;
    
    -- Row 1
    signal R16_L_en : std_logic;
    signal R16_R_en : std_logic;
    signal R17_L_en : std_logic;
    signal R17_R_en : std_logic;
    
    -- Column 1
    signal R3_T_en : std_logic;
    signal R3_B_en : std_logic;
    signal R4_T_en : std_logic;
    signal R4_B_en : std_logic;
    signal R5_T_en : std_logic;
    signal R5_B_en : std_logic;
    
    -- Column 2
    signal R8_T_en : std_logic;
    signal R8_B_en : std_logic;
    signal R9_T_en : std_logic;
    signal R9_B_en : std_logic;
    signal R10_T_en : std_logic;
    signal R10_B_en : std_logic;
    
    -- Column 3
    signal R13_T_en : std_logic;
    signal R13_B_en : std_logic;
    signal R14_T_en : std_logic;
    signal R14_B_en : std_logic;
    signal R15_T_en : std_logic;
    signal R15_B_en : std_logic;

    
begin

    PE11    :   PE_TL port map(
                                CLK => CLK,
                                a_in => A0,
                                a_en => A_en(0),
                                b_in => B0,
                                b_en => B_en(0),
                                a_out => R1_L,
                                a_en_out => R1_L_en,
                                b_out => R3_T,
                                b_en_out => R3_T_en,
                                c_out => C11,
                                c_EN => C11_en,
                                -- These are for Debugging in simulator
                                a_en_sim => C11_Aen,
                                b_en_sim => C11_Ben
                               );
                               
    R1      :   reg port map(
                                CLK => CLK,
                                reg_in => R1_L,
                                reg_en => R1_L_en,
                                reg_out => R1_R,
                                reg_en_out => R1_R_en,
                                
                                -- These are for Debugging in simulator
                                reg_en_sim => R1_en,
                                reg_sim => R1_out
                            );
                            
    PE12    :   PE_TL port map(
                                CLK => CLK,
                                a_in => R1_R,
                                a_en => R1_R_en,
                                b_in => B1,
                                b_en => B_en(1),
                                a_out => R2_L,
                                a_en_out => R2_L_en,
                                b_out => R4_T,
                                b_en_out => R4_T_en,
                                c_out => C12,
                                c_EN => C12_en,
                                -- These are for Debugging in simulator
                                a_en_sim => C12_Aen,
                                b_en_sim => C12_Ben
                               );
                            
                               
    R2      :   reg port map(   
                                CLK => CLK,
                                reg_in => R2_L,
                                reg_en => R2_L_en,
                                reg_out => R2_R,
                                reg_en_out => R2_R_en,
                                
                                -- These are for Debugging in simulator
                                reg_sim => R2_out,
                                reg_en_sim => R2_en
                            );
                            
    PE13    :   PE_TL port map(
                                CLK => CLK,
                                a_in => R2_R,
                                a_en => R2_R_en,
                                b_in => B2,
                                b_en => B_en(2),
                                b_out => R5_T,
                                b_en_out => R5_T_en,
                                c_out => C13,
                                c_EN => C13_en,
                                -- These are for Debugging in simulator
                                a_en_sim => C13_Aen,
                                b_en_sim => C13_Ben
                               );
                            
    R3      :   reg port map(
                                CLK => CLK,
                                reg_in => R3_T,
                                reg_en => R3_T_en,
                                reg_out => R3_B,
                                reg_en_out => R3_B_en,
                           
                                -- These are for Debugging in simulator
                                reg_sim => R3_out,
                                reg_en_sim => R3_en
                            );


                            
    R4      :   reg port map(
                                CLK => CLK,
                                reg_in => R4_T,
                                reg_en => R4_T_en,
                                reg_out => R4_B,
                                reg_en_out => R4_B_en,
                                
                                -- These are for Debugging in simulator
                                reg_sim => R4_out,
                                reg_en_sim => R4_en
                            );
                            
    R5      :   reg port map(
                                CLK => CLK,
                                reg_in => R5_T,
                                reg_en => R5_T_en,
                                reg_out => R5_B,
                                reg_en_out => R5_B_en,
                                
                                -- These are for Debugging in simulator
                                reg_sim => R5_out,
                                reg_en_sim => R5_en
                             );
                               
    PE21    :   PE_TL port map(
                                CLK => CLK,
                                a_in => A1,
                                a_en => A_en(1),
                                b_in => R3_B,
                                b_en => R3_B_en,
                                a_out => R6_L,
                                a_en_out => R6_L_en,
                                b_out => R8_T,
                                b_en_out => R8_T_en,
                                c_out => C21,
                                c_EN => C21_en,
                                -- These are for Debugging in simulator
                                a_en_sim => C21_Aen,
                                b_en_sim => C21_Ben

                               );
                            
    R6      :   reg port map(
                                CLK => CLK,
                                reg_in => R6_L,
                                reg_en => R6_L_en,
                                reg_out => R6_R,
                                reg_en_out => R6_R_en,
                                
                                -- These are for Debugging in simulator
                                reg_sim => R6_out,
                                reg_en_sim => R6_en
                            );
                            
    PE22    :   PE_TL port map(
                                CLK => CLK,
                                a_in => R6_R,
                                a_en => R6_R_en,
                                b_in => R4_B,
                                b_en => R4_B_en,
                                a_out => R7_L,
                                a_en_out => R7_L_en,
                                b_out => R9_T,
                                b_en_out => R9_T_en,
                                c_out => C22,
                                c_EN => C22_en,
                                -- These are for Debugging in simulator
                                a_en_sim => C22_Aen,
                                b_en_sim => C22_Ben
                               );
                           
    R7      :   reg port map(
                                CLK => CLK,
                                reg_in => R7_L,
                                reg_en => R7_L_en,
                                reg_out => R7_R,
                                reg_en_out => R7_R_en,
                                
                                -- These are for Debugging in simulator
                                reg_sim => R7_out,
                                reg_en_sim => R7_en
                            );
                            
    PE23    :   PE_TL port map(
                                CLK => CLK,
                                a_in => R7_R,
                                a_en => R7_R_en,
                                b_in => R5_B,
                                b_en => R5_B_en,
                                b_out => R10_T,
                                b_en_out => R10_T_en,
                                c_out => C23,
                                c_EN => C23_en,
                                -- These are for Debugging in simulator
                                a_en_sim => C23_Aen,
                                b_en_sim => C23_Ben
                               );

    R8      :   reg port map(
                                CLK => CLK,
                                reg_in => R8_T,
                                reg_en => R8_T_en,
                                reg_out => R8_B,
                                reg_en_out => R8_B_en,
                                
                                -- These are for Debugging in simulator
                                reg_sim => R8_out,
                                reg_en_sim => R8_en
                            );


                            
    R9      :   reg port map(
                                CLK => CLK,
                                reg_in => R9_T,
                                reg_en => R9_T_en,
                                reg_out => R9_B,
                                reg_en_out => R9_B_en,
                                
                                -- These are for Debugging in simulator
                                reg_sim => R9_out,
                                reg_en_sim => R9_en
                            );
                            
    R10      :   reg port map(
                                CLK => CLK,
                                reg_in => R10_T,
                                reg_en => R10_T_en,
                                reg_out => R10_B,
                                reg_en_out => R10_B_en,
                                
                                 -- These are for Debugging in simulator
                                reg_sim => R10_out,
                                reg_en_sim => R10_en
                             );
                             
    PE31    :   PE_TL port map(
                                CLK => CLK,
                                a_in => A2,
                                a_en => A_en(2),
                                b_in => R8_B,
                                b_en => R8_B_en,
                                a_out => R11_L,
                                a_en_out => R11_L_en,
                                b_out => R13_T,
                                b_en_out => R13_T_en,
                                c_out => C31,
                                c_EN => C31_en,
                                -- These are for Debugging in simulator
                                a_en_sim => C31_Aen,
                                b_en_sim => C31_Ben
                                
                               );
                            
    R11      :   reg port map(
                                CLK => CLK,
                                reg_in => R11_L,
                                reg_en => R11_L_en,
                                reg_out => R11_R,
                                reg_en_out => R11_R_en,
                                
                                -- These are for Debugging in simulator                              
                                reg_sim => R11_out,
                                reg_en_sim => R11_en
                            );
                            
    PE32    :   PE_TL port map(
                                CLK => CLK,
                                a_in => R11_R,
                                a_en => R11_R_en,
                                b_in => R9_B,
                                b_en => R9_B_en,
                                a_out => R12_L,
                                a_en_out => R12_L_en,
                                b_out => R14_T,
                                b_en_out => R14_T_en,
                                c_out => C32,
                                c_EN => C32_en,
                                -- These are for Debugging in simulator
                                a_en_sim => C32_Aen,
                                b_en_sim => C32_Ben
                               );
                           
    R12      :   reg port map(
                                CLK => CLK,
                                reg_in => R12_L,
                                reg_en => R12_L_en,
                                reg_out => R12_R,
                                reg_en_out => R12_R_en,
                                
                                reg_sim => R12_out,
                                reg_en_sim => R12_en
                            );
                            
    PE33    :   PE_TL port map(
                                CLK => CLK,
                                a_in => R12_R,
                                a_en => R12_R_en,
                                b_in => R10_B,
                                b_en => R10_B_en,
                                b_out => R15_T,
                                b_en_out => R15_T_en,
                                c_out => C33,
                                c_EN => C33_en,
                                a_en_sim => C33_Aen,
                                b_en_sim => C33_Ben
                               );

    R13      :   reg port map(
                                CLK => CLK,
                                reg_in => R13_T,
                                reg_en => R13_T_en,
                                reg_out => R13_B,
                                reg_en_out => R13_B_en,
                                
                                reg_sim => R13_out,
                                reg_en_sim => R13_en
                            );


                            
    R14      :   reg port map(
                                CLK => CLK,
                                reg_in => R14_T,
                                reg_en => R14_T_en,
                                reg_out => R14_B,
                                reg_en_out => R14_B_en,
                                
                                reg_sim => R14_out,
                                reg_en_sim => R14_en
                            );
                            
    R15      :   reg port map(
                                CLK => CLK,
                                reg_in => R15_T,
                                reg_en => R15_T_en,
                                reg_out => R15_B,
                                reg_en_out => R15_B_en,
                                
                                reg_sim => R15_out,
                                reg_en_sim => R15_en
                             );
                             
    PE41    :   PE_TL port map(
                                CLK => CLK,
                                a_in => A3,
                                a_en => A_en(3),
                                b_in => R13_B,
                                b_en => R13_B_en,
                                a_out => R16_L,
                                a_en_out => R16_L_en,
                                c_out => C41,
                                c_EN => C41_en,
                                a_en_sim => C41_Aen,
                                b_en_sim => C41_Ben
                                
                               );
                            
    R16      :   reg port map(
                                CLK => CLK,
                                reg_in => R16_L,
                                reg_en => R16_L_en,
                                reg_out => R16_R,
                                reg_en_out => R16_R_en,
                                
                                reg_sim => R16_out,
                                reg_en_sim => R16_en
                            );
                            
    PE42    :   PE_TL port map(
                                CLK => CLK,
                                a_in => R16_R,
                                a_en => R16_R_en,
                                b_in => R14_B,
                                b_en => R14_B_en,
                                a_out => R17_L,
                                a_en_out => R17_L_en,
                                c_out => C42,
                                c_EN => C42_en,
                                a_en_sim => C42_Aen,
                                b_en_sim => C42_Ben
                               );
                           
    R17      :   reg port map(
                                CLK => CLK,
                                reg_in => R17_L,
                                reg_en => R17_L_en,
                                reg_out => R17_R,
                                reg_en_out => R17_R_en,
                                
                                reg_sim => R17_out,
                                reg_en_sim => R17_en
                            );
                            
    PE43    :   PE_TL port map(
                                CLK => CLK,
                                a_in => R17_R,
                                a_en => R17_R_en,
                                b_in => R15_B,
                                b_en => R15_B_en,
                                c_out => C43,
                                c_EN => C43_en,
                                a_en_sim => C43_Aen,
                                b_en_sim => C43_Ben
                               );
end Behavioral;
