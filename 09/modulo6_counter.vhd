-- Modulo-6 counter cycling through the non-standard sequence
-- 0 -> 3 -> 7 -> 6 -> 1 -> 0. Unspecified states (2, 4, 5) are redirected
-- to state 6 on the next clock edge (safe-start mechanism).

library ieee;
use ieee.std_logic_1164.all;

entity modulo6_counter is
    port (
        clk : in  std_logic;
        rst : in  std_logic;
        q   : out std_logic_vector(2 downto 0)
    );
end entity;

architecture rtl of modulo6_counter is
    signal state : std_logic_vector(2 downto 0) := "000";
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                state <= "000";
            else
                case state is
                    when "000" => state <= "011";  -- 0 -> 3
                    when "011" => state <= "111";  -- 3 -> 7
                    when "111" => state <= "110";  -- 7 -> 6
                    when "110" => state <= "001";  -- 6 -> 1
                    when "001" => state <= "000";  -- 1 -> 0
                    when others => state <= "110"; -- safe start: 2/4/5 -> 6
                end case;
            end if;
        end if;
    end process;

    q <= state;
end architecture;
