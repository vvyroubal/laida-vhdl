library ieee;
use ieee.std_logic_1164.all;

entity and_or_f is
    port (
        a, b, c : in  std_logic;
        f       : out std_logic
    );
end entity;

architecture rtl of and_or_f is
begin
    f <= (a and b) or (not a and c);
end architecture;
