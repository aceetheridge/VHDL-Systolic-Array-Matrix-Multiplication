library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity samm is
    Port (
        CLK,RST     :   in std_logic;
        A0          :   in  integer;
        A1          :   in  integer;
        B0          :   in  integer;
        B1          :   in  integer;
        
        C11         :   out integer;
        C11_sum     :   out integer;
        C11_EN      :   out std_logic;
        
        C12         :   out integer;
        C12_sum     :   out integer;
        C12_EN      :   out std_logic;
        
        C21         :   out integer;
        C21_sum     :   out integer;
        C21_EN      :   out std_logic;
        
        C22         :   out integer;
        C22_sum     :   out integer;
        C22_EN      :   out std_logic;
        
        a11_12      :   out integer;
        b11_21      :   out integer;
        
        a21_22      :   out integer;
        b12_22      :   out integer
     );
end samm;

architecture Behavioral of samm is
    component PE is
    Port (
        a_in    :   in  integer;
        b_in    :   in  integer;
        CLK     :   in  std_logic;
        RST     :   in  std_logic;
        RST_out :   out std_logic;
        a_out   :   out integer;
        b_out   :   out integer;
        c_out   :   out integer;
        sum_out :   out integer;
        c_EN    :   out std_logic
     );
    
    end component PE;
    
    component PE_TL is
    Port (
        a_in    :   in  integer;
        b_in    :   in  integer;
        CLK     :   in  std_logic;
        RST     :   in  std_logic;
        RST_out :   out std_logic;
        a_out   :   out integer;
        b_out   :   out integer;
        c_out   :   out integer;
        sum_out :   out integer;
        c_EN    :   out std_logic
     );
    
    end component PE_TL;
    
    component PE_T is
    Port (
        a_in    :   in  integer;
        b_in    :   in  integer;
        CLK     :   in  std_logic;
        RST     :   in  std_logic;
        RST_out :   out std_logic;
        a_out   :   out integer;
        b_out   :   out integer;
        c_out   :   out integer;
        sum_out :   out integer;
        c_EN    :   out std_logic
     );
    
    end component PE_T;
    
    component PE_L is
    Port (
        a_in    :   in  integer;
        b_in    :   in  integer;
        CLK     :   in  std_logic;
        RST     :   in  std_logic;
        RST_out :   out std_logic;
        a_out   :   out integer;
        b_out   :   out integer;
        c_out   :   out integer;
        sum_out :   out integer;
        c_EN    :   out std_logic
     );
    
    end component PE_L;
    
    signal a11_a12  : integer;
    signal b11_b21  : integer;
    
    signal a21_a22  : integer;
    signal b12_b22  : integer;
   
    signal RST_1    : std_logic;
    signal RST_2    : std_logic;
  
begin
    
    PE11    :   PE_TL port map(
                                a_in => A0,
                                b_in => B0,
                                a_out => a11_a12,
                                b_out => b11_b21,
                                c_out => C11,
                                c_EN => C11_EN,
                                sum_out => C11_sum,
                                CLK => CLK,
                                RST => RST,
                                RST_out => RST_1
                            );
                            
    PE12    :   PE_T port map(
                                a_in => a11_a12,
                                b_in => B1,
                                b_out => b12_b22,
                                c_out => C12,
                                c_EN => C12_EN,
                                sum_out => C12_sum,
                                CLK => CLK,
                                RST => RST_1
                            );
                            
    PE21    :   PE_L port map(
                                a_in => A1,
                                b_in => b11_b21,
                                a_out => a21_a22,
                                c_out => C21,
                                c_EN => C21_EN,
                                sum_out => C21_sum,
                                CLK => CLK,
                                RST => RST_1,
                                RST_out => RST_2
                            );
                            
    PE22    :   PE port map(
                                a_in => a21_a22,
                                b_in => b12_b22,
                                c_out => C22,
                                c_EN => C22_EN,
                                sum_out => C22_sum,
                                CLK => CLK,
                                RST => RST_2
                            );
                            
    a11_12 <= a11_a12;
    b11_21 <= b11_b21;
    a21_22 <= a21_a22;
    b12_22 <= b12_b22;


end Behavioral;
