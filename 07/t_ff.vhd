library ieee;
use ieee.std_logic_1164.all;

entity t_ff is
    port (
        clk : in  std_logic;
        t   : in  std_logic;
        q   : out std_logic;
        qn  : out std_logic
    );
end entity;

architecture rtl of t_ff is
    signal q_s : std_logic := '0';
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if t = '1' then
                q_s <= not q_s;     -- toggle
            end if;                 -- t=0: hold
        end if;
    end process;
    q  <= q_s;
    qn <= not q_s;
end architecture;
