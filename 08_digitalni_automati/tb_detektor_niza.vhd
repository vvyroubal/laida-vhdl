library ieee;
use ieee.std_logic_1164.all;

entity tb_detektor_niza is
end entity;

architecture sim of tb_detektor_niza is
    signal clk, rst, x, y : std_logic := '0';

    constant T : time := 10 ns;

    -- niz koji sadrzi "101" na vise mjesta: 1 0 1 1 0 1 0 1
    type niz_t is array(0 to 7) of std_logic;
    constant ULAZ : niz_t := ('1','0','1','1','0','1','0','1');
begin
    uut: entity work.detektor_niza
        port map(clk => clk, rst => rst, x => x, y => y);

    clk <= not clk after T / 2;

    process
    begin
        rst <= '1';  wait for 2 * T;
        rst <= '0';

        for i in ULAZ'range loop
            x <= ULAZ(i);
            wait for T;
        end loop;

        wait for 2 * T;
        wait;
    end process;
end architecture;
