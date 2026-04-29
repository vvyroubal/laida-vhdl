library ieee;
use ieee.std_logic_1164.all;

entity tb_t_ff is
end entity;

architecture sim of tb_t_ff is
    signal clk, t : std_logic := '0';
    signal q, qn  : std_logic;

    constant T_CLK : time := 10 ns;
begin
    uut: entity work.t_ff
        port map(clk => clk, t => t, q => q, qn => qn);

    clk <= not clk after T_CLK / 2;

    process
    begin
        t <= '0';               wait for 2 * T_CLK;  -- hold (q=0)
        t <= '1';               wait for T_CLK;       -- toggle → q=1
        t <= '1';               wait for T_CLK;       -- toggle → q=0
        t <= '1';               wait for T_CLK;       -- toggle → q=1
        t <= '1';               wait for T_CLK;       -- toggle → q=0
        t <= '0';               wait for 2 * T_CLK;  -- hold
        t <= '1';               wait for T_CLK;       -- toggle → q=1
        t <= '0';               wait for T_CLK;       -- hold
        wait;
    end process;
end architecture;
