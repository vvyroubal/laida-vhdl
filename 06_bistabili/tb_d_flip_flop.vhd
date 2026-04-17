library ieee;
use ieee.std_logic_1164.all;

entity tb_d_flip_flop is
end entity;

architecture sim of tb_d_flip_flop is
    signal clk, rst, d : std_logic := '0';
    signal q, q_n      : std_logic;

    constant T : time := 10 ns;
begin
    uut: entity work.d_flip_flop
        port map(clk => clk, rst => rst, d => d, q => q, q_n => q_n);

    clk <= not clk after T / 2;

    process
    begin
        rst <= '1';              wait for 2 * T;
        rst <= '0';

        d <= '1';                wait for T;
        d <= '0';                wait for T;
        d <= '1';                wait for T;
        d <= '1';                wait for T;
        d <= '0';                wait for T;
        d <= '0';                wait for T;
        d <= '1';                wait for T;

        rst <= '1';              wait for T;
        rst <= '0';
        d   <= '1';              wait for 2 * T;
        wait;
    end process;
end architecture;
