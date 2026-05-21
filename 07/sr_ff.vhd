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
                null;                       -- zabranjeno: stanje nepromijenjeno
            elsif s = '1' then
                q_s <= '1';                 -- postavljanje
            elsif r = '1' then
                q_s <= '0';                 -- brisanje
            end if;                         -- s=0, r=0: zadržavanje
        end if;
    end process;
    q  <= q_s;
    qn <= not q_s;
end architecture;
