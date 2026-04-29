library ieee;
use ieee.std_logic_1164.all;

entity sr_latch is
    port (
        s  : in  std_logic;
        r  : in  std_logic;
        q  : out std_logic;
        qn : out std_logic
    );
end entity;

architecture rtl of sr_latch is
begin
    process(s, r)
    begin
        if    s = '1' and r = '1' then
            q <= '0'; qn <= '0';        -- forbidden
        elsif s = '1' then
            q <= '1'; qn <= '0';        -- set
        elsif r = '1' then
            q <= '0'; qn <= '1';        -- reset
        end if;                         -- s=0, r=0: hold
    end process;
end architecture;
