-- JK bistabil izgrađen iz SR bistabila.
-- Izvod: iz tablice prijelaza JK i tablice uzbude SR, ulazi SR-a moraju biti:
--   S = J * NOT(Q)   (postavljanje samo kad J=1 i Q=0)
--   R = K * Q        (brisanje samo kad K=1 i Q=1)
-- Povratna veza s internog Q osigurava da nikad ne nastane zabranjena
-- kombinacija SR=11.

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

architecture strukturni of jk_from_sr is
    signal q_int : std_logic;
    signal s, r  : std_logic;
begin
    s <= j and not q_int;
    r <= k and q_int;

    unutarnji : entity work.sr_ff
        port map (clk => clk, s => s, r => r, q => q_int, qn => open);

    q  <= q_int;
    qn <= not q_int;
end architecture;
