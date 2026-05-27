-- Testbench za upravljač semafora.
-- Provjerava da automat nakon reseta polazi iz CRVENO i da svaki TICK
-- puls napreduje u sljedeću fazu, redom CRVENO -> CRVENO_ZUTO -> ZELENO
-- -> ZUTO -> CRVENO.

library ieee;
use ieee.std_logic_1164.all;

entity tb_semafor is
end entity;

architecture sim of tb_semafor is
    signal clk, rst, tick : std_logic := '0';
    signal r, y, g        : std_logic;
    constant T : time := 10 ns;
begin
    uut: entity work.semafor
        port map (clk => clk, rst => rst, tick => tick,
                  r => r, y => y, g => g);

    clk <= not clk after T / 2;

    process
    begin
        -- Početni reset, automat ulazi u CRVENO
        rst  <= '1';
        tick <= '0';
        wait for 3 * T;
        rst  <= '0';
        wait until falling_edge(clk);
        assert (r='1' and y='0' and g='0')
            report "Pocetno stanje: ocekivano CRVENO (1,0,0)" severity error;

        -- TICK -> CRVENO_ZUTO
        tick <= '1';
        wait until falling_edge(clk);
        tick <= '0';
        assert (r='1' and y='1' and g='0')
            report "Nakon 1. TICK: ocekivano CRVENO_ZUTO (1,1,0)" severity error;

        -- TICK -> ZELENO
        tick <= '1';
        wait until falling_edge(clk);
        tick <= '0';
        assert (r='0' and y='0' and g='1')
            report "Nakon 2. TICK: ocekivano ZELENO (0,0,1)" severity error;

        -- TICK -> ZUTO
        tick <= '1';
        wait until falling_edge(clk);
        tick <= '0';
        assert (r='0' and y='1' and g='0')
            report "Nakon 3. TICK: ocekivano ZUTO (0,1,0)" severity error;

        -- TICK -> CRVENO (ciklus zatvoren)
        tick <= '1';
        wait until falling_edge(clk);
        tick <= '0';
        assert (r='1' and y='0' and g='0')
            report "Nakon 4. TICK: ocekivan povratak u CRVENO (1,0,0)" severity error;

        report "tb_semafor: 4-fazni ciklus uspjesno provjeren" severity note;
        wait;
    end process;
end architecture;
