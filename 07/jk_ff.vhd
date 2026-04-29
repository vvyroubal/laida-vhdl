library ieee;
use ieee.std_logic_1164.all;

entity jk_ff is
    port (
        clk : in  std_logic;
        j   : in  std_logic;
        k   : in  std_logic;
        q   : out std_logic;
        qn  : out std_logic
    );
end entity;

architecture rtl of jk_ff is
    signal q_s : std_logic := '0';
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if    j = '1' and k = '1' then
                q_s <= not q_s;     -- toggle
            elsif j = '1' then
                q_s <= '1';         -- set
            elsif k = '1' then
                q_s <= '0';         -- reset
            end if;                 -- j=0, k=0: hold
        end if;
    end process;
    q  <= q_s;
    qn <= not q_s;
end architecture;
