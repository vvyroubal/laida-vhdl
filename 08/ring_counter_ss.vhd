library ieee;
use ieee.std_logic_1164.all;

-- 4-bit self-starting ring counter (synchronous reset)
-- Modified feedback: D0 = NOR(Q0, Q1, Q2)
-- Identical to D0 = Q3 in the valid one-hot cycle; all invalid states
-- converge to the valid cycle within n clock steps without extra reset logic.
entity ring_counter_ss is
    port (
        clk : in  std_logic;
        rst : in  std_logic;
        q   : out std_logic_vector(3 downto 0)
    );
end entity;

architecture rtl of ring_counter_ss is
    signal reg : std_logic_vector(3 downto 0) := "0001";
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                reg <= "0001";
            else
                reg <= reg(2 downto 0) & not(reg(0) or reg(1) or reg(2));
            end if;
        end if;
    end process;

    q <= reg;
end architecture;
