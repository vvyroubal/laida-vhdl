library ieee;
use ieee.std_logic_1164.all;

entity shift_reg4_piso is
    port (
        clk  : in  std_logic;
        load : in  std_logic;                     -- '1': parallel load, '0': shift
        d    : in  std_logic_vector(3 downto 0);  -- parallel data inputs
        q_out: out std_logic                       -- serial output
    );
end entity;

architecture rtl of shift_reg4_piso is
    signal reg : std_logic_vector(3 downto 0) := (others => '0');
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if load = '1' then
                reg <= d;                             -- parallel load
            else
                reg <= reg(2 downto 0) & '0';         -- shift towards MSB, zero fills LSB
            end if;
        end if;
    end process;

    q_out <= reg(3);  -- serial output from MSB
end architecture;
