library ieee;
use ieee.std_logic_1164.all;

-- Realizacija logicke funkcije: f(a,b,c) = (a AND b) OR (NOT a AND c)
-- Primjer implementacije Booleovog izraza logickim sklopovima
entity logicka_funkcija is
    port (
        a, b, c : in  std_logic;
        f       : out std_logic
    );
end entity;

architecture rtl of logicka_funkcija is
begin
    f <= (a and b) or (not a and c);
end architecture;
