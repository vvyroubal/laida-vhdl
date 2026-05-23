-- 4-bit synchronous up/down binary counter.
-- DIR = '0' counts up (0, 1, 2, ..., 15, 0, ...).
-- DIR = '1' counts down (0, 15, 14, ..., 1, 0, ...).
-- Synchronous reset (rst='1') forces the count to 0.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity up_down_counter_4bit is
    port (
        clk : in  std_logic;
        rst : in  std_logic;
        dir : in  std_logic;
        q   : out std_logic_vector(3 downto 0)
    );
end entity;

architecture rtl of up_down_counter_4bit is
    signal cnt : unsigned(3 downto 0) := (others => '0');
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                cnt <= (others => '0');
            elsif dir = '0' then
                cnt <= cnt + 1;
            else
                cnt <= cnt - 1;
            end if;
        end if;
    end process;

    q <= std_logic_vector(cnt);
end architecture;
