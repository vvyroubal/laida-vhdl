library ieee;
use ieee.std_logic_1164.all;

entity tb_full_adder is
end entity;

architecture sim of tb_full_adder is
    signal a, b, cin  : std_logic := '0';
    signal sum, cout  : std_logic;
begin
    uut: entity work.full_adder
        port map(a => a, b => b, cin => cin, sum => sum, cout => cout);

    process
    begin
        -- sve kombinacije: a, b, cin
        a<='0'; b<='0'; cin<='0'; wait for 20 ns;
        assert sum='0' and cout='0' report "FAIL: 0+0+0 ocekivano sum=0,cout=0" severity error;

        a<='0'; b<='0'; cin<='1'; wait for 20 ns;
        assert sum='1' and cout='0' report "FAIL: 0+0+1 ocekivano sum=1,cout=0" severity error;

        a<='0'; b<='1'; cin<='0'; wait for 20 ns;
        assert sum='1' and cout='0' report "FAIL: 0+1+0 ocekivano sum=1,cout=0" severity error;

        a<='0'; b<='1'; cin<='1'; wait for 20 ns;
        assert sum='0' and cout='1' report "FAIL: 0+1+1 ocekivano sum=0,cout=1" severity error;

        a<='1'; b<='0'; cin<='0'; wait for 20 ns;
        assert sum='1' and cout='0' report "FAIL: 1+0+0 ocekivano sum=1,cout=0" severity error;

        a<='1'; b<='0'; cin<='1'; wait for 20 ns;
        assert sum='0' and cout='1' report "FAIL: 1+0+1 ocekivano sum=0,cout=1" severity error;

        a<='1'; b<='1'; cin<='0'; wait for 20 ns;
        assert sum='0' and cout='1' report "FAIL: 1+1+0 ocekivano sum=0,cout=1" severity error;

        a<='1'; b<='1'; cin<='1'; wait for 20 ns;
        assert sum='1' and cout='1' report "FAIL: 1+1+1 ocekivano sum=1,cout=1" severity error;

        report "tb_full_adder: svih 8 kombinacija proslo" severity note;
        wait;
    end process;
end architecture;
