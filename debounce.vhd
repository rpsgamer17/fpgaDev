library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

entity debounce is
    port(

        clk : in std_logic;
        btn : in std_logic;
        dbnc : out std_logic
        
    );


end debounce;

architecture behavior of debounce is 
    signal btn_signal : std_logic;
    signal shifter2 : std_logic_vector(1 downto 0) := "00";  
    signal counter : std_logic_vector(21 downto 0) := (others => '0'); 
    signal dbnc_sig : std_logic := '0';
    signal inv_reset : std_logic := '1';
begin
    process(clk)
    begin 
        if rising_edge(clk) then 
            shifter2(0) <= btn;
            shifter2(1) <= shifter2(0);
             
                if shifter2(1) = '1' then 
                    if unsigned(counter) < 499999 then 
                        counter <= std_logic_vector(unsigned(counter) + 1);
                        dbnc_sig <= '0';
                    elsif unsigned(counter) = 499999 then
                        dbnc_sig <= '1';
                    end if;
                else 
                    counter <= (others => '0');
                    dbnc_sig <= '0';
                    
                end if;
            end if; 
    end process;
    
    dbnc <= dbnc_sig;
 end behavior;   
                
               