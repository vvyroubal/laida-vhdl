library ieee;
use ieee.std_logic_1164.all;

-- Moore FSM: sequence detector for "101"
-- States: S0 (initial), S1 (received '1'),
--         S2 (received '10'), S3 (received '101' -> y='1')
entity sequence_detector is
    port (
        clk : in  std_logic;
        rst : in  std_logic;
        x   : in  std_logic;
        y   : out std_logic
    );
end entity;

architecture rtl of sequence_detector is
    type state_t is (S0, S1, S2, S3);
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
                        if x = '1' then state <= S3; else state <= S0; end if;
                    when S3 =>
                        if x = '1' then state <= S1; else state <= S2; end if;
                end case;
            end if;
        end if;
    end process;

    y <= '1' when state = S3 else '0';
end architecture;
