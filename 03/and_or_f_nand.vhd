library ieee;
use ieee.std_logic_1164.all;

architecture nand_nand of and_or_f is
    signal n_a, n_ab, n_ac : std_logic;
begin
    n_a  <= not (a and a);        -- NAND(a, a) = NOT a
    n_ab <= not (a and b);        -- NAND(a, b)
    n_ac <= not (n_a and c);      -- NAND(NOT a, c)
    f    <= not (n_ab and n_ac);  -- output NAND
end architecture;
