-- D bistabil izgrađen iz JK bistabila.
-- Izvod: iz tablice prijelaza D bistabila i tablice uzbude JK bistabila
-- traženi su ulazi J = D i K = NOT D.

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

architecture strukturni of d_from_jk is
begin
    unutarnji : entity work.jk_ff
        port map (clk => clk, j => d, k => not d, q => q, qn => qn);
end architecture;
