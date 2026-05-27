-- UART receiver (RX), FSMD architecture.
-- Simplifications:
--   * 1 clock = 1 bit (no 16x oversampling; clock must equal the baud rate)
--   * 8 data bits, no parity, 1 stop bit (UART 8N1)
--   * Synchronous frame arrival (assumes input synchronisation)
-- The FSM has 3 states: IDLE, RECEIVE, STOP.
-- Datapath: an 8-bit shift register and a 3-bit bit counter.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uart_rx is
    port (
        clk, rst : in  std_logic;
        rx       : in  std_logic;
        data     : out std_logic_vector(7 downto 0);
        valid    : out std_logic
    );
end entity;

architecture fsmd of uart_rx is
    type state_t is (IDLE, RECEIVE, STOP);
    signal state, state_next         : state_t;
    signal shift_reg, shift_reg_next : std_logic_vector(7 downto 0);
    signal bit_cnt, bit_cnt_next     : unsigned(2 downto 0);
begin
    -- Sequential process: state register + datapath registers
    reg: process (clk, rst)
    begin
        if rst = '1' then
            state     <= IDLE;
            shift_reg <= (others => '0');
            bit_cnt   <= (others => '0');
        elsif rising_edge(clk) then
            state     <= state_next;
            shift_reg <= shift_reg_next;
            bit_cnt   <= bit_cnt_next;
        end if;
    end process;

    -- Combinational process: transition function + datapath operations
    nsl: process (state, rx, shift_reg, bit_cnt)
    begin
        -- defaults: hold
        state_next     <= state;
        shift_reg_next <= shift_reg;
        bit_cnt_next   <= bit_cnt;

        case state is
            when IDLE =>
                if rx = '0' then                       -- start bit detected
                    state_next   <= RECEIVE;
                    bit_cnt_next <= (others => '0');   -- prepare counter
                end if;

            when RECEIVE =>
                -- Shift rx into the MSB; LSB-first transmission means the
                -- first bit received (b0) ends up at position 0 after 8 shifts.
                shift_reg_next <= rx & shift_reg(7 downto 1);
                if bit_cnt = 7 then
                    state_next <= STOP;                -- last data bit received
                else
                    bit_cnt_next <= bit_cnt + 1;
                end if;

            when STOP =>
                state_next <= IDLE;                    -- always return to IDLE
        end case;
    end process;

    -- Outputs (Mealy-style valid: depends on state and rx)
    data  <= shift_reg;
    valid <= '1' when (state = STOP and rx = '1') else '0';
end architecture;
