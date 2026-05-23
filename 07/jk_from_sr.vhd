-- JK flip-flop built from an SR flip-flop.
-- Derivation: from the JK transition table and the SR excitation table,
-- the SR inputs must be:
--   S = J * NOT(Q)   (set only when J=1 and Q=0)
--   R = K * Q        (reset only when K=1 and Q=1)
-- The internal Q feedback prevents the forbidden SR=11 condition.

library ieee;
use ieee.std_logic_1164.all;

entity jk_from_sr is
    port (
        clk : in  std_logic;
        j   : in  std_logic;
        k   : in  std_logic;
        q   : out std_logic;
        qn  : out std_logic
    );
end entity;

architecture structural of jk_from_sr is
    signal q_int : std_logic;
    signal s, r  : std_logic;
begin
    s <= j and not q_int;
    r <= k and q_int;

    inner : entity work.sr_ff
        port map (clk => clk, s => s, r => r, q => q_int, qn => open);

    q  <= q_int;
    qn <= not q_int;
end architecture;
