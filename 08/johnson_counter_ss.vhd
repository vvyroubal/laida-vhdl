library ieee;
use ieee.std_logic_1164.all;

-- 4-bit self-starting Johnson (twisted ring) counter (synchronous reset)
-- Modified feedback: D0 = NOT(Q3) AND (Q0 OR Q1 OR NOT(Q2))
-- Redirects state 0010 -> 0001 (valid) instead of 0010 -> 1001 (invalid),
-- breaking the single 8-state parasitic cycle. All invalid states converge
-- to the valid sequence within 8 clock steps.
entity johnson_counter_ss is
    port (
        clk : in  std_logic;
        rst : in  std_logic;
        q   : out std_logic_vector(3 downto 0)
    );
end entity;

architecture rtl of johnson_counter_ss is
    signal reg : std_logic_vector(3 downto 0) := (others => '0');
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                reg <= (others => '0');
            else
                reg <= reg(2 downto 0) &
                       (not reg(3) and (reg(0) or reg(1) or not reg(2)));
            end if;
        end if;
    end process;

    q <= reg;
end architecture;
