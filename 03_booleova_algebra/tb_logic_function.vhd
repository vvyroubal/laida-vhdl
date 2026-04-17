library ieee;
use ieee.std_logic_1164.all;

entity tb_logic_function is
end entity;

architecture sim of tb_logic_function is
    signal a, b, c, f : std_logic;
begin
    uut: entity work.logic_function port map(a => a, b => b, c => c, f => f);

    process
    begin
        -- all 8 input combinations
        a <= '0'; b <= '0'; c <= '0'; wait for 20 ns;
        a <= '0'; b <= '0'; c <= '1'; wait for 20 ns;
        a <= '0'; b <= '1'; c <= '0'; wait for 20 ns;
        a <= '0'; b <= '1'; c <= '1'; wait for 20 ns;
        a <= '1'; b <= '0'; c <= '0'; wait for 20 ns;
        a <= '1'; b <= '0'; c <= '1'; wait for 20 ns;
        a <= '1'; b <= '1'; c <= '0'; wait for 20 ns;
        a <= '1'; b <= '1'; c <= '1'; wait for 20 ns;
        wait;
    end process;
end architecture;
