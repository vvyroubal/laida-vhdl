-- 2-bit magnitude comparator.
-- Inputs: two 2-bit unsigned operands a = a1 a0 and b = b1 b0.
-- Outputs: gt (a > b), eq (a = b), lt (a < b). Exactly one output is high.

library ieee;
use ieee.std_logic_1164.all;

entity comparator_2bit is
    port (
        a, b   : in  std_logic_vector(1 downto 0);
        gt, eq, lt : out std_logic
    );
end entity;

architecture rtl of comparator_2bit is
    signal e1, e0 : std_logic;   -- bitwise equality of MSB and LSB
begin
    e1 <= a(1) xnor b(1);
    e0 <= a(0) xnor b(0);

    eq <= e1 and e0;
    gt <= (a(1) and not b(1))
        or (e1 and a(0) and not b(0));
    lt <= (not a(1) and b(1))
        or (e1 and not a(0) and b(0));
end architecture;
