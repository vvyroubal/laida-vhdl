-- Testbench for the D flip-flop built from JK.
-- Drives D through a sequence covering all four transition cases and
-- checks Q against the expected next state.

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
        -- D=0 (Q starts at 0): stays 0
        d <= '0';
        wait for period;
        assert q = '0' report "D=0 (Q was 0), expected Q=0" severity error;

        -- D=1: capture 1
        d <= '1';
        wait for period;
        assert q = '1' report "D=1 (Q was 0), expected Q=1" severity error;

        -- D=1: hold at 1
        d <= '1';
        wait for period;
        assert q = '1' report "D=1 (Q was 1), expected Q=1" severity error;

        -- D=0: capture 0
        d <= '0';
        wait for period;
        assert q = '0' report "D=0 (Q was 1), expected Q=0" severity error;

        report "D flip-flop from JK verified" severity note;
        wait;
    end process;

end architecture;
