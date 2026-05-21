library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- 4-bitni sinkroni binarni brojač sa sinkronim resetom
entity binary_counter is
    port (
        clk : in  std_logic;
        rst : in  std_logic;
        q   : out std_logic_vector(3 downto 0)
    );
end entity;

architecture rtl of binary_counter is
    signal count : unsigned(3 downto 0) := (others => '0');
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                count <= (others => '0');
            else
                count <= count + 1;
            end if;
        end if;
    end process;

    q <= std_logic_vector(count);
end architecture;
