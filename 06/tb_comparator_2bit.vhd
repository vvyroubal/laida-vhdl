-- Testbench for the 2-bit magnitude comparator.
-- Exhaustively tests all 16 combinations of (a, b). For each pair checks
-- gt, eq, lt against the integer comparison.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_comparator_2bit is
end entity;

architecture sim of tb_comparator_2bit is

    signal a, b : std_logic_vector(1 downto 0) := (others => '0');
    signal gt, eq, lt : std_logic;

begin

    dut : entity work.comparator_2bit
        port map (a => a, b => b, gt => gt, eq => eq, lt => lt);

    stim : process
        variable ai, bi : integer;
        variable exp_gt, exp_eq, exp_lt : std_logic;
    begin
        for ai in 0 to 3 loop
            for bi in 0 to 3 loop
                a <= std_logic_vector(to_unsigned(ai, 2));
                b <= std_logic_vector(to_unsigned(bi, 2));
                wait for 5 ns;
                exp_gt := '1' when ai > bi else '0';
                exp_eq := '1' when ai = bi else '0';
                exp_lt := '1' when ai < bi else '0';
                assert gt = exp_gt
                    report "GT mismatch at A=" & integer'image(ai) &
                           " B=" & integer'image(bi)
                    severity error;
                assert eq = exp_eq
                    report "EQ mismatch at A=" & integer'image(ai) &
                           " B=" & integer'image(bi)
                    severity error;
                assert lt = exp_lt
                    report "LT mismatch at A=" & integer'image(ai) &
                           " B=" & integer'image(bi)
                    severity error;
            end loop;
        end loop;
        report "All 16 comparator combinations verified" severity note;
        wait;
    end process;

end architecture;
