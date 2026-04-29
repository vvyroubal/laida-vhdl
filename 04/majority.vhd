library ieee;
use ieee.std_logic_1164.all;

entity majority is
    port (
        a, b, c : in  std_logic;
        y       : out std_logic
    );
end entity;

architecture rtl of majority is
begin
    y <= (a and b) or (b and c) or (a and c);
end architecture;
