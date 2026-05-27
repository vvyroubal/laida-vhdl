-- Testbench for the traffic light controller.
-- Verifies that after reset the automaton starts in RED, and that each
-- TICK pulse advances to the next phase, in order
-- RED -> RED_YELLOW -> GREEN -> YELLOW -> RED.

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
        -- Initial reset, automaton enters RED
        rst  <= '1';
        tick <= '0';
        wait for 3 * T;
        rst  <= '0';
        wait until falling_edge(clk);
        assert (r='1' and y='0' and g='0')
            report "Initial state: expected RED (1,0,0)" severity error;

        -- TICK -> RED_YELLOW
        tick <= '1';
        wait until falling_edge(clk);
        tick <= '0';
        assert (r='1' and y='1' and g='0')
            report "After 1st TICK: expected RED_YELLOW (1,1,0)" severity error;

        -- TICK -> GREEN
        tick <= '1';
        wait until falling_edge(clk);
        tick <= '0';
        assert (r='0' and y='0' and g='1')
            report "After 2nd TICK: expected GREEN (0,0,1)" severity error;

        -- TICK -> YELLOW
        tick <= '1';
        wait until falling_edge(clk);
        tick <= '0';
        assert (r='0' and y='1' and g='0')
            report "After 3rd TICK: expected YELLOW (0,1,0)" severity error;

        -- TICK -> RED (cycle closed)
        tick <= '1';
        wait until falling_edge(clk);
        tick <= '0';
        assert (r='1' and y='0' and g='0')
            report "After 4th TICK: expected return to RED (1,0,0)" severity error;

        report "tb_semafor: 4-phase cycle successfully verified" severity note;
        wait;
    end process;
end architecture;
