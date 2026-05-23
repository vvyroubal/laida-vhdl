-- Testbench za 8-bitno zbrajalo u dvojnom komplementu s preljevom.
-- Provjerava tri primjera iz teksta riješenog primjera:
--   (a)  +100 + (+60)      ==> preljev
--   (b)  +100 + (+27)      ==> bez preljeva, suma = 127
--   (c)  -100 + (-60)      ==> preljev

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_adder8_2c_overflow is
end entity;

architecture sim of tb_adder8_2c_overflow is

    signal a, b   : std_logic_vector(7 downto 0) := (others => '0');
    signal c_in   : std_logic := '0';
    signal s      : std_logic_vector(7 downto 0);
    signal c_out  : std_logic;
    signal ov     : std_logic;

    procedure provjeri(constant ai, bi : in integer;
                       constant oc_ov : in std_logic;
                       signal a_sig, b_sig : out std_logic_vector(7 downto 0);
                       signal s_sig : in std_logic_vector(7 downto 0);
                       signal ov_sig : in std_logic) is
        variable ocekivano : integer;
        variable ocekivano_8bit : integer;
    begin
        a_sig <= std_logic_vector(to_signed(ai, 8));
        b_sig <= std_logic_vector(to_signed(bi, 8));
        wait for 5 ns;
        ocekivano := ai + bi;
        -- Skrati na 8 bitova (mod 256, pa interpretiraj kao signed)
        if ocekivano >= 128 then
            ocekivano_8bit := ocekivano - 256;
        elsif ocekivano < -128 then
            ocekivano_8bit := ocekivano + 256;
        else
            ocekivano_8bit := ocekivano;
        end if;
        assert to_integer(signed(s_sig)) = ocekivano_8bit
            report "Pogreška zbrajanja: A=" & integer'image(ai) &
                   " B=" & integer'image(bi) &
                   " ocekivano_8bit=" & integer'image(ocekivano_8bit) &
                   " dobiveno=" & integer'image(to_integer(signed(s_sig)))
            severity error;
        assert ov_sig = oc_ov
            report "Pogreška preljeva: A=" & integer'image(ai) &
                   " B=" & integer'image(bi) &
                   " ocekivano_ov=" & std_logic'image(oc_ov) &
                   " dobiveno=" & std_logic'image(ov_sig)
            severity error;
    end procedure;

begin

    dut : entity work.adder8_2c_overflow
        port map (a => a, b => b, c_in => c_in,
                  s => s, c_out => c_out, ov => ov);

    stim : process
    begin
        c_in <= '0';

        -- (a) +100 + (+60) = +160, preljev očekivan
        provjeri(100, 60, '1', a, b, s, ov);

        -- (b) +100 + (+27) = +127, bez preljeva
        provjeri(100, 27, '0', a, b, s, ov);

        -- (c) -100 + (-60) = -160, preljev očekivan
        provjeri(-100, -60, '1', a, b, s, ov);

        report "Sva tri primjera preljeva ispravno provjereni"
            severity note;
        wait;
    end process;

end architecture;
