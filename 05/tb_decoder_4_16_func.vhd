-- Testbench for f(A,B,C,D) = sum m(2, 5, 7, 8, 13) implemented with a
-- 4:16 decoder. Exhaustively checks all 16 input combinations against a
-- reference function defined by the minterm list.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_decoder_4_16_func is
end entity;

architecture sim of tb_decoder_4_16_func is

    signal abcd : std_logic_vector(3 downto 0) := (others => '0');
    signal f    : std_logic;

    type bit_array is array (0 to 15) of std_logic;
    constant expected : bit_array := (
        2  => '1',
        5  => '1',
        7  => '1',
        8  => '1',
        13 => '1',
        others => '0'
    );

begin

    dut : entity work.decoder_4_16_func
        port map (abcd => abcd, f => f);

    stim : process
    begin
        for i in 0 to 15 loop
            abcd <= std_logic_vector(to_unsigned(i, 4));
            wait for 5 ns;
            assert f = expected(i)
                report "Minterm " & integer'image(i) &
                       " produced unexpected f"
                severity error;
        end loop;
        report "All 16 input combinations verified" severity note;
        wait;
    end process;

end architecture;
