library ieee;
use ieee.std_logic_1164.all;

entity tb_jk_ff is
end entity;

architecture sim of tb_jk_ff is
    signal clk, j, k : std_logic := '0';
    signal q, qn     : std_logic;

    constant T : time := 10 ns;
begin
    uut: entity work.jk_ff
        port map(clk => clk, j => j, k => k, q => q, qn => qn);

    clk <= not clk after T / 2;

    process
    begin
        j <= '0'; k <= '0';     wait for 2 * T;  -- hold (q=0)
        j <= '1'; k <= '0';     wait for T;       -- set    → q=1
        j <= '0'; k <= '0';     wait for T;       -- hold
        j <= '0'; k <= '1';     wait for T;       -- reset  → q=0
        j <= '0'; k <= '0';     wait for T;       -- hold
        j <= '1'; k <= '1';     wait for T;       -- toggle → q=1
        j <= '1'; k <= '1';     wait for T;       -- toggle → q=0
        j <= '1'; k <= '1';     wait for T;       -- toggle → q=1
        j <= '1'; k <= '1';     wait for T;       -- toggle → q=0
        j <= '0'; k <= '0';     wait for T;       -- hold
        wait;
    end process;
end architecture;
