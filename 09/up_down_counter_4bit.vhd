-- 4-bitno sinkrono binarno brojilo gore/dolje.
-- DIR = '0' broji unaprijed (0, 1, 2, ..., 15, 0, ...).
-- DIR = '1' broji unatrag (0, 15, 14, ..., 1, 0, ...).
-- Sinkroni reset (rst='1') postavlja brojilo u 0.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity up_down_counter_4bit is
    port (
        clk : in  std_logic;
        rst : in  std_logic;
        dir : in  std_logic;
        q   : out std_logic_vector(3 downto 0)
    );
end entity;

architecture rtl of up_down_counter_4bit is
    signal brojac : unsigned(3 downto 0) := (others => '0');
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                brojac <= (others => '0');
            elsif dir = '0' then
                brojac <= brojac + 1;
            else
                brojac <= brojac - 1;
            end if;
        end if;
    end process;

    q <= std_logic_vector(brojac);
end architecture;
