-- Testbench for the 10111101 sequence generator.
-- Resets, then verifies that the output Y follows the expected pattern
-- 1, 0, 1, 1, 1, 1, 0, 1 for 8 consecutive clock periods, and continues
-- to repeat starting from the 9th period.

library ieee;
use ieee.std_logic_1164.all;

entity tb_seq_gen_10111101 is
end entity;

architecture sim of tb_seq_gen_10111101 is

    signal clk : std_logic := '0';
    signal rst : std_logic := '1';
    signal y   : std_logic;

    constant period : time := 20 ns;

    -- Expected first 16 bits (two full cycles): 10111101 10111101
    type bit_array is array (1 to 16) of std_logic;
    constant expected : bit_array := (
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

        -- The Johnson counter starts in state 0000 (after reset).
        -- Before the first rising edge after rst='0', y reflects state 0000
        -- which encodes bit 1 of the sequence (logic '1').
        wait for 1 ns;
        assert y = expected(1)
            report "Bit 1 expected " & std_logic'image(expected(1)) &
                   " but got " & std_logic'image(y)
            severity error;

        -- Subsequent bits appear after each rising edge.
        for i in 2 to 16 loop
            wait until rising_edge(clk);
            wait for 1 ns;
            assert y = expected(i)
                report "Bit " & integer'image(i) &
                       " expected " & std_logic'image(expected(i)) &
                       " but got " & std_logic'image(y)
                severity error;
        end loop;

        report "Sequence 10111101 verified over two full cycles"
            severity note;
        wait;
    end process;

end architecture;
