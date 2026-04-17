library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_binary_to_gray is
end entity;

architecture sim of tb_binary_to_gray is
    signal b : std_logic_vector(3 downto 0) := (others => '0');
    signal g : std_logic_vector(3 downto 0);
begin
    uut: entity work.binary_to_gray port map(b => b, g => g);

    process
    begin
        for i in 0 to 15 loop
            b <= std_logic_vector(to_unsigned(i, 4));
            wait for 20 ns;
        end loop;
        wait;
    end process;
end architecture;
