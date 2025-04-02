---------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 03/15/2025 02:56:08 PM
-- Design Name:
-- Module Name: uart_tx - Behavioral
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
use IEEE.NUMERIC_STD.ALL;


entity uart_tx is
    Port (
        clk, en, send, rst : in std_logic;
        char : in std_logic_vector(7 downto 0);
        ready, tx : out std_logic);
end uart_tx;

architecture fsm of uart_tx is
    type state_type is (idle, start, stop, data);
    signal state : state_type;
    signal d : std_logic_vector (7 downto 0) := (others => '0');
    signal count : std_logic_vector(3 downto 0) := (others => '0');
 
begin
    process(clk)
begin
    if rising_edge(clk) then
        if rst = '1' then
            state <= idle;
            d <= (others => '0');
            count <= (others => '0');
            tx <= '1';
            ready <= '1';

        elsif en = '1' then
            case state is
                when idle =>
                    tx <= '1';
                    ready <= '1';
                    if send = '1' then
                        d <= char;
                        state <= start;
                    end if;
                
                when start =>
                    tx <= '0';
                    count <= (others => '0');
                    state <= data;
                    ready <= '0';
                

                when data =>
                    tx <= d(0);
                    d <= std_logic_vector(shift_right(unsigned(d), 1));
                    
                    if unsigned(count) < 7 then
                        count <= std_logic_vector(unsigned(count) + 1);
                    else
                        state <= stop;
                    end if;

                when stop =>
                    tx <= '1';
                    state <= idle;

                when others =>
                    state <= idle;
            end case;
        end if;
    end if;
end process;


       
   
end fsm;