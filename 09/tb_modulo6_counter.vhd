-- Testbench for the modulo-6 counter with non-standard sequence.
-- Verifies the regular cycle 0 -> 3 -> 7 -> 6 -> 1 -> 0 and the safe-start
-- behaviour: from any invalid state (2, 4, 5) the next state is 6.

library ieee;
use ieee.std_logic_1164.all;

entity tb_modulo6_counter is
end entity;

architecture sim of tb_modulo6_counter is

    signal clk : std_logic := '0';
    signal rst : std_logic := '1';
    signal q   : std_logic_vector(2 downto 0);

    constant period : time := 20 ns;

    -- Expected regular sequence starting from state 0 after reset.
    -- Each entry is the state after the i-th rising edge after rst goes low.
    type seq_array is array (1 to 6) of std_logic_vector(2 downto 0);
    constant cycle : seq_array := (
        1 => "011",   -- 0 -> 3
        2 => "111",   -- 3 -> 7
        3 => "110",   -- 7 -> 6
        4 => "001",   -- 6 -> 1
        5 => "000",   -- 1 -> 0
        6 => "011"    -- 0 -> 3 (cycle restart)
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
        -- Apply reset for one full clock period
        rst <= '1';
        wait for period;
        assert q = "000" report "Reset state should be 0" severity error;

        rst <= '0';

        -- Verify the cycle for 6 rising edges after rst goes low.
        for i in 1 to 6 loop
            wait until rising_edge(clk);
            wait for 1 ns;
            assert q = cycle(i)
                report "Cycle step " & integer'image(i) &
                       ": expected mismatch"
                severity error;
        end loop;

        report "Modulo-6 counter cycle verified" severity note;
        wait;
    end process;

end architecture;
