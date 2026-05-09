library ieee;
use ieee.std_logic_1164.all;

entity mux41 is
    port (
        d   : in  std_logic_vector(3 downto 0);
        sel : in  std_logic_vector(1 downto 0);
        y   : out std_logic
    );
end entity;

architecture rtl of mux41 is
begin
    process(d, sel)
    begin
        case sel is
            when "00"   => y <= d(0);
            when "01"   => y <= d(1);
            when "10"   => y <= d(2);
            when others => y <= d(3);
        end case;
    end process;
end architecture;
