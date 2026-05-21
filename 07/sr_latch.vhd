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
    signal q_int  : std_logic := '0';
    signal qn_int : std_logic := '1';
begin
    process(s, r)
    begin
        if    s = '1' and r = '1' then
            q_int  <= '0'; qn_int <= '0';   -- zabranjeno: oba izlaza nisko
        elsif s = '1' then
            q_int  <= '1'; qn_int <= '0';   -- postavljanje
        elsif r = '1' then
            q_int  <= '0'; qn_int <= '1';   -- brisanje
        else
            q_int  <= q_int;                -- zadržavanje: povratna veza održava stanje
            qn_int <= qn_int;
        end if;
    end process;

    q  <= q_int;
    qn <= qn_int;
end architecture;
