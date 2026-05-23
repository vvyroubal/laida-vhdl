-- Testbench for the ASCII-with-even-parity encoder.
-- Verifies the encoding of the string "VTSBJ" against the reference
-- table in the worked-example text.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_ascii_parity is
end entity;

architecture sim of tb_ascii_parity is

    signal ascii_in : std_logic_vector(6 downto 0) := (others => '0');
    signal encoded  : std_logic_vector(7 downto 0);

    type char_test is record
        ascii    : integer;
        expected : std_logic_vector(7 downto 0);
        letter   : character;
    end record;

    type char_test_array is array (natural range <>) of char_test;

    constant tests : char_test_array := (
        ( 86, "01010110", 'V' ),   -- V: 1010110, 4 ones (even) -> p=0
        ( 84, "11010100", 'T' ),   -- T: 1010100, 3 ones (odd)  -> p=1
        ( 83, "01010011", 'S' ),   -- S: 1010011, 4 ones (even) -> p=0
        ( 66, "01000010", 'B' ),   -- B: 1000010, 2 ones (even) -> p=0
        ( 74, "11001010", 'J' )    -- J: 1001010, 3 ones (odd)  -> p=1
    );

begin

    dut : entity work.ascii_parity
        port map (ascii_in => ascii_in, encoded => encoded);

    stim : process
    begin
        for i in tests'range loop
            ascii_in <= std_logic_vector(to_unsigned(tests(i).ascii, 7));
            wait for 5 ns;
            assert encoded = tests(i).expected
                report "Character '" & tests(i).letter & "' (ASCII " &
                       integer'image(tests(i).ascii) & ") expected " &
                       to_string(tests(i).expected) & ", got " &
                       to_string(encoded)
                severity error;
        end loop;

        report "ASCII parity encoding of VTSBJ verified" severity note;
        wait;
    end process;

end architecture;
