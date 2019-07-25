library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity testbench is
--  Port ( );
end testbench;

architecture Behavioral of testbench is

    component controller is
    Port (
        CLK     :   in std_logic;
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
        
        counter :   out integer
     );
    end component controller;

    constant clk_period : time := 20ns;
    signal CLK_tb   :   std_logic;
    signal A0_tb    :   integer := 0;
    signal A1_tb    :   integer := 0;
    signal A2_tb    :   integer := 0;
    signal A3_tb    :   integer := 0;
    signal A_en_tb  :   std_logic_vector(0 to 3) := "0000";

    signal B0_tb    :   integer := 0;
    signal B1_tb    :   integer := 0;
    signal B2_tb    :   integer := 0;
    signal B_en_tb  :   std_logic_vector(0 to 2) := "000";

    signal counter_tb  :   integer := 0;
begin
    
    DUT : controller
    port map (
            CLK => CLK_tb,
            to_A0 => A0_tb,
            to_A1 => A1_tb,
            to_A2 => A2_tb,
            to_A3 => A3_tb,
            to_A_en => A_en_tb, 

            to_B0 => B0_tb,
            to_B1 => B1_tb,
            to_B2 => B2_tb,
            to_B_en => B_en_tb,

            counter => counter_tb
    );

    clk_proc : process
    begin
        CLK_tb <= '0';
        wait for clk_period / 2;
        CLK_tb <= '1';
        wait for clk_period / 2;
    end process clk_proc;

end Behavioral;
