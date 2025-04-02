library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity echo_top is
  Port (
        clk, TXD : in std_logic;
        RXD, CTS, RTS : out std_logic);
end echo_top;

architecture Behavioral of echo_top is

component clock_div
    port(
        clk : in std_logic;
        div : out std_logic);
end component;

component echo
    port(
        clk : in std_logic;
        en : in std_logic;
        ready : in std_logic;
        newchar : in std_logic;
        charin : in std_logic_vector(7 downto 0);
        send : out std_logic;
        charout : out std_logic_vector(7 downto 0));
end component;

component uart
    port (
        clk, en, send, rx, rst : in std_logic;
        charSend               : in std_logic_vector (7 downto 0);
        ready, tx, newChar     : out std_logic;
        charRec                : out std_logic_vector (7 downto 0)
    );
end component;

-- Intermediate signals
signal div_out : std_logic;
signal ready_r, send_s, newChar_s : std_logic;
signal char_c, char_received : std_logic_vector(7 downto 0);

begin
    RTS <= '0';
    CTS <= '0';

    U1 : clock_div
        port map (
            clk => clk,
            div  => div_out
        );

    U2 : uart
        port map(
            clk => clk,
            en => div_out,
            send => send_s,
            rx => TXD,
            rst => '0',
            charSend => char_c,
            ready => ready_r,
            tx => RXD,
            newChar => newChar_s,
            charRec => char_received
        );

    U3 : echo
        port map (
            clk => clk,
            en => div_out,
            ready => ready_r,
            newchar => newChar_s,
            charin => char_received,
            send => send_s,
            charout => char_c
        );

end Behavioral;