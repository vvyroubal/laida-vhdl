library ieee;
use ieee.std_logic_1164.all;

entity tb_sr_latch is
end entity;

architecture sim of tb_sr_latch is
    signal s, r  : std_logic := '0';
    signal q, qn : std_logic;

    constant T : time := 10 ns;
begin
    uut: entity work.sr_latch
        port map(s => s, r => r, q => q, qn => qn);

    process
    begin
        s <= '0'; r <= '0';     wait for T;  -- hold (q neodređen)
        s <= '1'; r <= '0';     wait for T;  -- set   → q=1
        s <= '0'; r <= '0';     wait for T;  -- hold
        s <= '0'; r <= '1';     wait for T;  -- reset → q=0
        s <= '0'; r <= '0';     wait for T;  -- hold
        s <= '1'; r <= '0';     wait for T;  -- set   → q=1
        s <= '1'; r <= '1';     wait for T;  -- zabranjeno: q=0, qn=0
        s <= '0'; r <= '0';     wait for T;  -- hold
        wait;
    end process;
end architecture;
