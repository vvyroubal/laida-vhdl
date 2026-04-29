library ieee;
use ieee.std_logic_1164.all;

entity mux21 is
    port (
        d0, d1 : in  std_logic;
        s      : in  std_logic;
        y      : out std_logic
    );
end entity;

architecture rtl of mux21 is
begin
    y <= d0 when s = '0' else d1;
end architecture;
