-- Testbench for the Hamming (12, 8) encoder and decoder/corrector.
-- 1. Encode D = 10101010 and check the codeword against the analytical
--    result 111101001010 (positions 1..12).
-- 2. Inject a single-bit error at position 7 and verify that the decoder:
--      - reports syndrome = 7
--      - recovers the original D = 10101010

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
        variable expected_cw : std_logic_vector(11 downto 0);
    begin
        -- D = 10101010 (data(7..0))
        data_in <= "10101010";
        wait for 5 ns;

        -- Expected codeword (positions 1..12 = p1 p2 d1 p3 d2 d3 d4 p4 d5 d6 d7 d8)
        -- = 1 1 1 1 0 1 0 0 1 0 1 0
        -- cw(0)=1, cw(1)=1, cw(2)=1, cw(3)=1, cw(4)=0, cw(5)=1,
        -- cw(6)=0, cw(7)=0, cw(8)=1, cw(9)=0, cw(10)=1, cw(11)=0
        expected_cw := "010100101111";  -- written cw(11) to cw(0)
        assert cw = expected_cw
            report "Codeword mismatch: expected " &
                   to_string(expected_cw) & ", got " & to_string(cw)
            severity error;

        -- Inject single-bit error at Hamming position 7 -> cw(6)
        cw_err <= cw;
        cw_err(6) <= not cw(6);
        wait for 5 ns;

        -- Syndrome must be 7 (binary 0111)
        assert syndrome = "0111"
            report "Syndrome mismatch: expected 0111, got " &
                   to_string(syndrome)
            severity error;

        -- Decoder must recover the original data
        assert data_out = "10101010"
            report "Recovered data mismatch: expected 10101010, got " &
                   to_string(data_out)
            severity error;

        -- No-error case: syndrome must be 0 and data identical
        cw_err <= cw;
        wait for 5 ns;
        assert syndrome = "0000"
            report "Syndrome must be 0 when no error injected" severity error;
        assert data_out = "10101010"
            report "Data must match input when no error injected" severity error;

        report "Hamming (12,8) encoder/decoder verified" severity note;
        wait;
    end process;

end architecture;
