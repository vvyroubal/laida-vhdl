-- Hamming (12, 8) koder i dekoder/ispravljač.
-- 8 informacijskih bitova + 4 paritetna bita (pozicije 1, 2, 4, 8).
-- Konvencija: data(7) je prvi informacijski bit d1 (MSB od D),
-- data(0) je osmi informacijski bit d8 (LSB od D).
-- Kodna riječ se nalazi u cw(11 downto 0) tako da je cw(i-1) bit na
-- Hammingovoj poziciji i (i = 1..12).
--
-- Definicije paritetnih bitova (parni paritet):
--   p1 = d1 XOR d2 XOR d4 XOR d5 XOR d7        (pozicije 1,3,5,7,9,11)
--   p2 = d1 XOR d3 XOR d4 XOR d6 XOR d7        (pozicije 2,3,6,7,10,11)
--   p3 = d2 XOR d3 XOR d4 XOR d8               (pozicije 4,5,6,7,12)
--   p4 = d5 XOR d6 XOR d7 XOR d8               (pozicije 8,9,10,11,12)

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity hamming_12_8_encoder is
    port (
        data : in  std_logic_vector(7 downto 0);
        cw   : out std_logic_vector(11 downto 0)
    );
end entity;

architecture rtl of hamming_12_8_encoder is
begin
    -- Paritetni bitovi
    cw(0) <= data(7) xor data(6) xor data(4) xor data(3) xor data(1);  -- p1
    cw(1) <= data(7) xor data(5) xor data(4) xor data(2) xor data(1);  -- p2
    cw(3) <= data(6) xor data(5) xor data(4) xor data(0);              -- p3
    cw(7) <= data(3) xor data(2) xor data(1) xor data(0);              -- p4

    -- Informacijski bitovi na pozicijama koje nisu potencije dvojke
    cw(2)  <= data(7);   -- d1 na poziciji 3
    cw(4)  <= data(6);   -- d2 na poziciji 5
    cw(5)  <= data(5);   -- d3 na poziciji 6
    cw(6)  <= data(4);   -- d4 na poziciji 7
    cw(8)  <= data(3);   -- d5 na poziciji 9
    cw(9)  <= data(2);   -- d6 na poziciji 10
    cw(10) <= data(1);   -- d7 na poziciji 11
    cw(11) <= data(0);   -- d8 na poziciji 12
end architecture;

-- ---------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity hamming_12_8_decoder is
    port (
        rx          : in  std_logic_vector(11 downto 0);
        data        : out std_logic_vector(7 downto 0);
        syndrome    : out std_logic_vector(3 downto 0)
    );
end entity;

architecture rtl of hamming_12_8_decoder is
    signal s1, s2, s3, s4 : std_logic;
    signal synd           : std_logic_vector(3 downto 0);
    signal corrected      : std_logic_vector(11 downto 0);
begin
    -- Preračunavanje pariteta preko primljene riječi (uključujući primljene
    -- paritetne bitove). Ako je sindrom različit od 0, on jednak je 1-indeksiranoj
    -- poziciji preokrenutog bita.
    s1 <= rx(0) xor rx(2) xor rx(4) xor rx(6) xor rx(8) xor rx(10);
    s2 <= rx(1) xor rx(2) xor rx(5) xor rx(6) xor rx(9) xor rx(10);
    s3 <= rx(3) xor rx(4) xor rx(5) xor rx(6) xor rx(11);
    s4 <= rx(7) xor rx(8) xor rx(9) xor rx(10) xor rx(11);

    synd <= s4 & s3 & s2 & s1;
    syndrome <= synd;

    -- Ispravak jednobitne pogreške: invertiraj bit na poziciji 'synd' (1-indeks).
    process(rx, synd)
        variable pos : integer;
    begin
        corrected <= rx;
        pos := to_integer(unsigned(synd));
        if pos /= 0 and pos <= 12 then
            corrected(pos - 1) <= not rx(pos - 1);
        end if;
    end process;

    -- Izvuci informacijske bitove iz (ispravljene) kodne riječi
    data(7) <= corrected(2);
    data(6) <= corrected(4);
    data(5) <= corrected(5);
    data(4) <= corrected(6);
    data(3) <= corrected(8);
    data(2) <= corrected(9);
    data(1) <= corrected(10);
    data(0) <= corrected(11);
end architecture;
