-- Synchronous sequence generator for the repeating 8-bit pattern
-- 10111101, built from a 4-bit Johnson counter and a 2-term output
-- expression Y = Q1 + NOT(Q2) * NOT(Q0).
--
-- Johnson counter regular cycle (using V/S notation Q0 Q1 Q2 Q3 where
-- Q0 is the first stage):  0000, 1000, 1100, 1110, 1111, 0111, 0011, 0001.
-- In VHDL std_logic_vector(3 downto 0) we store the same state with the
-- same bit-positions, so q(0) corresponds to Johnson Q0.

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
    -- 4-bit Johnson counter
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

    -- Minimised output function: Y = Q1 + NOT(Q2) * NOT(Q0)
    y <= q(1) or (not q(2) and not q(0));
end architecture;
