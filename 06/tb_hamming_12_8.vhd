-- Testbench za Hamming (12, 8) koder i dekoder/ispravljač.
-- 1. Kodira D = 10101010 i provjerava kodnu riječ protiv analitičkog
--    rezultata 111101001010 (pozicije 1..12).
-- 2. Ubacuje jednobitnu pogrešku na poziciju 7 i provjerava da dekoder:
--      - prijavi sindrom = 7
--      - rekonstruira izvorni D = 10101010

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_hamming_12_8 is
end entity;

architecture sim of tb_hamming_12_8 is

    signal data_in   : std_logic_vector(7 downto 0);
    signal cw        : std_logic_vector(11 downto 0);
    signal cw_err    : std_logic_vector(11 downto 0);
    signal data_out  : std_logic_vector(7 downto 0);
    signal syndrome  : std_logic_vector(3 downto 0);

begin

    enc : entity work.hamming_12_8_encoder
        port map (data => data_in, cw => cw);

    dec : entity work.hamming_12_8_decoder
        port map (rx => cw_err, data => data_out, syndrome => syndrome);

    stim : process
        variable ocekivano_cw : std_logic_vector(11 downto 0);
    begin
        -- D = 10101010 (data(7..0))
        data_in <= "10101010";
        wait for 5 ns;

        -- Očekivana kodna riječ (pozicije 1..12 = p1 p2 d1 p3 d2 d3 d4 p4 d5 d6 d7 d8)
        -- = 1 1 1 1 0 1 0 0 1 0 1 0
        ocekivano_cw := "010100101111";  -- ispisano cw(11) do cw(0)
        assert cw = ocekivano_cw
            report "Pogresna kodna rijec: ocekivano " &
                   to_string(ocekivano_cw) & ", dobiveno " & to_string(cw)
            severity error;

        -- Ubaci jednobitnu pogrešku na Hammingovoj poziciji 7 -> cw(6)
        cw_err <= cw;
        cw_err(6) <= not cw(6);
        wait for 5 ns;

        -- Sindrom mora biti 7 (binarno 0111)
        assert syndrome = "0111"
            report "Pogresan sindrom: ocekivano 0111, dobiveno " &
                   to_string(syndrome)
            severity error;

        -- Dekoder mora rekonstruirati izvorne podatke
        assert data_out = "10101010"
            report "Pogresni rekonstruirani podaci: ocekivano 10101010, dobiveno " &
                   to_string(data_out)
            severity error;

        -- Slučaj bez pogreške: sindrom mora biti 0 i podaci identični
        cw_err <= cw;
        wait for 5 ns;
        assert syndrome = "0000"
            report "Sindrom mora biti 0 kada nije ubacena pogreska"
            severity error;
        assert data_out = "10101010"
            report "Podaci se moraju podudarati s ulazom kada nema pogreske"
            severity error;

        report "Hamming (12,8) koder/dekoder ispravno provjeren" severity note;
        wait;
    end process;

end architecture;
