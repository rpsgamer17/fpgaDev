library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ripple_adder is
   Port(
        A, B : in std_logic_vector(3 downto 0);
        Cin : in std_logic;
        S : out std_logic_vector(3 downto 0);
        Cout : out std_logic
    );
end ripple_adder;

architecture Structure of ripple_adder is
    component adder is
        Port(
        A, B, Cin : in std_logic;
        S, Cout : out std_logic  
    );
end component;

    
    signal adder_out : std_logic_vector(0 to 3); 
    
begin
    add0 : adder 
    port map( 
         A => A(0), 
         B => B(0), 
         Cin => Cin,
         S => S(0),
         Cout => adder_out(0)
        
        );
        
    add1 : adder 
    port map( 
         A => A(1), 
         B => B(1), 
         Cin => adder_out(0),
         S => S(1),
         Cout => adder_out(1)
        
        );
        
    add2 : adder 
    port map( 
         A => A(2), 
         B => B(2), 
         Cin => adder_out(1),
         S => S(2),
         Cout => adder_out(2)
        
        );
        
    add3 : adder 
    port map( 
         A => A(3), 
         B => B(3), 
         Cin => adder_out(2),
         S => S(3),
         Cout => adder_out(3)
        
        );
    
    Cout <= adder_out(3);
    

end Structure;
