library ieee;
use ieee.std_logic_1164.all;

entity demux14 is
    port (
        d   : in  std_logic;
        sel : in  std_logic_vector(1 downto 0);
        y   : out std_logic_vector(3 downto 0)
    );
end entity;

architecture rtl of demux14 is
begin
    process(d, sel)
    begin
        y <= (others => '0');
        case sel is
            when "00"   => y(0) <= d;
            when "01"   => y(1) <= d;
            when "10"   => y(2) <= d;
            when others => y(3) <= d;
        end case;
    end process;
end architecture;
