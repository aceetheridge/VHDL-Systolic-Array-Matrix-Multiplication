library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PE is
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
end PE;

architecture Behavioral of PE is
    signal A        :   integer := 0;
    signal B        :   integer := 0;
    signal sum      :   integer := 0;

begin

    MAC : process(a_in, RST)
    variable count : integer := 0;
    variable cycle : integer := 4;
    begin
        
        if(RST = '0') then
            count := count + 1;
            sum <= sum + (a_in*b_in);
            A <= a_in;
            B <= b_in;
            -- Adds a 1 "cycle" delay from a_in/b_in to a_out/b_out
            a_out <= A;
            b_out <= B;
    
            if(a_in /= -1 or a_in /= -2) then
                if(count > cycle) then
                    c_out <= sum;
                    sum <= 0;
                    c_EN <= '1';
                    count := 0;
                else
                    c_out <= 0;
                    c_EN <= '0';
                end if;
            end if;
        elsif(RST = '1') then
            A <= a_in;
            B <= b_in;
            -- Adds a 1 "cycle" delay from a_in/b_in to a_out/b_out
            a_out <= A;
            b_out <= B;
        end if;
    end process MAC;
    
    RST_out <= RST;
    sum_out <= sum;
end Behavioral;
