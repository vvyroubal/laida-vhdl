-- Moore traffic light controller with a 4-phase cycle.
-- Input TICK is a pulse from an external timer (e.g. 1 Hz); on a rising
-- clock edge with TICK = 1, the automaton advances to the next phase.
-- Outputs r, y, g individually drive the red, yellow, and green lamps.
-- State encoding is Gray (RED=00, RED_YELLOW=01, GREEN=11, YELLOW=10),
-- but the synthesis tool works directly with the enumerated type.

library ieee;
use ieee.std_logic_1164.all;

entity semafor is
    port (
        clk, rst : in  std_logic;
        tick     : in  std_logic;
        r, y, g  : out std_logic
    );
end entity;

architecture three_process of semafor is
    type state_t is (RED, RED_YELLOW, GREEN, YELLOW);
    signal state, state_next : state_t;
begin
    -- State register (asynchronous reset)
    reg: process (clk, rst)
    begin
        if rst = '1' then
            state <= RED;
        elsif rising_edge(clk) then
            state <= state_next;
        end if;
    end process;

    -- Transition function (delta)
    nsl: process (state, tick)
    begin
        state_next <= state;
        if tick = '1' then
            case state is
                when RED         => state_next <= RED_YELLOW;
                when RED_YELLOW  => state_next <= GREEN;
                when GREEN       => state_next <= YELLOW;
                when YELLOW      => state_next <= RED;
            end case;
        end if;
    end process;

    -- Output function (Moore: depends only on state)
    out_logic: process (state)
    begin
        r <= '0'; y <= '0'; g <= '0';
        case state is
            when RED         => r <= '1';
            when RED_YELLOW  => r <= '1'; y <= '1';
            when GREEN       => g <= '1';
            when YELLOW      => y <= '1';
        end case;
    end process;
end architecture;
