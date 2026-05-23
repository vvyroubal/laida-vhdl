-- Dekoder BCD u 7-segmentni prikaz (zajednička katoda, aktivna razina 1).
-- Ulaz: 4-bitna BCD znamenka (0..9). Ulazi 10..15 daju ugašen prikaz.
-- Izlaz: seg(6 downto 0) = a, b, c, d, e, f, g.

library ieee;
use ieee.std_logic_1164.all;

entity bcd_to_7seg is
    port (
        bcd : in  std_logic_vector(3 downto 0);
        seg : out std_logic_vector(6 downto 0)
    );
end entity;

architecture rtl of bcd_to_7seg is
begin
    process(bcd)
    begin
        case bcd is
            when "0000" => seg <= "1111110";  -- 0: a b c d e f
            when "0001" => seg <= "0110000";  -- 1: b c
            when "0010" => seg <= "1101101";  -- 2: a b d e g
            when "0011" => seg <= "1111001";  -- 3: a b c d g
            when "0100" => seg <= "0110011";  -- 4: b c f g
            when "0101" => seg <= "1011011";  -- 5: a c d f g
            when "0110" => seg <= "1011111";  -- 6: a c d e f g
            when "0111" => seg <= "1110000";  -- 7: a b c
            when "1000" => seg <= "1111111";  -- 8: a b c d e f g
            when "1001" => seg <= "1111011";  -- 9: a b c d f g
            when others => seg <= "0000000";  -- neispravan BCD: ugašeno
        end case;
    end process;
end architecture;
