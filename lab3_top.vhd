----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/27/2025 03:03:02 PM
-- Design Name: 
-- Module Name: lab3_top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity lab3_top is
    Port (
        clk, TXD : in std_logic;
        btn : in std_logic_vector(1 downto 0);
        RXD : out std_logic
        
        
        
        
     );
end lab3_top;

architecture Behavioral of lab3_top is
    signal dbnc_out1, dbnc_out2, div_sig, send_sig, ready_sig, tx_out : std_logic; 
    signal char_sig : std_logic_vector(7 downto 0); 


    component debounce is 
        port(
            clk : in std_logic;
            btn : in std_logic;
            dbnc : out std_logic  
        );
    end component; 

    component clock_div is 
        port(
            clk  : in std_logic;
            div : out std_logic
   
        );
  
    end component; 
    
    component sender is 
        port(
           rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           en : in STD_LOGIC;
           btn : in STD_LOGIC;
           ready : in STD_LOGIC;
           send : out STD_LOGIC;
           char : out STD_LOGIC_VECTOR (7 downto 0)
   
        );
  
    end component; 
    
    component uart is 
        port(
           clk, en, send, rx, rst : in std_logic;
           charSend               : in std_logic_vector (7 downto 0);
           ready, tx, newChar     : out std_logic;
           charRec                : out std_logic_vector (7 downto 0)
   
        );
  
    end component; 

begin
    u1: debounce
    port map (
        clk  => clk,
        btn  => btn(0),
        dbnc => dbnc_out1
    );
    
    u2: debounce
    port map (
        clk  => clk,
        btn  => btn(1),
        dbnc => dbnc_out2
    );
    
    u3: clock_div
    port map (
        clk => clk,
        div => div_sig
    );
    
    u4: sender
    port map (
        clk    => clk,
        rst    => dbnc_out1,
        en     => div_sig,
        btn    => dbnc_out2,
        ready  => ready_sig,
        send   => send_sig,
        char   => char_sig
    );
    
      u5: uart
    port map (
        clk      => clk,
        en       => div_sig,
        send     => send_sig,
        rx       => TXD,     
        rst      => dbnc_out1,
        charSend => char_sig,
        ready    => ready_sig,
        tx       => tx_out
        --newChar  => open,
        --charRec  => open
    );

    RXD <= tx_out;

end Behavioral;
