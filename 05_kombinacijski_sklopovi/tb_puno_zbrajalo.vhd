library ieee;
use ieee.std_logic_1164.all;

entity tb_puno_zbrajalo is
end entity;

architecture sim of tb_puno_zbrajalo is
    signal a, b, cin  : std_logic := '0';
    signal sum, cout  : std_logic;
begin
    uut: entity work.puno_zbrajalo
        port map(a => a, b => b, cin => cin, sum => sum, cout => cout);

    process
    begin
        -- sve kombinacije: a, b, cin
        a<='0'; b<='0'; cin<='0'; wait for 20 ns;
        a<='0'; b<='0'; cin<='1'; wait for 20 ns;
        a<='0'; b<='1'; cin<='0'; wait for 20 ns;
        a<='0'; b<='1'; cin<='1'; wait for 20 ns;
        a<='1'; b<='0'; cin<='0'; wait for 20 ns;
        a<='1'; b<='0'; cin<='1'; wait for 20 ns;
        a<='1'; b<='1'; cin<='0'; wait for 20 ns;
        a<='1'; b<='1'; cin<='1'; wait for 20 ns;
        wait;
    end process;
end architecture;
