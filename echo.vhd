----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/29/2025 02:38:02 PM
-- Design Name: 
-- Module Name: echo - Behavioral
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

entity echo is
    Port ( clk : in STD_LOGIC;
           en : in STD_LOGIC;
           ready : in STD_LOGIC;
           newChar : in STD_LOGIC;
           charIn : in STD_LOGIC_VECTOR (7 downto 0);
           send : out STD_LOGIC;
           charOut : out STD_LOGIC_VECTOR (7 downto 0));
           
end echo;

architecture Behavioral of echo is
    type state_type is (idle, busyA, busyB, busyC);
    signal state : state_type := idle; 
begin
process(clk) 
    begin 
        if rising_edge(clk) then  
            if en = '1' then   
                case state is 
                    when idle => 
                        if newChar = '1' then
                            send <= '1';
                            charOut <= charIn;
                            state <= busyA;
                        end if; 
                    
                    when busyA => 
                        state <= busyB; 
                    when busyB => 
                        send <= '0';
                        state <= busyC;
                    when busyC => 
                        if ready = '1' then
                            state <= idle;
                        end if;
                    when others =>
                        state <= idle;
                end case;
            end if; 
        end if;
    end process;

end Behavioral;
