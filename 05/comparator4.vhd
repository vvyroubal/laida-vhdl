library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity comparator4 is
    port (
        a, b : in  std_logic_vector(3 downto 0);
        eq   : out std_logic;
        gt   : out std_logic;
        lt   : out std_logic
    );
end entity;

architecture rtl of comparator4 is
    signal ua, ub : unsigned(3 downto 0);
begin
    ua <= unsigned(a);
    ub <= unsigned(b);

    eq <= '1' when ua = ub else '0';
    gt <= '1' when ua > ub else '0';
    lt <= '1' when ua < ub else '0';
end architecture;
