-- Testbench za T bistabil izgrađen iz JK.
-- Provjerava četiri slučaja prijelaza (T=0/1, Q=0/1) protiv tablice
-- očekivanih sljedećih stanja.

library ieee;
use ieee.std_logic_1164.all;

entity tb_t_from_jk is
end entity;

architecture sim of tb_t_from_jk is

    signal clk : std_logic := '0';
    signal t   : std_logic := '0';
    signal q   : std_logic;
    signal qn  : std_logic;

    constant period : time := 20 ns;

begin

    dut : entity work.t_from_jk
        port map (clk => clk, t => t, q => q, qn => qn);

    clk_gen : process
    begin
        wait for period/2;
        clk <= not clk;
    end process;

    stim : process
    begin
        -- T=0, Q kreće s 0: ostaje 0
        t <= '0';
        wait for period;
        assert q = '0' report "T=0, Q ocekivano 0, dobiveno 1" severity error;

        -- T=1: prelazi u 1
        t <= '1';
        wait for period;
        assert q = '1' report "T=1, Q ocekivano 1, dobiveno 0" severity error;

        -- T=0: zadržava 1
        t <= '0';
        wait for period;
        assert q = '1' report "T=0, Q ocekivano 1, dobiveno 0" severity error;

        -- T=1: prelazi u 0
        t <= '1';
        wait for period;
        assert q = '0' report "T=1, Q ocekivano 0, dobiveno 1" severity error;

        report "T bistabil iz JK ispravno provjeren" severity note;
        wait;
    end process;

end architecture;
