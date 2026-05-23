-- 7-bit ASCII encoder with even parity.
-- The parity bit becomes the MSB of the 8-bit output; the seven lower
-- bits hold the original ASCII value. For even parity, the parity bit is
-- chosen so that the total number of 1s in the 8-bit word is even
-- (equivalently: parity bit = XOR of the seven ASCII bits).

library ieee;
use ieee.std_logic_1164.all;

entity ascii_parity is
    port (
        ascii_in : in  std_logic_vector(6 downto 0);
        encoded  : out std_logic_vector(7 downto 0)
    );
end entity;

architecture rtl of ascii_parity is
    signal parity : std_logic;
begin
    parity <= ascii_in(6) xor ascii_in(5) xor ascii_in(4)
            xor ascii_in(3) xor ascii_in(2) xor ascii_in(1)
            xor ascii_in(0);

    encoded(7)          <= parity;
    encoded(6 downto 0) <= ascii_in;
end architecture;
