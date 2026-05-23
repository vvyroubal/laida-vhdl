-- T bistabil izgrađen iz JK bistabila.
-- Izvod: iz tablice prijelaza T bistabila i tablice uzbude JK bistabila
-- proizlazi da su J i K oba jednaki T, pa se ulazi JK kratko spajaju.

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

architecture strukturni of t_from_jk is
begin
    -- J = K = T
    unutarnji : entity work.jk_ff
        port map (clk => clk, j => t, k => t, q => q, qn => qn);
end architecture;
