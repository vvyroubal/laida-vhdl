-- 7-bitni ASCII koder s parnim paritetom.
-- Paritetni bit postaje MSB 8-bitnog izlaza; sedam nižih bitova drži
-- izvornu ASCII vrijednost. Za parni paritet, paritetni bit se postavlja
-- tako da ukupan broj jedinica u 8-bitnoj riječi bude paran (ekvivalentno:
-- paritetni bit = XOR sedam ASCII bitova).

library ieee;
use ieee.std_logic_1164.all;

entity ascii_parity is
    port (
        ascii_in : in  std_logic_vector(6 downto 0);
        encoded  : out std_logic_vector(7 downto 0)
    );
end entity;

architecture rtl of ascii_parity is
    signal paritet : std_logic;
begin
    paritet <= ascii_in(6) xor ascii_in(5) xor ascii_in(4)
             xor ascii_in(3) xor ascii_in(2) xor ascii_in(1)
             xor ascii_in(0);

    encoded(7)          <= paritet;
    encoded(6 downto 0) <= ascii_in;
end architecture;
