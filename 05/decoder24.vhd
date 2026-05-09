library ieee;
use ieee.std_logic_1164.all;

entity decoder24 is
    port (
        addr : in  std_logic_vector(1 downto 0);
        y    : out std_logic_vector(3 downto 0)
    );
end entity;

architecture rtl of decoder24 is
begin
    process(addr)
    begin
        y <= (others => '0');
        case addr is
            when "00"   => y(0) <= '1';
            when "01"   => y(1) <= '1';
            when "10"   => y(2) <= '1';
            when others => y(3) <= '1';
        end case;
    end process;
end architecture;
