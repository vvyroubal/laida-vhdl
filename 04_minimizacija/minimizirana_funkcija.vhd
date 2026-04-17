library ieee;
use ieee.std_logic_1164.all;

-- Minimizacija K-tablicom (4 varijable)
-- Mintermi: 0,2,5,7,8,10,13,15
-- Neminimiziran oblik: sum of minterms (16 clanova)
-- Minimiziran K-tablicom: f = (NOT b AND NOT d) OR (b AND d)
--                           = NOT (b XOR d)  [ekvivalencija b i d]
entity minimizirana_funkcija is
    port (
        a, b, c, d : in  std_logic;
        f          : out std_logic
    );
end entity;

architecture rtl of minimizirana_funkcija is
begin
    f <= not (b xor d);
end architecture;
