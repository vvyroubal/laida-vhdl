library ieee;
use ieee.std_logic_1164.all;

entity priority_encoder42 is
    port (
        i    : in  std_logic_vector(3 downto 0);
        y    : out std_logic_vector(1 downto 0);
        v    : out std_logic
    );
end entity;

architecture rtl of priority_encoder42 is
begin
    process(i)
    begin
        if    i(3) = '1' then y <= "11"; v <= '1';
        elsif i(2) = '1' then y <= "10"; v <= '1';
        elsif i(1) = '1' then y <= "01"; v <= '1';
        elsif i(0) = '1' then y <= "00"; v <= '1';
        else                   y <= "00"; v <= '0';
        end if;
    end process;
end architecture;
