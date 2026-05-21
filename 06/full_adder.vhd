library ieee;
use ieee.std_logic_1164.all;

-- Potpuno zbrajalo
-- zbroj   = a XOR b XOR cin
-- preljev = (a AND b) OR (cin AND (a XOR b))
entity full_adder is
    port (
        a, b, cin : in  std_logic;
        sum, cout : out std_logic
    );
end entity;

architecture rtl of full_adder is
    signal ab_xor : std_logic;
begin
    ab_xor <= a xor b;
    sum    <= ab_xor xor cin;
    cout   <= (a and b) or (cin and ab_xor);
end architecture;
