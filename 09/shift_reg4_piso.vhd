library ieee;
use ieee.std_logic_1164.all;

entity shift_reg4_piso is
    port (
        clk  : in  std_logic;
        load : in  std_logic;                     -- '1': paralelno učitavanje, '0': pomak
        d    : in  std_logic_vector(3 downto 0);  -- paralelni podatkovni ulazi
        q_out: out std_logic                       -- serijski izlaz
    );
end entity;

architecture rtl of shift_reg4_piso is
    signal reg : std_logic_vector(3 downto 0) := (others => '0');
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if load = '1' then
                reg <= d;                             -- paralelno učitavanje
            else
                reg <= reg(2 downto 0) & '0';         -- pomak prema MSB, nula popunjava LSB
            end if;
        end if;
    end process;

    q_out <= reg(3);  -- serijski izlaz s MSB
end architecture;
