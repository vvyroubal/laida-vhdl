library ieee;
use ieee.std_logic_1164.all;

-- Mealyev KA: detektor niza "101"
-- Stanja: S0 (početno), S1 (primljeno '1'), S2 (primljeno '10')
-- Izlaz: y='1' u taktu kada je primljen završni '1' (S2, x='1')
entity mealy_detector is
    port (
        clk : in  std_logic;
        rst : in  std_logic;
        x   : in  std_logic;
        y   : out std_logic
    );
end entity;

architecture rtl of mealy_detector is
    type state_t is (S0, S1, S2);
    signal state : state_t := S0;
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                state <= S0;
            else
                case state is
                    when S0 =>
                        if x = '1' then state <= S1; else state <= S0; end if;
                    when S1 =>
                        if x = '0' then state <= S2; else state <= S1; end if;
                    when S2 =>
                        if x = '1' then state <= S1; else state <= S0; end if;
                end case;
            end if;
        end if;
    end process;

    -- Mealyev izlaz: ovisi o trenutnom stanju I trenutnom ulazu
    y <= '1' when state = S2 and x = '1' else '0';
end architecture;
