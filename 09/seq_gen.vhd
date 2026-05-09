library ieee;
use ieee.std_logic_1164.all;

-- Synchronous 6-state Gray-code sequence generator
-- Sequence: 000 -> 001 -> 011 -> 010 -> 110 -> 100 -> 000
-- Unreachable states 101 and 111 both return to 010 (from K-map don't-cares)
entity seq_gen is
    port (
        clk : in  std_logic;
        rst : in  std_logic;
        q   : out std_logic_vector(2 downto 0)
    );
end entity;

architecture rtl of seq_gen is
    signal state : std_logic_vector(2 downto 0) := "000";
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                state <= "000";
            else
                case state is
                    when "000" => state <= "001";
                    when "001" => state <= "011";
                    when "011" => state <= "010";
                    when "010" => state <= "110";
                    when "110" => state <= "100";
                    when "100" => state <= "000";
                    when others => state <= "010";
                end case;
            end if;
        end if;
    end process;

    q <= state;
end architecture;
