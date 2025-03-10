library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity adder is
   Port(
        A, B, Cin : in std_logic;
        S, Cout : out std_logic  
    );
end adder;

architecture Behavioral of adder is

begin
    S <= A xor B xor Cin;
    Cout <= (A and B) or ((A xor B) and Cin); 
    

end Behavioral;
