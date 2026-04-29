library ieee;
use ieee.std_logic_1164.all;

entity sr_ff is
    port (
        clk : in  std_logic;
        s   : in  std_logic;
        r   : in  std_logic;
        q   : out std_logic;
        qn  : out std_logic
    );
end entity;

architecture rtl of sr_ff is
    signal q_s : std_logic := '0';
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if    s = '1' and r = '1' then
                null;                       -- forbidden: state unchanged
            elsif s = '1' then
                q_s <= '1';                 -- set
            elsif r = '1' then
                q_s <= '0';                 -- reset
            end if;                         -- s=0, r=0: hold
        end if;
    end process;
    q  <= q_s;
    qn <= not q_s;
end architecture;
