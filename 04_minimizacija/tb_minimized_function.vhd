library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_minimized_function is
end entity;

architecture sim of tb_minimized_function is
    signal a, b, c, d : std_logic;
    signal f          : std_logic;
    signal inputs     : std_logic_vector(3 downto 0);
begin
    a <= inputs(3);
    b <= inputs(2);
    c <= inputs(1);
    d <= inputs(0);

    uut: entity work.minimized_function
        port map(a => a, b => b, c => c, d => d, f => f);

    process
    begin
        for i in 0 to 15 loop
            inputs <= std_logic_vector(to_unsigned(i, 4));
            wait for 20 ns;
        end loop;
        wait;
    end process;
end architecture;
