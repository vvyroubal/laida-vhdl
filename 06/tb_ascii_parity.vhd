-- Testbench za ASCII koder s parnim paritetom.
-- Provjerava kodiranje stringa "VTSBJ" protiv referentne tablice iz
-- teksta riješenog primjera.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_ascii_parity is
end entity;

architecture sim of tb_ascii_parity is

    signal ascii_in : std_logic_vector(6 downto 0) := (others => '0');
    signal encoded  : std_logic_vector(7 downto 0);

    type char_test is record
        ascii      : integer;
        ocekivano  : std_logic_vector(7 downto 0);
        slovo      : character;
    end record;

    type char_test_array is array (natural range <>) of char_test;

    constant testovi : char_test_array := (
        ( 86, "01010110", 'V' ),   -- V: 1010110, 4 jedinice (par)   -> p=0
        ( 84, "11010100", 'T' ),   -- T: 1010100, 3 jedinice (nepar) -> p=1
        ( 83, "01010011", 'S' ),   -- S: 1010011, 4 jedinice (par)   -> p=0
        ( 66, "01000010", 'B' ),   -- B: 1000010, 2 jedinice (par)   -> p=0
        ( 74, "11001010", 'J' )    -- J: 1001010, 3 jedinice (nepar) -> p=1
    );

begin

    dut : entity work.ascii_parity
        port map (ascii_in => ascii_in, encoded => encoded);

    stim : process
    begin
        for i in testovi'range loop
            ascii_in <= std_logic_vector(to_unsigned(testovi(i).ascii, 7));
            wait for 5 ns;
            assert encoded = testovi(i).ocekivano
                report "Znak '" & testovi(i).slovo & "' (ASCII " &
                       integer'image(testovi(i).ascii) & ") ocekivano " &
                       to_string(testovi(i).ocekivano) & ", dobiveno " &
                       to_string(encoded)
                severity error;
        end loop;

        report "ASCII paritet kodiranje VTSBJ ispravno provjereno"
            severity note;
        wait;
    end process;

end architecture;
