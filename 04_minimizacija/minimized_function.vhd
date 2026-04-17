library ieee;
use ieee.std_logic_1164.all;

-- K-map minimization (4 variables)
-- Minterms: 0,2,5,7,8,10,13,15
-- Non-minimized form: sum of minterms (16 terms)
-- Minimized by K-map: f = (NOT b AND NOT d) OR (b AND d)
--                      = NOT (b XOR d)  [equivalence of b and d]
entity minimized_function is
    port (
        a, b, c, d : in  std_logic;
        f          : out std_logic
    );
end entity;

architecture rtl of minimized_function is
begin
    f <= not (b xor d);
end architecture;
