-- 8-bitno ripple-carry zbrajalo za operande u dvojnom komplementu s
-- eksplicitnom detekcijom preljeva.
-- Ulazi:  8-bitni operandi A, B (dvojni komplement) i ulazni prijenos c_in.
-- Izlazi: 8-bitna suma s, izlazni prijenos c_out, predznačni preljev ov.
-- Pravilo preljeva: ov = c_out XOR c7, gdje je c7 prijenos u bit predznaka.
-- Bit-nivo petlja se pri sintezi razmotava (unroll).

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
        variable s_lokal  : std_logic_vector(7 downto 0);
    begin
        c(0) := c_in;
        for i in 0 to 7 loop
            s_lokal(i) := a(i) xor b(i) xor c(i);
            c(i+1) := (a(i) and b(i))
                    or (c(i) and (a(i) xor b(i)));
        end loop;
        s     <= s_lokal;
        c_out <= c(8);
        ov    <= c(8) xor c(7);
    end process;
end architecture;
