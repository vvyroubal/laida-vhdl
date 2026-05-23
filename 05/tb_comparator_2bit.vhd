-- Testbench za 2-bitni komparator veličine.
-- Iscrpno provjerava svih 16 kombinacija (a, b). Za svaki par uspoređuje
-- gt, eq, lt s cjelobrojnom usporedbom.

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
        variable oc_gt, oc_eq, oc_lt : std_logic;
    begin
        for ai in 0 to 3 loop
            for bi in 0 to 3 loop
                a <= std_logic_vector(to_unsigned(ai, 2));
                b <= std_logic_vector(to_unsigned(bi, 2));
                wait for 5 ns;
                oc_gt := '1' when ai > bi else '0';
                oc_eq := '1' when ai = bi else '0';
                oc_lt := '1' when ai < bi else '0';
                assert gt = oc_gt
                    report "GT pogreška: A=" & integer'image(ai) &
                           " B=" & integer'image(bi)
                    severity error;
                assert eq = oc_eq
                    report "EQ pogreška: A=" & integer'image(ai) &
                           " B=" & integer'image(bi)
                    severity error;
                assert lt = oc_lt
                    report "LT pogreška: A=" & integer'image(ai) &
                           " B=" & integer'image(bi)
                    severity error;
            end loop;
        end loop;
        report "Svih 16 kombinacija komparatora ispravno provjereno"
            severity note;
        wait;
    end process;

end architecture;
