library ieee;
use ieee.std_logic_1164.all;

-- Logic function: f(a,b,c) = (a AND b) OR (NOT a AND c)
-- Example implementation of a Boolean expression with logic gates
entity logic_function is
    port (
        a, b, c : in  std_logic;
        f       : out std_logic
    );
end entity;

architecture rtl of logic_function is
begin
    f <= (a and b) or (not a and c);
end architecture;
