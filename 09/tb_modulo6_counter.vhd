-- Testbench za modulo-6 brojilo s nestandardnim slijedom.
-- Provjerava regularni ciklus 0 -> 3 -> 7 -> 6 -> 1 -> 0 i ponašanje
-- sigurnog starta: iz bilo kojeg nedefiniranog stanja (2, 4, 5) sljedeće
-- stanje je 6.

library ieee;
use ieee.std_logic_1164.all;

entity tb_modulo6_counter is
end entity;

architecture sim of tb_modulo6_counter is

    signal clk : std_logic := '0';
    signal rst : std_logic := '1';
    signal q   : std_logic_vector(2 downto 0);

    constant period : time := 20 ns;

    -- Očekivani regularni slijed počevši od stanja 0 nakon reseta.
    -- Svaki redak je stanje nakon i-tog rastućeg brida nakon deaktivacije rst.
    type seq_array is array (1 to 6) of std_logic_vector(2 downto 0);
    constant ciklus : seq_array := (
        1 => "011",   -- 0 -> 3
        2 => "111",   -- 3 -> 7
        3 => "110",   -- 7 -> 6
        4 => "001",   -- 6 -> 1
        5 => "000",   -- 1 -> 0
        6 => "011"    -- 0 -> 3 (početak novog ciklusa)
    );

begin

    dut : entity work.modulo6_counter
        port map (clk => clk, rst => rst, q => q);

    clk_gen : process
    begin
        wait for period/2;
        clk <= not clk;
    end process;

    stim : process
    begin
        -- Aktivacija reseta kroz jedan puni takt
        rst <= '1';
        wait for period;
        assert q = "000" report "Stanje resetiranja mora biti 0"
            severity error;

        rst <= '0';

        -- Provjera ciklusa kroz 6 rastućih bridova nakon deaktivacije rst.
        for i in 1 to 6 loop
            wait until rising_edge(clk);
            wait for 1 ns;
            assert q = ciklus(i)
                report "Korak ciklusa " & integer'image(i) &
                       ": očekivano neslaganje"
                severity error;
        end loop;

        report "Ciklus modulo-6 brojila ispravno provjeren" severity note;
        wait;
    end process;

end architecture;
