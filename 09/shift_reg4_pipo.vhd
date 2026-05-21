library ieee;
use ieee.std_logic_1164.all;

entity shift_reg4_pipo is
    port (
        clk : in  std_logic;
        d   : in  std_logic_vector(3 downto 0);  -- paralelni podatkovni ulazi
        q   : out std_logic_vector(3 downto 0)   -- paralelni izlazi
    );
end entity;

architecture rtl of shift_reg4_pipo is
begin
    process(clk)
    begin
        if rising_edge(clk) then
            q <= d;  -- svi bitovi učitavaju se istovremeno na uzlaznom bridu takta
        end if;
    end process;
end architecture;
