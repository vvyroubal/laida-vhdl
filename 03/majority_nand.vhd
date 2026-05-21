library ieee;
use ieee.std_logic_1164.all;

architecture nand_only of majority is
    signal n_ab, n_bc, n_ac : std_logic;
begin
    n_ab <= not (a and b);           -- NAND(a, b)
    n_bc <= not (b and c);           -- NAND(b, c)
    n_ac <= not (a and c);           -- NAND(a, c)
    y    <= not (n_ab and n_bc and n_ac);  -- izlazna NAND vrata
end architecture;
