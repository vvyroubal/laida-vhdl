-- Testbench for the 4-bit up/down binary counter.
-- After reset, counts up through one full 16-state cycle and back to 0,
-- then switches direction and counts down through another full cycle.
-- Verifies each state with assert.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_up_down_counter_4bit is
end entity;

architecture sim of tb_up_down_counter_4bit is

    signal clk : std_logic := '0';
    signal rst : std_logic := '1';
    signal dir : std_logic := '0';
    signal q   : std_logic_vector(3 downto 0);

    constant period : time := 20 ns;

begin

    dut : entity work.up_down_counter_4bit
        port map (clk => clk, rst => rst, dir => dir, q => q);

    clk_gen : process
    begin
        wait for period/2;
        clk <= not clk;
    end process;

    stim : process
    begin
        -- Reset, count up direction
        rst <= '1'; dir <= '0';
        wait for period;
        assert q = "0000" report "Reset state should be 0" severity error;
        rst <= '0';

        -- Verify up-count: 1, 2, ..., 15, 0
        for i in 1 to 16 loop
            wait until rising_edge(clk);
            wait for 1 ns;
            assert unsigned(q) = to_unsigned(i mod 16, 4)
                report "Up count " & integer'image(i mod 16) & " mismatch"
                severity error;
        end loop;

        -- Switch direction: now Q is 0, counting down: 15, 14, ..., 1, 0
        dir <= '1';
        for i in 1 to 16 loop
            wait until rising_edge(clk);
            wait for 1 ns;
            assert unsigned(q) = to_unsigned((16 - i) mod 16, 4)
                report "Down count " & integer'image((16 - i) mod 16) &
                       " mismatch"
                severity error;
        end loop;

        report "Up/down counter verified" severity note;
        wait;
    end process;

end architecture;
