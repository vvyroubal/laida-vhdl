-- Testbench za generator niza 10111101.
-- Resetira sklop pa provjerava da izlaz Y slijedi očekivani uzorak
-- 1, 0, 1, 1, 1, 1, 0, 1 kroz 8 uzastopnih perioda takta, te se nastavlja
-- ponavljati počevši od 9. perioda.

library ieee;
use ieee.std_logic_1164.all;

entity tb_seq_gen_10111101 is
end entity;

architecture sim of tb_seq_gen_10111101 is

    signal clk : std_logic := '0';
    signal rst : std_logic := '1';
    signal y   : std_logic;

    constant period : time := 20 ns;

    -- Očekivanih prvih 16 bitova (dva puna ciklusa): 10111101 10111101
    type bit_array is array (1 to 16) of std_logic;
    constant ocekivano : bit_array := (
        1 => '1', 2 => '0', 3 => '1', 4 => '1',
        5 => '1', 6 => '1', 7 => '0', 8 => '1',
        9 => '1', 10 => '0', 11 => '1', 12 => '1',
        13 => '1', 14 => '1', 15 => '0', 16 => '1'
    );

begin

    dut : entity work.seq_gen_10111101
        port map (clk => clk, rst => rst, y => y);

    clk_gen : process
    begin
        wait for period/2;
        clk <= not clk;
    end process;

    stim : process
    begin
        rst <= '1';
        wait for period;
        rst <= '0';

        -- Johnsonovo brojilo kreće u stanju 0000 (nakon reseta).
        -- Prije prvog rastućeg brida nakon rst='0', y odražava stanje 0000
        -- koje kodira bit 1 niza (logička '1').
        wait for 1 ns;
        assert y = ocekivano(1)
            report "Bit 1 ocekivano " & std_logic'image(ocekivano(1)) &
                   " dobiveno " & std_logic'image(y)
            severity error;

        -- Naredni bitovi pojavljuju se nakon svakog rastućeg brida.
        for i in 2 to 16 loop
            wait until rising_edge(clk);
            wait for 1 ns;
            assert y = ocekivano(i)
                report "Bit " & integer'image(i) &
                       " ocekivano " & std_logic'image(ocekivano(i)) &
                       " dobiveno " & std_logic'image(y)
                severity error;
        end loop;

        report "Niz 10111101 ispravno provjeren kroz dva puna ciklusa"
            severity note;
        wait;
    end process;

end architecture;
