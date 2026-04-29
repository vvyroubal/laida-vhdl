library ieee;
use ieee.std_logic_1164.all;

entity tb_d_ff is
end entity;

architecture sim of tb_d_ff is
    signal clk, d : std_logic := '0';
    signal q, qn  : std_logic;

    constant T : time := 10 ns;
begin
    uut: entity work.d_ff
        port map(clk => clk, d => d, q => q, qn => qn);

    clk <= not clk after T / 2;

    process
    begin
        d <= '1';               wait for T;
        d <= '0';               wait for T;
        d <= '1';               wait for T;
        d <= '1';               wait for T;
        d <= '0';               wait for T;
        d <= '0';               wait for T;
        d <= '1';               wait for T;
        wait;
    end process;
end architecture;
