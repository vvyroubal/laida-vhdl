library ieee;
use ieee.std_logic_1164.all;

-- Puno zbrajalo (Full Adder)
-- sum  = a XOR b XOR cin
-- cout = (a AND b) OR (cin AND (a XOR b))
entity puno_zbrajalo is
    port (
        a, b, cin : in  std_logic;
        sum, cout : out std_logic
    );
end entity;

architecture rtl of puno_zbrajalo is
    signal ab_xor : std_logic;
begin
    ab_xor <= a xor b;
    sum    <= ab_xor xor cin;
    cout   <= (a and b) or (cin and ab_xor);
end architecture;
