-- Funkcija f(A,B,C,D) = sum m(2, 5, 7, 8, 13) realizirana dekoderom 4:16
-- (aktivni visoki izlazi) i jednim ILI vratom.
-- Dekoder na izlazu aktivira točno onaj minterm čiji indeks odgovara
-- 4-bitnoj adresi. Funkcija nastaje ILI-spojem pet odabranih izlaza.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decoder_4_16 is
    port (
        addr : in  std_logic_vector(3 downto 0);
        y    : out std_logic_vector(15 downto 0)
    );
end entity;

architecture rtl of decoder_4_16 is
begin
    process(addr)
    begin
        y <= (others => '0');
        y(to_integer(unsigned(addr))) <= '1';
    end process;
end architecture;

-- ----------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity decoder_4_16_func is
    port (
        abcd : in  std_logic_vector(3 downto 0);  -- A=MSB ... D=LSB
        f    : out std_logic
    );
end entity;

architecture strukturni of decoder_4_16_func is
    signal y : std_logic_vector(15 downto 0);
begin
    dec : entity work.decoder_4_16
        port map (addr => abcd, y => y);

    -- f = m2 + m5 + m7 + m8 + m13
    f <= y(2) or y(5) or y(7) or y(8) or y(13);
end architecture;
