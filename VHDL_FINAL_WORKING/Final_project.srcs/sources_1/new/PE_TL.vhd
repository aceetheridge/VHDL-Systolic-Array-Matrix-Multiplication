library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity PE_TL is
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
end PE_TL;

architecture Behavioral of PE_TL is
    signal sum      :   integer := 0; -- running sum
    signal done     :   boolean := false; -- for knowing when the full computation is complete.
    signal sum2 : integer := 0; -- to hold the sum for 1 clock cycle and start the next sum.
    signal en_sig : std_logic;

begin
    
    multiply : process(CLK)
    variable count : integer := 0;
    begin
        if(rising_edge(CLK)) then
            a_out <= a_in;
            b_out <= b_in;
            a_en_out <= a_en;
            b_en_out <= b_en;
            a_en_sim <= a_en; -- takes in the data and enable
            b_en_sim <= b_en;
            
            if(en_sig = '1') then --if the 5 additions are complete en_sig will be 1 and the sum will will be reset
                sum <= 0;
            end if;
            if(count > 4) then -- once 5 additions are complete the done flag is changed. 
                done <= true;
                count := 0; -- the count is reset for the next pair of Matrixis A2 and B2               
            else
                done <= false;
                if(a_en = '1' and b_en = '1' and done = false) then -- when a and b both have data in their registers
                    sum <= sum + (a_in * b_in);                     -- the two datas are multiplied and added to a running sum
                    count := count + 1;
                end if;
            end if;
        end if;
    end process multiply;
    
        process(CLK, done)
        begin
            if(done = true) then -- when 5 cycles is done it ouputs the sum and and and enable signal
                c_out <= sum;
                c_EN <= '1';
                en_sig<= '1'; -- turns to 1 so that at the begining of the next cycle the sum is reset
                
                
            else
                c_out <= 0; -- makes sure nothing is being written out will the sums are being computed.
                c_EN <= '0';
                en_sig <= '0'; 
            end if;
        end process;
       
    
    --c_out <= sum;
    
end Behavioral;
