library ieee;
use ieee.std_logic_1164.all;

-- 4-bitni pretvornik iz binarnog u Grayev kod
-- g(n)   = b(n)
-- g(n-1) = b(n) XOR b(n-1)
entity binarni_u_gray is
    port (
        b : in  std_logic_vector(3 downto 0);
        g : out std_logic_vector(3 downto 0)
    );
end entity;

architecture rtl of binarni_u_gray is
begin
    g(3) <= b(3);
    g(2) <= b(3) xor b(2);
    g(1) <= b(2) xor b(1);
    g(0) <= b(1) xor b(0);
end architecture;
