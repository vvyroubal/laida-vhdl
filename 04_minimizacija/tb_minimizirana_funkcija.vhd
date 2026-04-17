library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_minimizirana_funkcija is
end entity;

architecture sim of tb_minimizirana_funkcija is
    signal a, b, c, d : std_logic;
    signal f          : std_logic;
    signal ulaz       : std_logic_vector(3 downto 0);
begin
    a <= ulaz(3);
    b <= ulaz(2);
    c <= ulaz(1);
    d <= ulaz(0);

    uut: entity work.minimizirana_funkcija
        port map(a => a, b => b, c => c, d => d, f => f);

    process
    begin
        for i in 0 to 15 loop
            ulaz <= std_logic_vector(to_unsigned(i, 4));
            wait for 20 ns;
        end loop;
        wait;
    end process;
end architecture;
