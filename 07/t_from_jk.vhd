-- T flip-flop built from a JK flip-flop.
-- Derivation: from the T transition table and the JK excitation table,
-- both J and K must equal T, so the two JK inputs are tied together.

library ieee;
use ieee.std_logic_1164.all;

entity t_from_jk is
    port (
        clk : in  std_logic;
        t   : in  std_logic;
        q   : out std_logic;
        qn  : out std_logic
    );
end entity;

architecture structural of t_from_jk is
begin
    -- J = K = T
    inner : entity work.jk_ff
        port map (clk => clk, j => t, k => t, q => q, qn => qn);
end architecture;
