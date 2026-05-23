-- Sinkroni generator ponavljajućeg 8-bitnog niza 10111101, izgrađen od
-- 4-bitnog Johnsonovog brojila i 2-term izlaznog izraza
-- Y = Q1 + NOT(Q2) * NOT(Q0).
--
-- Regularni ciklus Johnsonovog brojila (uz V/Š notaciju Q0 Q1 Q2 Q3, gdje
-- je Q0 prvi bistabil u kaskadi):
--   0000, 1000, 1100, 1110, 1111, 0111, 0011, 0001.
-- U VHDL-u std_logic_vector(3 downto 0) stanje držimo s istim bitnim
-- pozicijama, pa q(0) odgovara Johnsonovom Q0.

library ieee;
use ieee.std_logic_1164.all;

entity seq_gen_10111101 is
    port (
        clk : in  std_logic;
        rst : in  std_logic;
        y   : out std_logic
    );
end entity;

architecture rtl of seq_gen_10111101 is
    signal q : std_logic_vector(3 downto 0) := "0000";
begin
    -- 4-bitno Johnsonovo brojilo
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                q <= "0000";
            else
                q(0) <= not q(3);
                q(1) <= q(0);
                q(2) <= q(1);
                q(3) <= q(2);
            end if;
        end if;
    end process;

    -- Minimalna izlazna funkcija: Y = Q1 + NOT(Q2) * NOT(Q0)
    y <= q(1) or (not q(2) and not q(0));
end architecture;
