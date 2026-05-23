-- Testbench for BCD to 7-segment decoder.
-- Iterates over all 16 input combinations and checks the output against
-- a reference table. Reports an error via assert if any digit fails.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_bcd_to_7seg is
end entity;

architecture sim of tb_bcd_to_7seg is

    signal bcd : std_logic_vector(3 downto 0) := (others => '0');
    signal seg : std_logic_vector(6 downto 0);

    type seg_array is array (0 to 15) of std_logic_vector(6 downto 0);
    constant expected : seg_array := (
        "1111110",   -- 0
        "0110000",   -- 1
        "1101101",   -- 2
        "1111001",   -- 3
        "0110011",   -- 4
        "1011011",   -- 5
        "1011111",   -- 6
        "1110000",   -- 7
        "1111111",   -- 8
        "1111011",   -- 9
        "0000000",   -- 10 (invalid)
        "0000000",   -- 11
        "0000000",   -- 12
        "0000000",   -- 13
        "0000000",   -- 14
        "0000000"    -- 15
    );

begin

    dut : entity work.bcd_to_7seg
        port map (bcd => bcd, seg => seg);

    stim : process
    begin
        for i in 0 to 15 loop
            bcd <= std_logic_vector(to_unsigned(i, 4));
            wait for 10 ns;
            assert seg = expected(i)
                report "BCD " & integer'image(i) &
                       " produced unexpected segment pattern"
                severity error;
        end loop;
        report "All 16 BCD inputs verified" severity note;
        wait;
    end process;

end architecture;
