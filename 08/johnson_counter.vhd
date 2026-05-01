library ieee;
use ieee.std_logic_1164.all;

-- 4-bit Johnson (twisted ring) counter with synchronous reset
entity johnson_counter is
    port (
        clk : in  std_logic;
        rst : in  std_logic;
        q   : out std_logic_vector(3 downto 0)
    );
end entity;

architecture rtl of johnson_counter is
    signal reg : std_logic_vector(3 downto 0) := (others => '0');
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                reg <= (others => '0');
            else
                reg <= (not reg(0)) & reg(3 downto 1);
            end if;
        end if;
    end process;

    q <= reg;
end architecture;
