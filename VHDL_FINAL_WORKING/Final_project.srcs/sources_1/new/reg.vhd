library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity reg is
    Port (
        CLK         :   in  std_logic;
        reg_in      :   in  integer;
        reg_en      :   in  std_logic;
        reg_out     :   out integer;
        reg_en_out  :   out std_logic;
        reg_sim     :   out integer;
        reg_en_sim  :   out std_logic
     );
end reg;

architecture Behavioral of reg is -- This block just takes in data and an enable signal and delays them by one
                                  -- cycle.
begin

    reg_out <= reg_in;
    reg_sim <= reg_in;
    reg_en_out <= reg_en;
    reg_en_sim <= reg_en;
 


end Behavioral;
