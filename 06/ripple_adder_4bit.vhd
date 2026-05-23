-- 4-bitno paralelno zbrajalo s rasprostiranjem prijenosa (ripple-carry).
-- Zbraja dva 4-bitna neoznačena operanda A i B uz ulazni prijenos c_in
-- i daje 4-bitnu sumu S te izlazni prijenos c_out. Prijenos se rasprostire
-- kroz četiri kaskadno spojena potpuna zbrajala.

library ieee;
use ieee.std_logic_1164.all;

entity full_adder is
    port (
        a, b, c_in : in  std_logic;
        sum, c_out : out std_logic
    );
end entity;

architecture rtl of full_adder is
begin
    sum   <= a xor b xor c_in;
    c_out <= (a and b) or (c_in and (a xor b));
end architecture;

-- ----------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity ripple_adder_4bit is
    port (
        a, b  : in  std_logic_vector(3 downto 0);
        c_in  : in  std_logic;
        sum   : out std_logic_vector(3 downto 0);
        c_out : out std_logic
    );
end entity;

architecture strukturni of ripple_adder_4bit is
    signal c : std_logic_vector(3 downto 1);
begin
    fa0 : entity work.full_adder
        port map (a => a(0), b => b(0), c_in => c_in,
                  sum => sum(0), c_out => c(1));
    fa1 : entity work.full_adder
        port map (a => a(1), b => b(1), c_in => c(1),
                  sum => sum(1), c_out => c(2));
    fa2 : entity work.full_adder
        port map (a => a(2), b => b(2), c_in => c(2),
                  sum => sum(2), c_out => c(3));
    fa3 : entity work.full_adder
        port map (a => a(3), b => b(3), c_in => c(3),
                  sum => sum(3), c_out => c_out);
end architecture;
