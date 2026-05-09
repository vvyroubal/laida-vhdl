library ieee;
use ieee.std_logic_1164.all;

-- 4-bit ring counter with synchronous reset (left-shift, one-hot)
entity ring_counter is
    port (
        clk : in  std_logic;
        rst : in  std_logic;
        q   : out std_logic_vector(3 downto 0)
    );
end entity;

architecture rtl of ring_counter is
    signal reg : std_logic_vector(3 downto 0) := "0001";
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                reg <= "0001";
            else
                reg <= reg(2 downto 0) & reg(3);
            end if;
        end if;
    end process;

    q <= reg;
end architecture;
