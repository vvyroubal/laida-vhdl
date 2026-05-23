-- Testbench for the 8-bit two's-complement adder with overflow.
-- Verifies the three examples from the worked-example text:
--   (a)  +100 + (+60)      ==> overflow
--   (b)  +100 + (+27)      ==> no overflow, sum = 127
--   (c)  -100 + (-60)      ==> overflow

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

    procedure check(constant ai, bi : in integer;
                    constant exp_ov : in std_logic;
                    signal a_sig, b_sig : out std_logic_vector(7 downto 0);
                    signal s_sig : in std_logic_vector(7 downto 0);
                    signal ov_sig : in std_logic) is
        variable expected : integer;
        variable expected_8bit : integer;
    begin
        a_sig <= std_logic_vector(to_signed(ai, 8));
        b_sig <= std_logic_vector(to_signed(bi, 8));
        wait for 5 ns;
        expected := ai + bi;
        -- Truncate to 8 bits (mod 256, then interpret as signed)
        if expected >= 128 then
            expected_8bit := expected - 256;
        elsif expected < -128 then
            expected_8bit := expected + 256;
        else
            expected_8bit := expected;
        end if;
        assert to_integer(signed(s_sig)) = expected_8bit
            report "Sum mismatch: A=" & integer'image(ai) &
                   " B=" & integer'image(bi) &
                   " expected_truncated=" & integer'image(expected_8bit) &
                   " got=" & integer'image(to_integer(signed(s_sig)))
            severity error;
        assert ov_sig = exp_ov
            report "Overflow flag mismatch: A=" & integer'image(ai) &
                   " B=" & integer'image(bi) &
                   " expected_ov=" & std_logic'image(exp_ov) &
                   " got=" & std_logic'image(ov_sig)
            severity error;
    end procedure;

begin

    dut : entity work.adder8_2c_overflow
        port map (a => a, b => b, c_in => c_in,
                  s => s, c_out => c_out, ov => ov);

    stim : process
    begin
        c_in <= '0';

        -- (a) +100 + (+60) = +160, overflow expected
        check(100, 60, '1', a, b, s, ov);

        -- (b) +100 + (+27) = +127, no overflow
        check(100, 27, '0', a, b, s, ov);

        -- (c) -100 + (-60) = -160, overflow expected
        check(-100, -60, '1', a, b, s, ov);

        report "All three overflow examples verified" severity note;
        wait;
    end process;

end architecture;
