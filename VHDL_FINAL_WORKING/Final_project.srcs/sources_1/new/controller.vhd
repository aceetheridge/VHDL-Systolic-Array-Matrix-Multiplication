library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RAM is
    Port (
        CLK     :   in std_logic; -- C inputs to write back to RAM.
        c_data  : in integer;
        c_addr  : in integer;
        c_en :  in std_logic;
        -- To A inputs
        to_A0   :   out integer; -- Send the data to the different A rows.
        to_A1   :   out integer;
        to_A2   :   out integer;
        to_A3   :   out integer;
        -- To A enable pins
        to_A_en    : out std_logic_vector(0 to 3);
        -- To B inputs
        to_B0   :   out integer; -- Sends the data to the different B columns.
        to_B1   :   out integer;
        to_B2   :   out integer;
        -- To B enable pins
        to_B_en    : out std_logic_vector(0 to 2);
        
        RAM_91 : out integer; -- Outputs to display that data has been written back to RAM.
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
        RAM_102 : out integer;
        
        
        counter   :   out integer
     );
end RAM;

architecture Behavioral of RAM is
    type memory is array (0 to 102) of integer; -- RAM ARRAY OF INTEGERS 
    signal RAM : memory := 
    (                    
                         -- Matrix A1 --  The A matrix is Transposed so that it can easily be iterated through
                         
                         0,5,10,15, -- This means the actual input matrix is
                         1,6,11,16, -- 0,1,2,3,4,
                         2,7,12,17, -- 5,6,7,8,9,
                         3,8,13,18, -- 10,11,12,13,14,
                         4,9,14,19, -- 15,16,17,18,19,
                        -- Matrix A2 -- Also transposed
                         
                         20,25,30,35,
                         21,26,31,36,
                         22,27,32,37,
                         23,28,33,38,
                         24,29,34,39,
                         
                         
                         -- Matrix B -- Not transposed
                         1,2,3,
                         4,5,6,
                         7,8,9,
                         10,11,12,
                         13,14,15,
                         
                         -- Matrix B2 -- Not transposed
                         16,17,18,
                         19,20,21,
                         22,23,24,
                         25,26,27,
                         28,29,30,
                         
                         0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, -- Bufferbits between B and C matrix so that B doesn't iterate into the C matrix.
                         
                         -- Matrix C -- Only one C matrix for the output that gets overwritten
                         0,0,0,0,0,0,0,0,0,0,0,0
                         
    );
    
    signal count : integer := 0;
begin

cProc : process(clk) --clk
begin
    
    
    if (rising_edge(clk)) then -- When the c-block completes a summation the c_en signal will be high.
        if(c_en='1') then
            RAM(integer(c_addr)) <= integer(c_data); -- the delayControl sends an address and the completed data back to the ram
            end if;
        end if;
        end process cProc;

    clock_proc  : process(CLK)
    -- Matrix A is 4x5 = 20
    -- Matrix B is 5x3 = 15
    variable aitr  :   integer := 0; -- Starts the a iterator at 0 postion in the ram
    variable bitr : integer := 40; -- Starts the b iterator at the 40th postion in the ram
    begin
        
        if(rising_edge(CLK)) then
            count <= count + 1;
            if((count mod 4) = 0) then -- Modulus of the count of clock cycles determins the a row and b column to write to.
                to_A0 <= RAM(aitr);
                to_B0 <= RAM(bitr);
                to_A_en <= "1000"; -- these signals are sent to the matrix to enable computation, 
                to_B_en <= "100"; -- "1000" means that A0, 1st row, will be written to, while "0001" is A3, the 4th row
                
                aitr := aitr + 1; -- iterates both a and b.
                bitr := bitr + 1;
                end if;
            if((count mod 4) = 1) then
                to_A1 <= RAM(aitr);
                to_B1 <= RAM(bitr);
                to_A_en <= "0100";
                to_B_en <= "010";
                aitr := aitr + 1;
                bitr := bitr + 1;
            end if;
            if((count mod 4) = 2) then
                to_A2 <= RAM(aitr);
                to_B2 <= RAM(bitr);
                to_A_en <= "0010";
                to_B_en <= "001";
                aitr := aitr + 1;
                bitr := bitr + 1;
            end if;
            if((count mod 4) = 3) then
                to_A3 <= RAM(aitr); -- on the 4th cycle and every 4th cycle the b read is ignored for timing simplicity 
                --to_B2 <= RAM(bitr);
                to_A_en <= "0001";
                --to_B_en <= "001";
                aitr := aitr + 1;
                --bitr := bitr + 1;
            end if;
            
                
        end if;
    end process clock_proc;
    RAM_91 <= RAM(91); -- Displays the ram
    RAM_92 <= RAM(92);
    RAM_93 <= RAM(93);
    RAM_94 <= RAM(94);
    RAM_95 <= RAM(95);
    RAM_96 <= RAM(96);
    RAM_97 <= RAM(97);
    RAM_98 <= RAM(98);
    RAM_99 <= RAM(99);
    RAM_100 <= RAM(100);
    RAM_101<= RAM(101);
    
    RAM_102 <= RAM(102);
    counter <= count;
end Behavioral;
