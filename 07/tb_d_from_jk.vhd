-- Testbench za D bistabil izgrađen iz JK.
-- Pokreće D kroz slijed koji pokriva sva četiri slučaja prijelaza i
-- provjerava Q protiv očekivanog sljedećeg stanja.

library ieee;
use ieee.std_logic_1164.all;

entity tb_d_from_jk is
end entity;

architecture sim of tb_d_from_jk is

    signal clk : std_logic := '0';
    signal d   : std_logic := '0';
    signal q   : std_logic;
    signal qn  : std_logic;

    constant period : time := 20 ns;

begin

    dut : entity work.d_from_jk
        port map (clk => clk, d => d, q => q, qn => qn);

    clk_gen : process
    begin
        wait for period/2;
        clk <= not clk;
    end process;

    stim : process
    begin
        -- D=0 (Q kreće s 0): ostaje 0
        d <= '0';
        wait for period;
        assert q = '0' report "D=0 (Q je bio 0), očekivano Q=0" severity error;

        -- D=1: postavlja se 1
        d <= '1';
        wait for period;
        assert q = '1' report "D=1 (Q je bio 0), očekivano Q=1" severity error;

        -- D=1: zadržava 1
        d <= '1';
        wait for period;
        assert q = '1' report "D=1 (Q je bio 1), očekivano Q=1" severity error;

        -- D=0: postavlja se 0
        d <= '0';
        wait for period;
        assert q = '0' report "D=0 (Q je bio 1), očekivano Q=0" severity error;

        report "D bistabil iz JK ispravno provjeren" severity note;
        wait;
    end process;

end architecture;
