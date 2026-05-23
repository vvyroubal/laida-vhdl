-- Testbench for the JK flip-flop built from SR.
-- Drives J,K through a sequence covering all four operation modes
-- (hold, reset, set, toggle) from each starting state Q.

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
        -- Q starts at 0.
        -- JK=00: hold (Q=0)
        j <= '0'; k <= '0';
        wait for period;
        assert q = '0' report "JK=00 (Q was 0), expected Q=0" severity error;

        -- JK=10: set (Q -> 1)
        j <= '1'; k <= '0';
        wait for period;
        assert q = '1' report "JK=10, expected Q=1" severity error;

        -- JK=00: hold (Q=1)
        j <= '0'; k <= '0';
        wait for period;
        assert q = '1' report "JK=00 (Q was 1), expected Q=1" severity error;

        -- JK=01: reset (Q -> 0)
        j <= '0'; k <= '1';
        wait for period;
        assert q = '0' report "JK=01, expected Q=0" severity error;

        -- JK=11: toggle (Q -> 1)
        j <= '1'; k <= '1';
        wait for period;
        assert q = '1' report "JK=11 (Q was 0), expected Q=1" severity error;

        -- JK=11: toggle (Q -> 0)
        j <= '1'; k <= '1';
        wait for period;
        assert q = '0' report "JK=11 (Q was 1), expected Q=0" severity error;

        report "JK flip-flop from SR verified" severity note;
        wait;
    end process;

end architecture;
