-- 8-bit ripple-carry adder for two's-complement operands with explicit
-- overflow detection.
-- Inputs:  8-bit operands A, B (two's complement) and carry-in c_in.
-- Outputs: 8-bit sum s, carry-out c_out, signed overflow flag ov.
-- Overflow rule: ov = c_out XOR c7, where c7 is the carry into the
-- sign bit. The bit-level loop is unrolled at synthesis time.

library ieee;
use ieee.std_logic_1164.all;

entity adder8_2c_overflow is
    port (
        a, b  : in  std_logic_vector(7 downto 0);
        c_in  : in  std_logic;
        s     : out std_logic_vector(7 downto 0);
        c_out : out std_logic;
        ov    : out std_logic
    );
end entity;

architecture rtl of adder8_2c_overflow is
begin
    process(a, b, c_in)
        variable c        : std_logic_vector(8 downto 0);
        variable s_local  : std_logic_vector(7 downto 0);
    begin
        c(0) := c_in;
        for i in 0 to 7 loop
            s_local(i) := a(i) xor b(i) xor c(i);
            c(i+1) := (a(i) and b(i))
                    or (c(i) and (a(i) xor b(i)));
        end loop;
        s     <= s_local;
        c_out <= c(8);
        ov    <= c(8) xor c(7);
    end process;
end architecture;
