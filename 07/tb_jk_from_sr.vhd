-- Testbench za JK bistabil izgrađen iz SR.
-- Pokreće J,K kroz slijed koji pokriva sva četiri načina rada
-- (zadržavanje, brisanje, postavljanje, promjena stanja).

library ieee;
use ieee.std_logic_1164.all;

entity tb_jk_from_sr is
end entity;

architecture sim of tb_jk_from_sr is

    signal clk : std_logic := '0';
    signal j, k : std_logic := '0';
    signal q, qn : std_logic;

    constant period : time := 20 ns;

begin

    dut : entity work.jk_from_sr
        port map (clk => clk, j => j, k => k, q => q, qn => qn);

    clk_gen : process
    begin
        wait for period/2;
        clk <= not clk;
    end process;

    stim : process
    begin
        -- Q kreće s 0.
        -- JK=00: zadržavanje (Q=0)
        j <= '0'; k <= '0';
        wait for period;
        assert q = '0' report "JK=00 (Q je bio 0), ocekivano Q=0" severity error;

        -- JK=10: postavljanje (Q -> 1)
        j <= '1'; k <= '0';
        wait for period;
        assert q = '1' report "JK=10, ocekivano Q=1" severity error;

        -- JK=00: zadržavanje (Q=1)
        j <= '0'; k <= '0';
        wait for period;
        assert q = '1' report "JK=00 (Q je bio 1), ocekivano Q=1" severity error;

        -- JK=01: brisanje (Q -> 0)
        j <= '0'; k <= '1';
        wait for period;
        assert q = '0' report "JK=01, ocekivano Q=0" severity error;

        -- JK=11: promjena stanja (Q -> 1)
        j <= '1'; k <= '1';
        wait for period;
        assert q = '1' report "JK=11 (Q je bio 0), ocekivano Q=1" severity error;

        -- JK=11: promjena stanja (Q -> 0)
        j <= '1'; k <= '1';
        wait for period;
        assert q = '0' report "JK=11 (Q je bio 1), ocekivano Q=0" severity error;

        report "JK bistabil iz SR ispravno provjeren" severity note;
        wait;
    end process;

end architecture;
