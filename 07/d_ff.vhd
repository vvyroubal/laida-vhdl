library ieee;
use ieee.std_logic_1164.all;

entity d_ff is
    port (
        clk : in  std_logic;
        d   : in  std_logic;
        q   : out std_logic;
        qn  : out std_logic
    );
end entity;

architecture rtl of d_ff is
    signal q_s : std_logic := '0';
begin
    process(clk)
    begin
        if rising_edge(clk) then
            q_s <= d;
        end if;
    end process;
    q  <= q_s;
    qn <= not q_s;
end architecture;
