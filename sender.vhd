----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/25/2025 01:10:33 PM
-- Design Name: 
-- Module Name: sender - Behavioral
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sender is
    Port ( rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           en : in STD_LOGIC;
           btn : in STD_LOGIC;
           ready : in STD_LOGIC;
           send : out STD_LOGIC;
           char : out STD_LOGIC_VECTOR (7 downto 0));
end sender;

architecture Behavioral of sender is
    signal i : std_logic_vector(3 downto 0) := (others => '0');
    type state_type is (idle, busyA, busyB, busyC);
    signal state : state_type := idle; 
    type net_array is array (0 to 5) of std_logic_vector(7 downto 0);
    constant netId : net_array := (
    0 => "01110010",
    1 => "01110011",
    2 => "00110010",
    3 => "00110001",
    4 => "00110100",
    5 => "00110111",
    others => "00000000");

begin
    process(clk) 
    begin 
        if rising_edge(clk) then 
            if rst = '1' then
                send <= '0'; 
                char <= (others => '0');
                i <= (others => '0');
                state <= idle;

            elsif en = '1' then   
                case state is 
                    when idle => 
                        if ready = '1' and btn = '1' and unsigned(i) = 6 then  
                            i <= (others => '0');
                            state <= idle;
                        elsif ready = '1' and btn = '1' and unsigned(i) < 6 then     
                            send <= '1';
                            char <= netId(to_integer(unsigned(i)));
                            i <= std_logic_vector(unsigned(i) + 1);
                            state <= busyA; 
                        end if; 
                    
                    when busyA => 
                        state <= busyB; 
                    when busyB => 
                        send <= '0';
                        state <= busyC;
                    when busyC => 
                        if ready = '1' and btn = '0' then 
                            state <= idle; 
                        end if; 
                    when others =>
                        state <= idle;
                end case;
            end if; 
        end if;
    end process; 
end Behavioral;
