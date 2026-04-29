library ieee;
use ieee.std_logic_1164.all;

entity tb_sr_ff is
end entity;

architecture sim of tb_sr_ff is
    signal clk, s, r : std_logic := '0';
    signal q, qn     : std_logic;

    constant T : time := 10 ns;
begin
    uut: entity work.sr_ff
        port map(clk => clk, s => s, r => r, q => q, qn => qn);

    clk <= not clk after T / 2;

    process
    begin
        s <= '0'; r <= '0';     wait for 2 * T;  -- hold (q=0)
        s <= '1'; r <= '0';     wait for T;       -- set   → q=1
        s <= '0'; r <= '0';     wait for T;       -- hold
        s <= '0'; r <= '1';     wait for T;       -- reset → q=0
        s <= '0'; r <= '0';     wait for T;       -- hold
        s <= '1'; r <= '1';     wait for T;       -- zabranjeno: stanje se ne mijenja
        s <= '0'; r <= '0';     wait for T;       -- hold
        s <= '1'; r <= '0';     wait for T;       -- set   → q=1
        s <= '0'; r <= '0';     wait for T;       -- hold
        wait;
    end process;
end architecture;
