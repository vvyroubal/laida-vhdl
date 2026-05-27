-- Testbench za 4-bitno paralelno zbrajalo s rasprostiranjem prijenosa.
-- Iscrpno testira svih 2 * 16 * 16 = 1024 kombinacija c_in, A, B
-- protiv referentnog zbroja (A + B + c_in modulo 32). Provjerava
-- 4-bitnu sumu i izlazni prijenos pomoću assert iskaza.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_ripple_adder_4bit is
end entity;

architecture sim of tb_ripple_adder_4bit is

    signal a, b   : std_logic_vector(3 downto 0) := (others => '0');
    signal c_in   : std_logic := '0';
    signal sum    : std_logic_vector(3 downto 0);
    signal c_out  : std_logic;

begin

    dut : entity work.ripple_adder_4bit
        port map (a => a, b => b, c_in => c_in, sum => sum, c_out => c_out);

    stim : process
        variable ai, bi, ci, ocekivano : integer;
        variable rezultat : unsigned(4 downto 0);
    begin
        for ci in 0 to 1 loop
            for ai in 0 to 15 loop
                for bi in 0 to 15 loop
                    a    <= std_logic_vector(to_unsigned(ai, 4));
                    b    <= std_logic_vector(to_unsigned(bi, 4));
                    c_in <= '0' when ci = 0 else '1';
                    wait for 5 ns;
                    ocekivano := ai + bi + ci;
                    rezultat  := unsigned(c_out & sum);
                    assert to_integer(rezultat) = ocekivano
                        report "Pogreska zbrajanja: A=" & integer'image(ai) &
                               " B=" & integer'image(bi) &
                               " Cin=" & integer'image(ci) &
                               " ocekivano=" & integer'image(ocekivano) &
                               " dobiveno=" & integer'image(to_integer(rezultat))
                        severity error;
                end loop;
            end loop;
        end loop;
        report "Svih 1024 kombinacija zbrajala ispravno provjereno"
            severity note;
        wait;
    end process;

end architecture;
