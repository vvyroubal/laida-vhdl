-- D flip-flop built from a JK flip-flop.
-- Derivation: from the D transition table and the JK excitation table,
-- the required inputs are J = D and K = NOT D.

library ieee;
use ieee.std_logic_1164.all;

entity d_from_jk is
    port (
        clk : in  std_logic;
        d   : in  std_logic;
        q   : out std_logic;
        qn  : out std_logic
    );
end entity;

architecture structural of d_from_jk is
begin
    inner : entity work.jk_ff
        port map (clk => clk, j => d, k => not d, q => q, qn => qn);
end architecture;
